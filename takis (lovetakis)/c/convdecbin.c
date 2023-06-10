/* File: convdecbin.c */
#include <stdio.h>
#define ERROR -1       /* Return value for illegal character */

int getinteger(int base)
{ char ch; /* No need to declare ch as int - no EOF handling */
  int val = 0;                    /* Initialize return value */
  while ((ch = getchar()) != '\n')    /* Read up to new line */
    if (ch >= '0' && ch <= '0'+base-1)   /* Legal character? */
      val = base*val + (ch-'0');      /* Update return value */
    else
      return ERROR;                /* Illegal character read */
  return val; /* Everything OK - Return value of number read */
}

int main(void)
{ int n, digs[32], ind = 0;
  printf("Please, give a binary number:  ");
  n = getinteger(2);                   /* Read binary number */
  if (n == ERROR) {
    printf("Sorry, illegal character\n");  return 1; }
  else                      /* Print decimal value of number */
    printf("Decimal equivalent is:         %d\n", n);
  printf("Please, give a decimal number: ");
  n = getinteger(10);                 /* Read decimal number */
  if (n == ERROR) {
    printf("Sorry, illegal character\n");  return 1; }
  else {                  /* Convert number to binary digits */
    while (n) {           /* Repeat until number equals to 0 */
      digs[ind++] = n%2;        /* New digit is number mod 2 */
      n = n/2;                     /* New number is number/2 */
    }
    printf("Binary equivalent is:          ");
    while (ind--)           /* Print digits in reverse order */
      printf("%d", digs[ind]);
    printf("\n");
  }
  return 0;
}
