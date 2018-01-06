#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <time.h>

struct	termios	iosettings;

char	digits[10],
	formula[20];

void shuffle (char * array, int len, int times);
int  randval (int base, int max);
void numberinsert (char * where, int num);
void makeformula (char * array);
void printformula (char * calc, char * subst, int tries);
int  board (void);
int  play (void);
int  playerror (int errval, char letter, int digit);
void printresult (int tries);
void set_keypress (void);
void reset_keypress (void);
int  get_guess (char * string, char * letter, char * digit, char * digits);

int  randval (int base, int max)
{
 struct timespec time;
 int ret = clock_gettime(CLOCK_REALTIME, &time);
 if (ret == 0)
    {
     return 0;
    }
 return (time.tv_nsec % max + base);
}

void shuffle (char * array, int len, int times)
{
 int	i, w;
 char	t;

 for (i=0;i<len*times;i++)
	{
	 w = randval (0, len);
	 t = array[w];
	 array[w] = array[i%len];
	 array[i%len] = t;
	}
}

void numberinsert (char * where, int num)
{
 long	sample;
 int	power, i;

 power = 0;
 for (sample=1;sample<num;sample*=10)
	++ power;
 for (i=0;i<power;i++)
	{
	 num = num % sample;
	 sample /= 10;
	 *(where + i) = num / sample;
	}
}

void makeformula (char * array)
{
 int	a, b1, b2, s1, s2, tot;

 a = randval (200, 800);
 b1 = randval (2, 8);
 s1 = a * b1;
 b2 = randval (2, 8);
 s2 = a * b2;
 if (s1 < 1000 || s2 < 1000)
	{
	 makeformula (array);
	 return;
	}
 tot = s2 * 10 + s1;

 numberinsert (array, a);
 array[3] = b2;
 array[4] = b1;
 numberinsert (&array[5], s1);
 numberinsert (&array[9], s2);
 numberinsert (&array[13], tot);
 return;
}

void printformula (char * calc, char * subst, int tries)
{
 if (tries >= 0)
	printf ("[Tries:  %d]\n", tries);
 printf ("\t    %c %c %c\n", subst[calc[0]], subst[calc[1]], subst[calc[2]]);
 printf ("\t   x  %c %c\n", subst[calc[3]], subst[calc[4]]);
 printf ("\t  -------\n");
 printf ("\t  %c %c %c %c\n", subst[calc[5]], subst[calc[6]], subst[calc[7]],
	subst[calc[8]]);
 printf ("\t%c %c %c %c\n", subst[calc[9]], subst[calc[10]], subst[calc[11]],
	subst[calc[12]]);
 printf ("\t---------\n");
 printf ("\t%c %c %c %c %c\n\n", subst[calc[13]], subst[calc[14]],
	subst[calc[15]], subst[calc[16]], subst[calc[17]]);
 if (tries >= 0)
	printf ("Guess:  ");
}

int board (void)
{
 int	i;

 for (i=0;i<sizeof(digits);i++)
	digits[i] = 'a' + i;
 memset (formula, 0, sizeof (formula));
 makeformula (formula);
 shuffle (digits, sizeof (digits), 3);
 for (i=0;i<sizeof(formula);i++)
	digits[formula[i]] = toupper (digits[formula[i]]);
 for (i=0;i<sizeof(digits);i++)
	if (islower (digits[i]))
		digits[i] = '\000';
 return (0);
}

int playerror (int errval, char letter, int digit)
{
 switch (errval)
	{
	 case 1:
		printf ("\n ** Invalid Letter! **\n\n");
		break;
	 case 2:
		printf ("\n ** Invalid Digit! **\n\n");
		break;
	 case 3:
		printf ("\n ** %c is already solved! **\n\n", letter);
		break;
	 case 4:
		printf ("\n ** %d is already placed! **\n\n", digit);
		break;
	 case 0:
	 default:
		break;
	}
 return (errval);
}

int play (void)
{
 int	tries = 0,
	go = 1,
	i,
	status;
 char	string[80],
	letter,
	digit;

 board ();
 while (go)
	{
	 go = 0;
	 printformula (formula, digits, tries);
	 memset (string, 0, sizeof (string));
	 fgets (string, sizeof (string) - 1, stdin);
	 status = get_guess (string, &letter, &digit, digits);
	 if (go = playerror (0 - status, letter, digit))
		continue;
	 printf (" %c = %d ?  ", letter, digit);
	 if (digits[digit] == letter)
		{
		 printf ("Correct!\n\n");
		 digits[digit] = digit + '0';
		}
	 else	{
		 printf ("Incorrect.\n");
		 ++ tries;
		}
	 for (i=0;i<10;i++)
		if (isalpha (digits[i]))
			go = 1;
	}
 printformula (formula, digits, -1);
 printresult (tries);
 fgets (string, sizeof (string) - 1, stdin);
 return (strchr (string, 'y') || strchr (string, 'Y'));
}

void printresult (int tries)
{
 printf ("\nPuzzle solved with %d error%c. That's ", tries, tries!=1?'s':'\0');
 if (tries > 9)
	printf ("not serious.");
 else if (tries > 4)
	printf ("bad!");
 else if (tries == 4)
	printf ("not too bad...");
 else if (tries == 3)
	printf ("not bad.");
 else if (tries == 2)
	printf ("good.");
 else if (tries == 1)
	printf ("very good!");
 else	printf ("perfect!");
 printf (" Start a new game?  ");
 return;
}

int  get_guess (char * string, char * letter, char * digit, char * digits)
{
 int	i;

 string[0] = toupper (string[0]);
 if (!isalpha (string[0]) || string[0] > 'J')
	return (-1);
 if (!isdigit (string[1]))
	return (-2);
 *letter = string[0];
 for (i=0;i<10;i++)
	if (digits[i] == *letter)
		break;
 if (i == 10)
	return (-3);
 *digit = string[1] - '0';
 if (digits[*digit] && !isalpha (digits[*digit]))
	return (-4);
 return (0);
}

void set_keypress (void)
{
 struct	termios	newio;
 int	status;

 tcgetattr (0, &newio);
 newio = iosettings;
 newio.c_lflag &= (~ICANON);
 newio.c_cc[VTIME] = 0;
 newio.c_cc[VMIN] = 1;
 status = tcsetattr (0, TCSANOW, &newio);
 if (status < 0)
	{
	 perror ("Argh!");
	 exit (-1);
	}
 return;
}

void reset_keypress (void)
{
 tcsetattr (0, TCSANOW, &iosettings);
 return;
}

int main (void)
{
 int	cont;

/* set_keypress (); */
 do	cont = play ();
 while (cont);
/* reset_keypress (); */
 return (0);
}

