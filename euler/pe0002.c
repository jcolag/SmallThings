#include <stdio.h>

int main (int argc, char *argv[])
{
	int a = 0,
	    b = 1,
	    c = 0,
	    max = 100,
	    show = 0,
	    count = 0,
	    total = 0;

	if (argc > 2)
	{
		show = 1;
	}
	if (argc > 1)
	{
		max = atoi(argv[1]);
	}
	while (a + b < max)
	{
		c = a + b;
		b = a;
		a = c;
		if (c % 2 == 0)
		{
			if (show)
			{
				printf ("%d\n", c);
			}
			count += 1;
			total += c;
		}
	}
	printf ("%d over %d elements.\n", total, count);
	return (max);
}

