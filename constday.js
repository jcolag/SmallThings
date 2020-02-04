if (process.argv.length < 3) {
  console.error("We need a number to work this out.");
  return;
}

const arg = process.argv[2];
let n = Number(arg);

if (arg !== n.toString()) {
  console.error("The argument needs to be a number.");
  return;
}

if (n < 1 || n >= 13) {
  console.error("Until we add scaling code, the number needs to be greater than 1 and less than 13.");
  return;
}

let date = new Date();
const nMonth = Math.trunc(n);
const daysInMonth = new Date(date.getYear(), nMonth, 0).getDate();

date.setMonth(nMonth - 1);
n -= nMonth;
n *= daysInMonth;

const dayOfMonth = Math.trunc(n);

date.setDate(dayOfMonth + 1);
n -= dayOfMonth;
n *= 24;

const hourOfDay = Math.trunc(n);

date.setHours(hourOfDay);
n -= hourOfDay;
n *= 60;

const minuteOfHour = Math.trunc(n);

date.setMinutes(minuteOfHour);
n -= minuteOfHour;
n *= 60;

const secondOfMinute = Math.trunc(n);

date.setSeconds(secondOfMinute);
n -= secondOfMinute;
console.log(date.toString());
console.log(`${n} of a second remaining.`);

