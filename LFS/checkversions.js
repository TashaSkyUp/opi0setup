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

const { exec } = require('child_process');
for (var f in x){
  console.log(f);
  for (var c in x[f]){
    console.log(c);
    exec(c+" "+ f, (err, stdout, stderr) => {
       if (err) {console.log("some error");return;}

       // the *entire* stdout and stderr (buffered)
       //console.log(`stdout: ${stdout}`);
       //console.log(`stderr: ${stderr}`);
       var info = stdout+stderr
       console.log(info);
       found = /[0-9].[0-9]/.exec(string)
       console.log("found: "+found);
 
    });
  }
}
console.log(arg1);
console.log(arg2);
