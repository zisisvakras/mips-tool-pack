/* File: magic.c */
#include <stdio.h>
#define SIZE 5

int main()
{ int i, j, k;
  int x[SIZE][SIZE];                      /* The board to be filled */
  for (i=0 ; i < SIZE ; i++)
    for (j=0 ; j < SIZE ; j++)
      x[i][j] = 0;                     /* Mark all squares as empty */
  i = (SIZE-1)/2;                                   /* Go to middle */
  j = SIZE-1;                                       /* right square */
  for (k=1 ; k <= SIZE*SIZE ; k++) {
    if (x[i][j] != 0) {                     /* If current not empty */
      i = i-1;                                /* Move one square up */
      j = j-2;                              /* and two squares left */
      if (i < 0) i = i+SIZE;                  /* If you are outside */
      if (j < 0) j = j+SIZE;  /* go to the respective square inside */
    }
    x[i][j] = k;               /* Fill current square with number k */
    i++;                                    /* Move one square down */
    if (i == SIZE) i = 0;                  /* If outside get inside */
    j++;                                   /* Move one square right */
    if (j == SIZE) j = 0;                  /* If outside get inside */
  }
  for (i=0 ; i < SIZE ; i++) {
    for (j=0 ; j < SIZE ; j++)
      printf("%4d ", x[i][j]);                   /* Print out board */
    printf("\n");
  }
}
