#include <stdio.h>

    int main(int argc, char **argv)
    {
  	FILE *myFile;
  	char buf[4];
        myFile = fopen ("/khash","r");
  	if (myFile != NULL){
	printf("%i",argc);
        while (!feof (test_file)){
		for(int i=1;i<argc;i++){ 
	  fgets (buf, sizeof (buf), test_file); 
          printf("%s",argv[i]);
	  puts (buf); 
		}
	}
	}
    }
  else
    {
      printf ("Error opening file: %s\n", strerror (errno));
      exit (EXIT_FAILURE);
    }
  return 0;
