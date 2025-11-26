const getDateTimeFormatPattern = (options) => {
    const parts = new Intl.DateTimeFormat(void 0, options).formatToParts(new Date());
    const hasDayPeriod = parts.some(part => part.type === "dayPeriod");
    return parts.map(part => {
        switch (part.type) {
            case "weekday": return "EEEE";
            case "day": return "d".repeat(part.value.length);
            case "month": return "M".repeat(Math.min(4, part.value.length));
            case "year": return "y".repeat(part.value.length);
            case "hour": return hasDayPeriod ? "h".repeat(part.value.length) : "H".repeat(part.value.length);
            case "minute": return "m".repeat(part.value.length);
            case "second": return "s".repeat(part.value.length);
            case "literal": return part.value;
            case "dayPeriod": return "a";
            default: return "";
        }
    })
    .join("");
};

getDateFormat = () => getDateTimeFormatPattern({ dateStyle: "short" });
getMediumDateFormat = () => getDateTimeFormatPattern({ dateStyle: "medium" });
getLongDateFormat = () => getDateTimeFormatPattern({ dateStyle: "long" });
getFullDateFormat = () => getDateTimeFormatPattern({ dateStyle: "full" });
getTimeFormat = () => getDateTimeFormatPattern({ timeStyle: "short" });
