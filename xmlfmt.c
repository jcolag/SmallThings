#include <stdio.h>
#include <string.h>

int main (void)
{
 char	*first = "erxml:: ";
 char	*other = " ";
 char	 inbuf[128];
 int	 lenF,
	 lenO;

 lenF = strlen (first);
 lenO = strlen (other);

 fgets (inbuf, 78-lenF, stdin);
 fprintf (stdout, "%s%s\n", first, inbuf);
 while (!feof(stdin))
	{
	 fgets (inbuf, 78-lenO, stdin);
	 fprintf (stdout, "%s%s\n", other, inbuf);
	}
 return (0);
}

