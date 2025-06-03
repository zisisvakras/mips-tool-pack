#  C counterpart:
#
#  int strlen(const char *s) {
#      const char *sc;
#      for (sc = s; *sc != '\0'; ++sc);
#      return sc - s;
#  }


# a0: str
# -> a0: strlen
# overwrites: t0, t1, a0
strlen:
    addi t1, a0, -1
strlen1:
    lb t0, 1(t1)
    addi t1, t1, 1
    bnez t0, strlen1
    sub a0, t1, a0
    jr ra