const fs = require('fs');
const os = require('os');
const path = require('path');
const process = require('process');
const spawn = require('child_process').spawn;
const tmp = os.tmpdir();
const pid = process.pid;

if (process.argv.length < 3) {
  console.error('This program requires a JSON file as input.');
  return;
}

if (
  process.argv.length < 4 ||
  !fs.statSync(process.argv[3]).isDirectory()
) {
  console.error('This program requires a folder as output.');
  return;
}

const file = process.argv[2];
const outdir = process.argv[3];
const answers = JSON.parse(fs.readFileSync(file));
let nfile = answers.answers.data.length;

answers.answers.data.forEach(a => {
  const infile = path.join(tmp, `sq-${pid}-${nfile}.html`);
  const zpad = (new Array(5 - (nfile+'').length)).join('0') + nfile;
  const url = a.questionURL.split('/').reverse()[0].substring(0, 200);
  const outfile = path.join(outdir, `${zpad}-${url}.md`);
  const answer = a.answer;

  nfile -= 1;
  console.log(`${nfile} of ${answers.answers.data.length}`);
  fs.writeFileSync(infile, answer);
  
  const prc = spawn(
    '/usr/bin/pandoc',
    [
      '--from=html',
      '--to=markdown',
      infile,
    ]
  );
  let markdown = '';
  
  prc.stdout.setEncoding('utf8');
  prc.stdout.on('data', function(data) {
    markdown = `${markdown}${data.toString()}`;
    a.answer = markdown;
    fs.writeFileSync(
      outfile,
      JSON.stringify(a, ' ', 2)
    )
  });
  prc.on('close', function(code) {
    //fs.unlink(infile);
  });
});

