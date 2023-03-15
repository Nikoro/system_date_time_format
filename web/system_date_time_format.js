const getDateTimeFormatPattern = (options) => {
    const getPatternForPart = (part) => {
        switch (part.type) {
            case 'day':
                return 'd'.repeat(part.value.length);
            case 'month':
                return 'M'.repeat(part.value.length);
            case 'year':
                return 'y'.repeat(part.value.length);
            case 'hour':
                return 'h'.repeat(part.value.length);
            case 'minute':
                return 'm'.repeat(part.value.length);
            case 'second':
                return 's'.repeat(part.value.length);
            case 'literal':
                return part.value;
            default:
                return '';
        }
    };

    return new Intl.DateTimeFormat(undefined, options).formatToParts(new Date())
        .map(getPatternForPart)
        .join('');
};


getDateFormat = () => getDateTimeFormatPattern({ dateStyle: 'short' });

getMediumDateFormat = () => getDateTimeFormatPattern({ dateStyle: 'medium' });

getLongDateFormat = () => getDateTimeFormatPattern({ dateStyle: 'long' });

getTimeFormat = () => getDateTimeFormatPattern({ timeStyle: 'short' });