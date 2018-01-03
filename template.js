function sd(n){
  if (n=="="){
    return 1;
  }
  if (n==" "){
    return 1; 
  }
  if (n==","){
    return 1;
  }
    return 0;
}
var arg1 = process.argv[2];
var arg2 = process.argv[3];
arg1=arg1.toString("utf8");
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function(data) {
var str = data;
state = "key";
key = "";
value ="";
index =0
var kvp=[];
kvp[index]= {};
kvp[index].key ="";
kvp[index].value="";
  for (var i = 0, len = str.length; i < len; i++) {
  n = str.charAt(i);
  
  if (state=="key"){  
    if (sd(n)){
      state="value";
//console.log("newkey:>"+key+"<");
    }else{
      key=key+n;
    }
  }else if (state == "value"){
    if (sd(n)){
      kvp[key]=value;
//console.log("newkey:>"+key+"<, newvalue:>"+value+"<");
      key="";value="";
      state="key";
      //index=index+1;
      //kvp[index]= {};

    }else{
      value=value+n;
    }

  }

  } 
  str=str.replace(/=/g,"+");
  process.stdout.write(arg1+"="+kvp[arg1]);

});

if(/(crap)*/.test("crap")){
}
//console.log(arg1);
//console.log(arg2);

