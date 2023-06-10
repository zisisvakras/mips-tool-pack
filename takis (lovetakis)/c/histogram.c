/* File: histogram.c */
#include <stdio.h>
#define YAXISLEN 12                                 /* Y-axis length */

int main(void)
{ int i, j, ch, total;
  int letfr[26];         /* Letter occurrences and frequencies array */
  for (i=0 ; i < 26 ; i++)
    letfr[i] = 0;                                /* Initialize array */
  total = 0;       /* Initialize counter of total letter occurrences */
  while ((ch = getchar()) != EOF) {/* Well-known read-character loop */
    if (ch >= 'A' && ch <= 'Z') {
      letfr[ch-'A']++;                    /* Found upper case letter */
      total++;
    }
    if (ch >= 'a' && ch <= 'z') {
      letfr[ch-'a']++;                    /* Found lower case letter */
      total++;
    }
  }
  printf("  |");  /* Start histogram printing - first Y-axis segment */
  for (i=0 ; i < 26 ; i++) {           /* Convert letter occurrences */
                        /* to frequencies rounded to nearest integer */
    letfr[i] = (int) ((100.0*letfr[i])/total+0.5);
    printf("%s", (letfr[i] > YAXISLEN) ? "^^" : "  ");    /* If i-th */
               /* letter frequency exceeds Y-axis length, print "^^" */
  }
  printf("\n");
  for (j=YAXISLEN ; j > 0 ; j--) {/* Print line at j-value of Y-axis */
    printf("%2d|", j);   /* Print frequency label and Y-axis segment */
    for (i=0 ; i < 26 ; i++)
      printf("%s", (letfr[i] >= j) ? "xx" : "  "); /* If i-th letter */
              /* frequency is greater than or equal to j, print "xx" */
    printf("\n");
  }                                /* Print X-axis and letter labels */
  printf("  +-----------------------------------------------------\n");
  printf("   AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\n");
  return 0;
}
