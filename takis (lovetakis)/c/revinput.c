/* File: revinput.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Slistnode *SListptr;

struct Slistnode {                    /* A list node structure */
  char *line;                       /* with a string as member */
  SListptr next;
};

void Sinsert_at_start(SListptr *, char *);
void Sprint(SListptr);

int main(void)
{ char buf[1024];
  SListptr list;
  list = NULL;    /* Initialize list to store lines to be read */
  while (fgets(buf, sizeof buf, stdin) != NULL) /* Read a line */
                     /* and insert it at the start of the list */
    Sinsert_at_start(&list, buf);
  Sprint(list);     /* Print the list, i.e. the input reversed */
  return 0;
}

void Sinsert_at_start(SListptr *ptraddr, char *buf)
                    /* The well-known insert_at_start function */
{ SListptr templist;
  templist = *ptraddr;
  *ptraddr = malloc(sizeof(struct Slistnode));
  (*ptraddr)->line = malloc((strlen(buf)+1) * sizeof(char));
  strcpy((*ptraddr)->line, buf);
  (*ptraddr)->next = templist;
}

void Sprint(SListptr list)          /* Just print out the list */
{ while (list != NULL) {
    printf("%s", list->line);
    list = list->next; }
}
