#include <stdio.h>

    int main(int argc, char **argv)
    {
  	FILE *myFile;
  	char buf[4];
        myFile = fopen ("/khash","r");
	    
  	if (myFile != NULL){
        while (!feof (myFile)){
	
	for(int i=1;i<argc;i++){ 
	  
	}      
		fgets (buf, sizeof (buf), myFile); 
          printf("%s",buf);
	  //puts (buf);
		
	}
	}
    
  else
    {
      //printf ("Error opening file: %s\n", strerror (errno));
      exit (0);
    }
  return 1;
}
