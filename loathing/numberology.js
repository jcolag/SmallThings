var ascensions = 42;
var moon = 1;
var spleen = 0;
var level = 1;
var adventures = 40;

for (var i = 0; i < 100; i++) {
  var num = (i + ascensions + moon) * (spleen + level) + adventures;
  if (num % 100 == 69) {
    console.log(i);
  }
}

