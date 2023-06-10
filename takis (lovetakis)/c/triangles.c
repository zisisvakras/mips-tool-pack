/* File: triangles.c */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

struct point {
  double x;                  /* A point in 2 dimensions is defined */
  double y;                        /* by its x- and y- coordinates */
} *points;

struct triangle {
  struct point a;   /* A triangle is defined by its three vertices */
  struct point b;
  struct point c;
};

struct triangle get_triangle(int, int, int);
double triangle_area(struct triangle *);
double get_side(struct point, struct point);

int main(int argc, char *argv[])
{ int i, j, k, n = 10;
  long seed;
  struct triangle tr, max_tr, min_tr;
  double area, max_area, min_area;
  seed = time(NULL);
  if (argc > 1)
    n = atoi(argv[1]);
  if (n < 3) {           /* In order to have at least one triangle */
    printf("At least three points are needed\n");
    return 1;
  }
  if ((points = malloc(n * sizeof(struct point))) == NULL) {
                              /* Allocate memory to store n points */
    printf("Sorry, not enough memory!\n");
    return 1;
  }
                             /* Initialize random number generator */
  srand((unsigned int) seed);
  for (i=0 ; i < n ; i++) {
         /* Generate points with coordinates between 0.0 and 100.0 */
/* RAND_MAX is max number that rand() returns - usually 2147483647 */
    (points+i)->x = (100.0 * rand())/(RAND_MAX+1.0);
    (points+i)->y = (100.0 * rand())/(RAND_MAX+1.0);
  }
  for (i=0 ; i < n ; i++)             /* Printout points generated */
    printf("P%-2d: (%4.1f,%4.1f)\n", i, (points+i)->x, (points+i)->y);
  tr = get_triangle(0, 1, 2);                /* Get first triangle */
  area = triangle_area(&tr);     /* Compute area of first triangle */
           /* Initialize max and min triangles with first triangle */
  max_tr = min_tr = tr;
  max_area = min_area = area;    /* Areas of max and min triangles */
  for (i=0 ; i < n-2 ; i++)    /* Iterate through all combinations */
    for (j=i+1 ; j < n-1 ; j++)  /* of points in order to form all */
      for (k=j+1 ; k < n ; k++) {            /* possible triangles */
        tr = get_triangle(i, j, k);        /* Get current triangle */
        area = triangle_area(&tr);     /* Area of current triangle */
        if (area > max_area) {      /* Is current larger than max? */
          max_tr = tr;
          max_area = area;
        }
        if (area < min_area) {     /* Is current smaller than min? */
          min_tr = tr;
          min_area = area;
        }
      }
  printf("\n");
  printf("Max triangle: ");               /* Printout max triangle */
  printf("(%4.1f,%4.1f) ", max_tr.a.x, max_tr.a.y);
  printf("(%4.1f,%4.1f) ", max_tr.b.x, max_tr.b.y);
  printf("(%4.1f,%4.1f) ", max_tr.c.x, max_tr.c.y);
  printf(" Area: %10.5f\n", max_area);
  printf("Min triangle: ");               /* Printout min triangle */
  printf("(%4.1f,%4.1f) ", min_tr.a.x, min_tr.a.y);
  printf("(%4.1f,%4.1f) ", min_tr.b.x, min_tr.b.y);
  printf("(%4.1f,%4.1f) ", min_tr.c.x, min_tr.c.y);
  printf(" Area: %10.5f\n", min_area);
  return 0;
}

struct triangle get_triangle(int i, int j, int k)
{ struct triangle tr;
  tr.a = *(points+i);
  tr.b = *(points+j);
  tr.c = *(points+k);
  return tr;              /* Return triangle with vertices i, j, k */
}

double triangle_area(struct triangle *tr)
{ double s1, s2, s3, t;
  s1 = get_side(tr->a, tr->b);            /* Get length of side ab */
  s2 = get_side(tr->b, tr->c);            /* Get length of side bc */
  s3 = get_side(tr->c, tr->a);            /* Get length of side ca */
  t = (s1+s2+s3)/2;               /* Compute half of the perimeter */
  return sqrt(t*(t-s1)*(t-s2)*(t-s3));              /* Return area */
}

double get_side(struct point p1, struct point p2)
{            /* Return Euclidean distance between points p1 and p2 */
  return sqrt((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y));
}
