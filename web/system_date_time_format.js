// Single-digit fields distinguish numeric from zero-padded formats. September
// also distinguishes month names in locales where January has only one form.
const patternProbes = [
    new Date(Date.UTC(2006, 0, 3, 4, 5, 6)),
    new Date(Date.UTC(2006, 8, 7, 4, 5, 6)),
];

const singleDigitGregorianYear = new Date("0007-01-03T04:05:06Z");

function getDateTimeFormatPattern(options) {
    const formatter = new Intl.DateTimeFormat(undefined, { ...options, timeZone: "UTC" });
    const { locale, calendar, numberingSystem, hourCycle } = formatter.resolvedOptions();
    const samples = patternProbes.map(date => formatter.formatToParts(date));
    const zero = new Intl.NumberFormat(locale, { numberingSystem }).format(0);

    function numericField(symbol, type) {
        const padded = samples.some(parts =>
            parts.find(part => part.type === type)?.value.startsWith(zero));
        return padded ? symbol.repeat(2) : symbol;
    }

    function textField(type, symbol, widths) {
        // Month names can change grammatical form when formatted with a day.
        // Weekdays and eras also need the context of the whole date.
        const context = type === "month" ? { day: "numeric" } :
            { year: "numeric", month: "long", day: "numeric" };
        for (const width of widths) {
            const candidate = new Intl.DateTimeFormat(locale, {
                calendar, numberingSystem, timeZone: "UTC", ...context, [type]: width,
            });
            if (patternProbes.every((date, i) =>
                candidate.formatToParts(date).find(part => part.type === type)?.value ===
                samples[i].find(part => part.type === type)?.value)) {
                return symbol.repeat({ short: 3, long: 4, narrow: 5 }[width]);
            }
        }
        return null;
    }

    function field({ type, value }) {
        switch (type) {
            case "weekday": return textField(type, "E", ["long", "short", "narrow"]);
            case "day": return numericField("d", type);
            case "month":
                if (/^\p{Decimal_Number}+$/u.test(value)) return numericField("M", type);
                return textField(type, "M", options.dateStyle === "medium"
                    ? ["short", "long", "narrow"] : ["long", "short", "narrow"]);
            case "year": {
                if (calendar === "gregory" || calendar === "iso8601") {
                    const year = formatter.formatToParts(singleDigitGregorianYear)
                        .find(part => part.type === "year").value;
                    return "y".repeat(Array.from(year).length);
                }
                const numeric = new Intl.DateTimeFormat(locale, {
                    calendar, numberingSystem, timeZone: "UTC", year: "numeric",
                }).formatToParts(patternProbes[0]).find(part => part.type === "year");
                return numeric?.value === value ? "y" : "yy";
            }
            case "era": return textField(type, "G", ["short", "long", "narrow"]);
            case "hour": return numericField({ h11: "K", h12: "h", h23: "H", h24: "k" }[hourCycle], type);
            case "minute": return numericField("m", type);
            case "second": return numericField("s", type);
            case "dayPeriod": return "a";
            case "literal": {
                const escaped = value.replaceAll("'", "''");
                return /[a-z]/i.test(value) ? "'" + escaped + "'" : escaped;
            }
            default: return null;
        }
    }

    const fields = samples[0].map(field);
    return fields.includes(null) ? null : fields.join("");
}

globalThis.getDateFormat = () => getDateTimeFormatPattern({ dateStyle: "short" });
globalThis.getMediumDateFormat = () => getDateTimeFormatPattern({ dateStyle: "medium" });
globalThis.getLongDateFormat = () => getDateTimeFormatPattern({ dateStyle: "long" });
globalThis.getFullDateFormat = () => getDateTimeFormatPattern({ dateStyle: "full" });
globalThis.getTimeFormat = () => getDateTimeFormatPattern({ timeStyle: "short" });
