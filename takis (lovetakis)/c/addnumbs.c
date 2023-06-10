/* File: addnumbs.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *addnumbs(char *, char *);

int main(int argc, char *argv[])
{ char *sum;
  if (argc != 3) {               /* Run with exactly two arguments */
    printf("Usage: %s <numb1> <numb2>\n", argv[0]); return 1; }
  if ((sum = addnumbs(argv[1], argv[2])) == NULL) { /* Compute sum */
    printf("Sorry, a memory problem occurred\n"); return 1; }
  printf("%s + %s = %s\n", argv[1], argv[2], sum);
  free(sum);                  /* Free memory malloc'ed by addnumbs */
  return 0;
}

char *addnumbs(char *s1, char *s2)
{ int i, j, k, d1, d2, sum, carry;
  char *s3, *tmp, *result;
  i = strlen(s1)-1;     /* Index to last character of first number */
  j = strlen(s2)-1;    /* Index to last character of second number */
  k = (i > j) ? (i+1) : (j+1);   /* Index to last character of sum */
  if ((s3 = malloc((k+2)*sizeof(char))) == NULL)
    return NULL;                     /* Allocate memory for result */
  s3[k+1] = '\0';        /* Proper termination of resulting string */
  carry = 0;                         /* Initial carry for addition */
  for ( ; k >= 0 ; i--, j--, k--) {
                    /* Loop till first digit of result is computed */
    d1 = (i >= 0) ? (s1[i]-'0') : 0;       /* Get i-th digit of s1 */
    d2 = (j >= 0) ? (s2[j]-'0') : 0;       /* Get j-th digit of s2 */
    sum = d1+d2+carry;                           /* Sum two digits */
    carry = sum/10;                                  /* Next carry */
    s3[k] = sum%10+'0';                /* Put k-th digit of result */
  }
  tmp = s3;                   /* Save s3 for freeing it afterwards */
  while (*s3 == '0')               /* Eat leading 0s in the result */
    s3++;
  if(*s3 == '\0')                  /* At least one digit is needed */
    s3--;
  if ((result = malloc((strlen(s3)+1)*sizeof(char))) == NULL)
    return NULL;  /* Allocate memory for result without leading 0s */
  strcpy(result, s3);               /* Copy corrected s3 to result */
  free(tmp);                                   /* Free original s3 */
  return result;
}
