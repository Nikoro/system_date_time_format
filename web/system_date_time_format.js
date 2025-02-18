const getDateTimeFormatPattern = (options) => {
    const parts = new Intl.DateTimeFormat(void 0, options).formatToParts(new Date());
    const hasDayPeriod = parts.some(part => part.type == "dayPeriod");
    return parts.map(part => {
        switch (part.type) {
            case "weekday": return "EEEE";
            case "day": return "d".repeat(part.value.length);
            case "month": return "M".repeat(Math.min(4, part.value.length));
            case "year": return "y".repeat(part.value.length);
            case "hour": return hasDayPeriod ? "h" : "HH";
            case "minute": return "m".repeat(part.value.length);
            case "second": return "s".repeat(part.value.length);
            case "literal": return part.value;
            case "dayPeriod": return "a";
            default: return "";
        }
    })
    .join("");
};

const getDateFormat = () => getDateTimeFormatPattern({ dateStyle: "short" });
const getMediumDateFormat = () => getDateTimeFormatPattern({ dateStyle: "medium" });
const getLongDateFormat = () => getDateTimeFormatPattern({ dateStyle: "long" });
const getFullDateFormat = () => getDateTimeFormatPattern({ dateStyle: "full" });
const getTimeFormat = () => getDateTimeFormatPattern({ timeStyle: "short" });
