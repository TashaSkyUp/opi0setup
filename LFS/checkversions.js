//function example
function sd(n){
}
//setup common vars
var arg1 = process.argv[2];
var arg2 = process.argv[3];

// for pipe
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function(data) {
  process.stdout.write(data);
});

//regex as if statment example
if(/(crap)*/.test("crap")){
}

const { exec } = require('child_process');
exec('cat *.js bad_file | wc -l', (err, stdout, stderr) => {
  if (err) {
    // node couldn't execute the command
    return;
  }

  // the *entire* stdout and stderr (buffered)
  console.log(`stdout: ${stdout}`);
  console.log(`stderr: ${stderr}`);
});

console.log(arg1);
console.log(arg2);
