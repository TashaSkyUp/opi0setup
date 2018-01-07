//function example
const pipe = false;
function sd(n){
}
//setup common vars
var arg1 = process.argv[2];
var arg2 = process.argv[3];

//for pipe
if (pipe){
	process.stdin.resume();
	process.stdin.setEncoding('utf8');
	process.stdin.on('data', function(data) {
		process.stdout.write(data);
	});
}

//regex as if statment example
if(/(crap)*/.test("crap")){
}
//import data
var x=require('./data/reqver.json');//or require('data');
//console.log(x["-v"]);

const execSync = require('child_process').execSync;
//const { exec } = require('child_process');

var red   = '\033[4m\033[1;31m';
var green = '\033[1;32m';
var nc = '\033[0m'; // No Color

for (var f in x){
	console.log("");
	console.log("Checking "+ f);

		var cmd = x[f].c0 +" "+ x[f].c1 + " 2>&1";
		leastVersion = x[f].ver;		
		console.log("using " +cmd);
		console.log("checking " +f+"... for: "+ leastVersion);
		try {
			var info = execSync(cmd);      
		} catch (err2) {
			console.log("err: "+err2.stderr);
			console.log("out: "+err2.stdout);      
			found = "";
			//err.stdout;
			//err.stderr;
			//err.pid;
			//err.signal; 
			//err.status;
			// etc
			console.log(red+"Error: "+f+" not found!"+nc);
			var stop = true; break;
		}
		//console.log("info: "+info);

		//found = /((([a-Z]*))([0-9]*)(.[0-9]*)*)+/.exec(info);

		found = /[0-9]+\.[0-9]+\.*[0-9]*/.exec(info);console.log("need: "+leastVersion+", found: "+found);
		
		leastVersionShort=/[0-9]+\.[0-9]+/.exec(leastVersion);
		foundVersionShort=/[0-9]+\.[0-9]+/.exec(found);

		leastVersionShort=leastVersion[0].toString().replace(/\./,"");
		foundVersionShort=found[0].toString().replace(/\./,"");
		
		
		if (+leastVersionShort<+foundVersionShort){
			console.log(green+"..ok.."+nc);
			
			}else{
				console.log(red+"Errpr:"+leastVersionShort+":"+foundVersionShort+nc);
				var stop = true; break;
		}


}
