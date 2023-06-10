/* File: powers.c */
#include <stdio.h>
#define MAXM 4          /* Maximum base of powers to compute */
#define MAXN 6                           /* Maximum exponent */

int power(int, int);                   /* Prototype of power */

int main(void)
{ int m, n, p;
  for (m=2 ; m <= MAXM ; m++)           /* Start from base 2 */
    for (n=2 ; n <= MAXN ; n++) {   /* Start from exponent 2 */
       p = power(m,n);                /* Call power function */
       printf("%d^%d = %d\n", m, n, p);
    }
  return 0;
}

int power(int base, int n)
{ int p;
  for (p=1 ; n > 0 ; n--)                /* base^n equals to */
    p *= base;         /* base * base * ... * base (n times) */
  return p;                                 /* Return result */
}
