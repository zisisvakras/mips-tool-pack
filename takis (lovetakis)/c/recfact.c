/* File: recfact.c */
#include <stdio.h>
#define MAXN 12             /* Compute factorials up to MAXN */

int recfact(int);                    /* Prototype of recfact */

int main(void)
{ int n;                         /* For all n from 0 to MAXN */
  for (n=0 ; n <= MAXN ; n++)           /* Call function and */
    printf("%2d! = %d\n", n, recfact(n));    /* print result */
  return 0;
}

int recfact(int n)
{ if (!n)                                       /* If n == 0 */
    return 1;                                      /* 0! = 1 */
  else
    return n*recfact(n-1);                /* n! = n * (n-1)! */
} 

