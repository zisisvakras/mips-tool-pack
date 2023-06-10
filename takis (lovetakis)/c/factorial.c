/* File: factorial.c */
#include <stdio.h>
#define MAXN 12             /* Compute factorials up to MAXN */

int factorial(int n)                  /* No prototype needed */
{ int f;
  for (f=1 ; n > 0 ; n--)       /* Initialize factorial to 1 */
    f *= n;        /* Multiply into factorial n, n-1, ..., 1 */
  return f;                                 /* Return result */
}

int main(void)
{ int n;                         /* For all n from 1 to MAXN */
  for (n=1 ; n <= MAXN ; n++)           /* Call function and */
    printf("%2d! = %d\n", n, factorial(n));  /* print result */
  return 0;
}

