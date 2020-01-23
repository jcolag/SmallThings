const strings = [
  'Čapek',
  'Capej',
  'Capel',
  'Brontë',
  'Brontd',
  'Brontf',
];
const sortedStrings = strings.sort((a,b) => {
  const aNorm = a.normalize('NFD').replace(/[\u0300-\u036f]/g, '');
  const bNorm = b.normalize('NFD').replace(/[\u0300-\u036f]/g, '');
  return aNorm < bNorm ? -1 : 1;
});
console.log(sortedStrings);

