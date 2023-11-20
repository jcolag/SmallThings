const unidecode = require('unidecode-plus');
const args = process.argv.join(' ');

console.log(unidecode(args));

