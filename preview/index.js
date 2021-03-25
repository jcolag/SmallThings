const fs = require('fs');
const he = require('he');
const previewLink = require('preview-link');

const url = [
  'https://john.colagioia.net/blog/2020/04/02/trek-menagerie-2.html',
  'https://github.com/jcolag/Bicker',
  "https://en.wikipedia.org/wiki/Schitt's_Creek",
  'https://www.amazon.com/dp/B00T3ER7QO',
  'https://twitter.com/ElBloombito/status/1242544357300977670',
  'https://archive.org/details/Stardrifter/street-candles-09.mp3',
  'https://weworkremotely.com/remote-jobs/orum-full-stack-engineer',
  'https://stackoverflow.com/questions/10073699/pad-a-number-with-leading-zeros-in-javascript#10073788',
  'https://getpocket.com/explore/item/bill-withers-the-soul-man-who-walked-away',
  'https://www.nytimes.com/interactive/2020/04/03/science/coronavirus-genome-bad-news-wrapped-in-protein.html',
  'https://getpocket.com/explore/item/this-is-what-your-overactive-brain-needs-to-get-a-good-night-s-sleep',
  'https://getpocket.com/explore/item/it-s-a-superpower-how-walking-makes-us-healthier-happier-and-brainier',
];

let html = '<html><head><title>Previews</title></head><body>'
  + '<style>.preview{border:1px solid black;border-radius:2em;'
  + 'margin-bottom:1em;margin-left:25%;min-height:18em;padding:1em;'
  + 'position:relative;width:50%;}'
  + '.preview img{display:block;float:left;margin-right:1em;width:100px;}'
  + '</style>';
let count = 0;

for (let i = 0; i < url.length; i++) {
  previewLink(url[i])
    .then(res => {
      if (res.html !== null) {
        html = html + `<p>${url[i]}</p>`
          + '<div class="preview">'
          + he.decode(res.html)
          + '</div>';
      }
      count += 1;
      if (count === url.length) {
        html = html + '</body></html>';
        fs.writeFileSync('test.html', html);
        console.log('Done!');
      }
    })
    .catch(err => {
      console.log(err);
      count += 1;
    });
}

