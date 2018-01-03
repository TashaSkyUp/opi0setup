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
var x=require('./data/reqver.json');//or require('data');
console.log(x["-v"]);

const execSync = require('child_process').execSync;
//const { exec } = require('child_process');

for (var f in x){
  console.log(f);
  for (var c in x[f]){
    console.log("checking " +c+"...");
    try {
       execSync(c+" "+ f, (err, stdout, stderr) => {
       if (err) {console.log("some error");return;}

       // the *entire* stdout and stderr (buffered)
       //console.log(`stdout: ${stdout}`);
       //console.log(`stderr: ${stderr}`);
       var info = stdout+stderr
       console.log("info: "+info);
       found = /[0-9](.[0-9])*/.exec(info)
       console.log("exec: "+c+", found: "+found);
      });
    } catch (err) {
      err.stdout;
      err.stderr;
      err.pid;
      err.signal;
      err.status;
      // etc
    }
      
   
   
  }
}
console.log(arg1);
console.log(arg2);
