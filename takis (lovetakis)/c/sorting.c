/* File: sorting.c */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void bubblesort(int, double *);
void selectsort(int, double *);
void insertsort(int, double *);
void quicksort(int, double *);
void quicksort_body(double *, int, int);
void swapd(double *, double *);

int main(int argc, char *argv[])
{ char method = 'b', *name; /* Default sorting method is bubblesort */
  int i, n = 10;                        /* Default array size is 10 */
  long seed;
  double *x, sttime, endtime;
  void (*fun)(int, double *);        /* Pointer to sorting function */
  seed = time(NULL); /* Get current time, in case seed is not given */
  if (argc > 1)                /* First character of first argument */
    method = *argv[1];       /* denotes the employed sorting method */
  if (argc > 2)
    n = atoi(argv[2]);     /* Second argument is number of elements */
  if (argc > 3)                       /* Third argument is seed for */
    seed = atoi(argv[3]);                /* random number generator */
  switch(method) {        /* Prepare calling the appropriate method */
    case 'b':
      fun = bubblesort; name = "bubblesort"; break;
    case 's':
      fun = selectsort; name = "selectsort"; break;
    case 'i':
      fun = insertsort; name = "insertsort"; break;
    case 'q':
      fun = quicksort; name = "quicksort"; break;
    default:
      printf("Sorry, no such method\n");
      return 1;
  }                                /* Allocate memory for the array */
  if ((x = malloc(n * sizeof(double))) == NULL) {
    printf("Sorry, not enough memory\n");
    return 1; }
  srand((unsigned int) seed); /* Initialize random number generator */
  for (i=0 ; i < n ; i++) /* Generate double floating point numbers */
    x[i] = ((double) rand())/RAND_MAX;
  printf("Random numbers\n");
  for (i=0 ; i < n ; i++) {
    printf("%6.4f ", x[i]);                       /* Print them out */
    if (i%10 == 9)                                  /* 10 in a line */
      printf("\n"); }
  printf("\n");
  printf("Sorting by %s\n", name);
  sttime = ((double) clock())/CLOCKS_PER_SEC;       /* Get CPU time */
                                 /* consumed since start of program */
  (*fun)(n, x);                              /* Call sorting method */
  endtime = ((double) clock())/CLOCKS_PER_SEC;    /* Again CPU time */
                             /* Difference endtime-sttime should be */
                                   /* CPU time consumed for sorting */
  for (i=0 ; i < n ; i++) {
    printf("%6.4f ", x[i]);               /* Print out sorted array */
    if (i%10 == 9)
      printf("\n"); }
  printf("\n");            /* Print out CPU time needed for sorting */
  printf("Time: %.2f secs\n", endtime-sttime);
  free(x); return 0;
}

void bubblesort(int n, double *x)
{ int i, j;
  for (i=1 ; i <= n-1 ; i++)          /* Bring appropriate element, */
                                /* that is the bubble, to place i-1 */
    for (j=n-1 ; j >= i ; j--)
      if (x[j-1] > x[j])     /* Compare pairwise from bottom to top */
        swapd(&x[j-1], &x[j]);                /* and swap if needed */
}

void selectsort(int n, double *x)
{ int i, j, min;
  for (i=1 ; i <= n-1 ; i++) {
    min = i-1;            /* Let current minimum be the i-1 element */
    for (j=i ; j <= n-1 ; j++)
      if (x[j] < x[min])  /* Check if any element after i-1 is less */
        min = j; /* than so far minimum and make it the new minimum */
    swapd(&x[i-1], &x[min]); } /* Exchange minimum with i-1 element */
}

void insertsort(int n, double *x)
{ int i, j;
  for (i=1 ; i <= n-1 ; i++) {      /* Insert element at place i in */
                       /* its correct position from places 0 to i-1 */
    j = i-1;
    while (j >= 0 && x[j] > x[j+1]) {/* Move repeatedly the element */
      swapd(&x[j], &x[j+1]);                    /* until it reaches */
      j--; } }                              /* its correct position */
}

void quicksort(int n, double *x)
{ quicksort_body(x, 0, n-1);    /* Call recursive quicksort to sort */
}          /* elements of the array from position 0 to position n-1 */

void quicksort_body(double *x, int up, int down)
{ int start, end;
  start = up;              /* Save start position of small elements */
  end = down;                /* Save end position of large elements */
  while (up < down) {            /* Pivot element is at up position */
    while (x[down] >= x[up] && up < down)      /* Let down elements */
      down--;              /* larger than pivot stay where they are */
    if (up != down) {                    /* If pivot is not reached */
      swapd(&x[up], &x[down]);   /* echange it with smaller element */
      up++;     /* Pivot is at down position, move up a bit further */
    }
    while (x[up] <= x[down] && up < down)        /* Let up elements */
    up++;                 /* smaller than pivot stay where they are */
    if (up != down) {                    /* If pivot is not reached */
      swapd(&x[up], &x[down]);   /* exchange it with larger element */
      down--;   /* Pivot is at up position, move down a bit further */
    } }       /* Now up = down is the position of the pivot element */
  if (start < up-1) /* Is there at least one element left of pivot? */
    quicksort_body(x, start, up-1); /* Quick(sort) smaller elements */
  if (end > down+1)/* Is there at least one element right of pivot? */
    quicksort_body(x, down+1, end);  /* Quick(sort) larger elements */
}

void swapd(double *a, double *b)       /* Just exchange two doubles */
{ double temp;
  temp = *a;
  *a = *b;
  *b = temp; }
