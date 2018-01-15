var date = new Date();
var offset = date.getTimezoneOffset();
var offsetHours = Math.trunc(offset / 60);
var offsetMinutes = offset - offsetHours * 60;
var minOptions = { minimumIntegerDigits: 2 };
var tz = "UTC" + -offsetHours + ":" + offsetMinutes.toLocaleString('en-US', minOptions);
console.log(tz);
console.log(date.toLocaleString("en-US", { timeZone: tz }));
