const msDay = 1000 * 60 * 60 * 24;
const lat = 40.8720809;
const long = -73.4228624;

function dayOfYear(date) {
  const offN = date.getTimezoneOffset();
  const start = new Date(date.getFullYear(), 0, 0);
  const offS = date.getTimezoneOffset();
  const time = date - start + ((offS - offN) * 60 * 1000);
  return Math.floor(time / msDay);
}

function msOfDay(date) {
  const hh = date.getHours();
  const mm = date.getMinutes();
  const ss = date.getSeconds();
  const ms = date.getMilliseconds();
  return ((hh * 60 + mm) * 60 + ss) * 1000 + ms;
}

function yearAngle(day, time) {
  return (2 * Math.PI / 365.25) * (day + time / msDay);
}

function declination(yearTh) {
  const decl = 0.396372 - 22.91327 * Math.cos(yearTh) + 4.02543 * Math.sin(yearTh) - 0.387205 * Math.cos(2 * yearTh) + 0.051967 * Math.sin(2 * yearTh) - 0.154527 * Math.cos(3 * yearTh) + 0.084798 * Math.sin(3 * yearTh);
  return decl / 180 * Math.PI;
}

function timeCorrection(yearTh) {
  const timeCorr = 0.004297 + 0.107029 * Math.cos(yearTh) - 1.837877 * Math.sin(yearTh) - 0.837378 * Math.cos(2 * yearTh) - 2.340475 * Math.sin(2 * yearTh);
  return timeCorr;
//  return timeCorr / 180 * Math.PI;
}

function solarHourAngle(time, long, timeCorr) {
  let hourAngle = ((time - msDay / 2) / msDay * 24 * 15 + long + timeCorr);
  if (hourAngle < 0) {
    hourAngle += 360;
  }
  
  return hourAngle / 180 * Math.PI;
}

function getZenith(lat, decl, hourAngle) {
  const zenith = Math.acos(Math.sin(lat) * Math.sin(decl) + Math.cos(lat) * Math.cos(decl) * Math.cos(hourAngle));
  return zenith;
}

function getAzimuth(decl, lat, zenith) {
  return Math.acos(Math.sin(decl) - Math.sin(lat) * Math.cos(zenith)) / (Math.cos(lat) * Math.sin(zenith));
}

let now = new Date('Jun 10 2019');

for (let h = 0; h < 24; h++) {
  now.setHours(h);
  console.log(now);

  const day = dayOfYear(now);
//  console.log(day);
  const time = msOfDay(now);
//  console.log(time);
  const yearTh = yearAngle(day, time);
//  console.log(yearTh * 180 / Math.PI);
  const decl = declination(yearTh);
//  console.log(decl * 180 / Math.PI);
  const timeCorr = timeCorrection(yearTh);
//  console.log(timeCorr);
  const hourAngle = solarHourAngle(time, long, timeCorr);
//  console.log(hourAngle * 180 / Math.PI);
  const zenith = getZenith(lat, decl, hourAngle);
  console.log(zenith * 180 / Math.PI);
  const elev = Math.PI / 2 - zenith;
  const azimuth = getAzimuth(decl, lat, zenith);

  console.log(azimuth / Math.PI * 180);
  console.log(elev / Math.PI * 180);
}

