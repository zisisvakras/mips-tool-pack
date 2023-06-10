/* File: cmdlineargs.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int checkint(char *);
void reverse(char *);

int main(int argc, char *argv[])
{ int sum = 0;   /* Initialize sum of integers in command line */
  while (--argc) {         /* Loop while arguments are present */
    if(checkint(*++argv))           /* Is argument an integer? */
      sum += atoi(*argv); /* Then, sum it into the accumulator */
    else {
      reverse(argv[0]); /* Else, reverse argument and print it */
      printf("Reversed argument: %s\n", argv[0]);
    }
  }                 /* Finally, print sum of integer arguments */
  printf("\nSum of integers given is: %d\n", sum);
  return 0;
}

int checkint(char *s)
{ char *start;
  while(*s == ' ' || *s == '\t') s++;    /* Eat all whitespace */
  if (*s == '-' || *s == '+') s++;             /* Eat one sign */
  start = s;                   /* Mark the begining of numbers */
  while(*s >= '0' && *s <= '9') s++;        /* Eat all numbers */
  return (*s == '\0' && start != s);
             /* Return if there where numbers and nothing else */
}

void reverse(char *s)
{ char c;
  int i, j;
  for (i=0, j=strlen(s)-1 ; i < j ; i++, j--) {
    c = s[i];  /* Visit string from start and end concurrently */
    s[i] = s[j];       /* and exchange characters in symmetric */
    s[j] = c;             /* positions until middle is reached */
  }
}
