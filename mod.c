#include <stdio.h>

int main (int argc, char *argv[])
{
 int m = 7;
 int n = 11;
 int i = 0;
 int max = 24;
 int out = 1;

 if (argc > 1)
 {
  m = atoi(argv[1]);
 }
 if (argc > 2)
 {
  n = atoi(argv[2]);
 }
 if (argc > 3)
 {
  max = atoi(argv[3]);
 }

 for (i=0;i<max;i++)
 {
  out *= m;
  out %= n;
  printf ("%d\t%d\n", i+1, out);
 }

 return 0;
}

