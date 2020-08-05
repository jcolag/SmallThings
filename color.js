function crop(n) {
  return Math.floor(10 * (n<0 ? 0 : (n<255 ? n : 255))) / 10;
}

function AdjustChannelByMatrix(c, m, ch) {
  var offsets = {
    r: 0,
    g: 5,
    b: 10,
    a: 15
  };
  var i0 = 0 + offsets[ch];
  var i1 = 1 + offsets[ch];
  var i2 = 2 + offsets[ch];
  var i3 = 3 + offsets[ch];
  var i4 = 4 + offsets[ch];

  return crop(
    c.R * m[i0] +
    c.G * m[i1] +
    c.B * m[i2] +
    c.A * m[i3] +
    m[4]
  );
}

function AdjustColorByMatrix(c, m) {
    return({
      R: AdjustChannelByMatrix(c, m, 'r'),
      G: AdjustChannelByMatrix(c, m, 'g'),
      B: AdjustChannelByMatrix(c, m, 'b'),
      A: AdjustChannelByMatrix(c, m, 'a')
    });
};

var Blind = {
  'Normal': [
    1,0,0,0,0,
    0,1,0,0,0,
    0,0,1,0,0,
    0,0,0,1,0,
    0,0,0,0,1
  ],
  'Protanopia': [
    0.567,0.433,0,0,0,
    0.558,0.442,0,0,0,
    0,0.242,0.758,0,0,
    0,0,0,1,0,
    0,0,0,0,1
  ],
  'Protanomaly': [
    0.817,0.183,0,0,0,
    0.333,0.667,0,0,0,
    0,0.125,0.875,0,0,
    0,0,0,1,0,
    0,0,0,0,1
  ],
  'Deuteranopia': [
    0.625,0.375,0,0,0,
    0.7,0.3,0,0,0,
    0,0.3,0.7,0,0,
    0,0,0,1,0,
    0,0,0,0,1
  ],
  'Deuteranomaly': [
    0.8,0.2,0,0,0,
    0.258,0.742,0,0,0,
    0,0.142,0.858,0,0,
    0,0,0,1,0,
    0,0,0,0,1
  ],
  'Tritanopia': [
    0.95,0.05,0,0,0,
    0,0.433,0.567,0,0,
    0,0.475,0.525,0,0,
    0,0,0,1,0,
    0,0,0,0,1
  ],
  'Tritanomaly': [
    0.967,0.033,0,0,0,
    0,0.733,0.267,0,0,
    0,0.183,0.817,0,0,
    0,0,0,1,0,
    0,0,0,0,1
  ],
  'Achromatopsia': [
    0.299,0.587,0.114,0,0,
    0.299,0.587,0.114,0,0,
    0.299,0.587,0.114,0,0,
    0,0,0,1,0,
    0,0,0,0,1
  ],
  'Achromatomaly': [
    0.618,0.320,0.062,0,0,
    0.163,0.775,0.062,0,0,
    0.163,0.320,0.516,0,0,
    0,0,0,1,0,
    0,0,0,0,0]
};

var r = Math.floor(Math.random() * 256);
var g = Math.floor(Math.random() * 256);
var b = Math.floor(Math.random() * 256);
var color = { R: r, G: g, B: b, A: 255 };
var types = Object.keys(Blind);
Object.keys(Blind).forEach(b => {
  var blind = AdjustColorByMatrix(color, Blind[b]);
  var text = JSON.stringify(blind);
  console.log(`${b}:  ${text}`);
});

