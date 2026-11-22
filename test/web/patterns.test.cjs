const assert = require("node:assert/strict");
const { readFileSync } = require("node:fs");
const { join } = require("node:path");
const { test } = require("node:test");
const vm = require("node:vm");

for (const file of ["system_date_time_format.js", "system_date_time_format.min.js"]) {
    const script = new vm.Script(readFileSync(join(__dirname, "../../web", file), "utf8"));

    function browser(locale, now = "2026-11-22T11:33:00Z") {
        class BrowserDate extends Date {
            constructor(...args) {
                super(...(args.length ? args : [now]));
            }
        }
        function DateTimeFormat(requestedLocale, options) {
            return new Intl.DateTimeFormat(requestedLocale ?? locale, options);
        }
        const context = vm.createContext({
            Date: BrowserDate, Intl: { DateTimeFormat, NumberFormat: Intl.NumberFormat },
        });
        script.runInContext(context);
        return context;
    }

    test(file + " keeps all date and time widths stable throughout the year", () => {
        for (const now of ["2026-01-02T01:03:00Z", "2026-05-12T10:11:00Z", "2026-11-22T11:33:00Z"]) {
            const api = browser("en-US", now);
            assert.equal(api.getDateFormat(), "M/d/yy");
            assert.equal(api.getMediumDateFormat(), "MMM d, y");
            assert.equal(api.getLongDateFormat(), "MMMM d, y");
            assert.equal(api.getFullDateFormat(), "EEEE, MMMM d, y");
            // ICU versions use either an ordinary or a narrow no-break space before AM/PM.
            assert.match(api.getTimeFormat(), /^h:mm[ \u202f]a$/u);
        }
    });

    test(file + " distinguishes padded numbers, month forms and literal words", () => {
        assert.equal(browser("en-GB").getDateFormat(), "dd/MM/y");
        assert.equal(browser("pl-PL").getLongDateFormat(), "d MMMM y");
        assert.equal(browser("es-ES").getLongDateFormat(), "d' de 'MMMM' de 'y");
        assert.equal(browser("ja-JP").getLongDateFormat(), "y年M月d日");
        assert.match(browser("sr").getLongDateFormat(), /MMMM/);
        assert.equal(browser("fi-FI").getFullDateFormat(), "EEEE d. MMMM y");
        assert.equal(browser("zh-u-ca-chinese").getFullDateFormat(), null);
    });

    test(file + " preserves the browser's hour cycle", () => {
        assert.equal(browser("en-GB").getTimeFormat(), "HH:mm");
        assert.match(browser("en-US-u-hc-h11").getTimeFormat(), /^K:mm[ \u202f]a$/u);
        assert.equal(browser("en-US-u-hc-h24").getTimeFormat(), "kk:mm");
    });
}
