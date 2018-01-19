#include <stdio.h>

int main (int argc, char *argv[])
{
 int max = 10,
     total = 0,
     i;

 if (argc > 1)
 {
  max = atoi(argv[1]);
 }

 for (i = 1; i < max; i++)
 {
  if (i % 3 == 0 || i % 5 == 0)
  {
   total += i;
  }
 }
 printf ("%d -> %d\n", max, total);
 return total;
}
