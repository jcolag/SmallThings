#include <stdio.h>
#include <string.h>

int main (int argc, char *argv[], char *envp[])
{
 char s[256], *c;
 long res;

 fscanf (stdin, "%[^\n]\n", s);
 c = strstr (s, argv[1]);
 if (c > s)
	{
	 res = (int) (c - s);
	 printf ("%d-%d", (int)res, (int)res+4);
	}
 return (0);
}

