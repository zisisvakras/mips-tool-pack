/* File: filecopy.c */
#include <stdio.h>

int main(int argc, char *argv[])
{ FILE *ifp, *ofp;
  int n;
  char buf[1024];
  if (argc != 3) {
    fprintf(stderr,
            "Usage: %s <soure-file> <target-file>\n", argv[0]);
    return 1;
  }
  if ((ifp = fopen(argv[1], "rb")) == NULL) { /* Open source file */
    perror("fopen source-file");
    return 1;
  }
  if ((ofp = fopen(argv[2], "wb")) == NULL) { /* Open target file */
    perror("fopen target-file");
    return 1;
  }
  while (!feof(ifp)) {  /* While we don't reach the end of source */
               /* Read characters from source file to fill buffer */
    n = fread(buf, sizeof(char), sizeof(buf), ifp);
                          /* Write characters read to target file */
    fwrite(buf, sizeof(char), n, ofp);
  }
  fclose(ifp);
  fclose(ofp);
  return 0;
}
