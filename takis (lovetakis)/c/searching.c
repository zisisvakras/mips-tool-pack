/* File: searching.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

void heapsort(int, char **);
void heapify(char **, int, int);
int seqsearch(char *, int, char **);
int binsearch(char *, int, char **);
void swapwords(char **, char **);

int main(int argc, char *argv[])
{ int k = 0;                  /* Counter of words that will be read */
  int nmax = 1000;       /* Default maximum number of words to read */
  double sttime, endtime;
  char search = 's';                /* Default is sequential search */
  char **words, *arg, buf[81];
  while (--argc) {
    arg = *++argv;
    if (!strcmp(arg, "-max")) {               /* Get maximum number */
      if (argc > 1 && --argc)                   /* of words to read */
        nmax = atoi(*++argv); }
    else if (!strcmp(arg, "-seq"))      /* Select sequential search */
      search = 's';
    else if (!strcmp(arg, "-bin"))          /* Select binary search */
      search = 'b';
    else if (!strcmp(arg, "-words")) {  /* Give words to search for */
      argc--;
      break; } }
  argv++;    /* Allocate memory to store addresses of words to read */
  if ((words = malloc(nmax * sizeof(char *))) == NULL) {
    fprintf(stderr, "Not enough memory\n");
    return 1; }
  while (k < nmax && scanf("%80s", buf) != EOF) {
              /* Read words until EOF or maximum number reached and */
                                   /* allocate memory to store them */
    if ((words[k] = malloc((strlen(buf)+1) * sizeof(char))) == NULL) {
      fprintf(stderr, "Not enough memory\n");
      return 2; }
    strcpy(words[k++], buf); }                   /* Store word read */
  if (search == 'b')                   /* If binary search selected */
    heapsort(k, words);       /* sort words via the heapsort method */
  sttime = ((double) clock())/CLOCKS_PER_SEC;  /* Search start time */
  while (argc--) {
    arg = *argv++;
    switch (search) {
      case 's':                       /* The sequential search case */
        printf("%sfound %s\n",
          seqsearch(arg, k, words) ? "    " : "not ", arg);
        break;
      case 'b':                           /* The binary search case */
        printf("%sfound %s\n",
          binsearch(arg, k, words) ? "    " : "not ", arg);
        break; } }
  endtime = ((double) clock())/CLOCKS_PER_SEC;   /* Search end time */
  printf("Searching time is %.2f seconds\n", endtime-sttime);
  return 0; }

void heapsort(int n, char **x)
{ int i;
  for (i=(n/2)-1 ; i >= 0 ; i--)       /* Transform array to a heap */
/* A heap is an implicit binary tree where each node is not smaller */
    heapify(x, i, n-1);            /* than its immediate successors */
  for (i=n-1 ; i >= 1 ; i--) {/* Move heap root to bottom rightmost */
    swapwords(&x[0], &x[i]);    /* position not already settled and */
    heapify(x, 0, i-1); }/*transform to a heap the rest of the tree */
}

void heapify(char **x, int root, int bottom)
{ int maxchild; /* Transform to a heap the subtree starting at root */
                                            /* up to element bottom */
  while (2*root < bottom) {         /* Do we have still work to do? */
    if (2*root+1 == bottom)    /* If left child is last to consider */
      maxchild = 2*root+1;             /* this is the maximum child */
    else if (strcmp(x[2*root+1], x[2*root+2]) > 0)     /* Otherwise */
      maxchild = 2*root+1;           /* select maximum between left */
    else
      maxchild = 2*root+2;               /* and right child of root */
    if (strcmp(x[maxchild], x[root]) > 0) {/* Compare maximum child */
      swapwords(&x[maxchild], &x[root]);      /* with root and swap */
      root = maxchild; } /* accordingly, defining also the new root */
    else
      break; } }                            /* OK, we made our heap */

int seqsearch(char *w, int n, char **x)
{ int i;
  for (i=0 ; i < n ; i++)
    if (!strcmp(w, x[i]))       /* So simple, what to comment here! */
      return 1;
  return 0; }

int binsearch(char *w, int n, char **x)
{ int cond, low, high, mid;
  low = 0;                             /* Lower limit for searching */
  high = n-1;                          /* Upper limit for searching */
  while (low <= high) {          /* Do we have space for searching? */
    mid = (low+high)/2;        /* Medium element of search interval */
                         /* to compare with word we are looking for */
    if ((cond = strcmp(w, x[mid])) < 0)   /* Compare medium to word */
      high = mid-1;       /* Not found, word might be at first half */
    else if (cond > 0)
      low = mid+1;       /* Not found, word might be at second half */
    else return 1; }                                /* We found it! */
  return 0; }                              /* Sorry, word not found */

void swapwords(char **w1, char **w2)
{ char *temp;  /* The well-known swap function for the strings case */
  temp = *w1;
  *w1 = *w2;
  *w2 = temp; }
