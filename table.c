#include <stdio.h>
#include <math.h>

void mult_table(int);

int main(int argc, char **argv) {
  int size = 100;

  if (argc > 1) {
    sscanf(argv[1], "%d", &size);
  }

  mult_table(size);
}

void mult_table(int size) {
  int i, j, len;
  char fmt[100];

  len = trunc(log10(size * size)) + 2;
  sprintf(fmt, "%%%dd", len);
  for (i = 1; i <= size; i++) {
    for (j = 1; j <= size; j++) {
      printf(fmt, i * j);
    }
    printf("\n");
  }
}
