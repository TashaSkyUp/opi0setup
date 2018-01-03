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

console.log(arg1);
console.log(arg2);
