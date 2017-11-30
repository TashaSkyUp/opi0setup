#include <stdio.h>

    int main(int argc, char **argv)
    {
  	FILE *test_file;
  	char buf[4096];
  	if ( (test_file = fopen ("/var/log/Xorg.0.log", 
"r")) != NULL) printf("%i",argc);
    {
      while (!feof (test_file))	for(int 
i=1;i<argc;i++)
	{ {
	  fgets (buf, sizeof (buf), test_file); 
printf("%s",argv[i]);
	  puts (buf); }
	}    }
    }
  else
    {
      printf ("Error opening file: %s\n", strerror 
(errno));
      exit (EXIT_FAILURE);
    }
  return 0;
