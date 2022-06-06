const production = process.env.NODE_ENV === 'production';

console.log(`[${process.env.NODE_ENV}]`);
console.log(process.env.NODE_ENV); // production
console.log(typeof process.env.NODE_ENV); // string
console.log(typeof 'production'); // string
console.log(production) // false
