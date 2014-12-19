# Linux or Windows:
CC = gcc -Wall -O4
CXX = g++ -Wall -O4
# CC = icc -w1 -O3

# Macintosh:
ifeq (${HOSTTYPE},powerpc)
  CC = cc -pipe -O3 -Wall -fno-common -arch ppc
endif

# If no host type is set, use the "bin" directory for output.
ifndef HOSTTYPE:
  HOSTTYPE=bin
endif

LIBS=-lm -lblas -ltbb
OBJ=svdlib.o svdutil.o las2.o

svd: Makefile main.o libsvd.a
	${CXX} ${CFLAGS} -o svd main.o libsvd.a ${LIBS}
	mv -f $@ ${HOSTTYPE}/$@
	ln -s ${HOSTTYPE}/$@ $@
main.o: Makefile main.c svdlib.h
	${CC} ${CFLAGS} -c main.c

libsvd.a: ${HOSTTYPE} ${OBJ}
	rm -f $@ ${HOSTTYPE}/$@
	ar cr $@ ${OBJ}
	ranlib $@
	mv -f $@ ${HOSTTYPE}/$@
	ln -s ${HOSTTYPE}/$@ $@
svdlib.o: Makefile svdlib.h svdlib.c
	${CC} ${CFLAGS} -c svdlib.c
svdutil.o: Makefile svdutil.cc svdutil.h
	${CXX} ${CFLAGS} -c svdutil.cc
las2.o: Makefile las2.c svdlib.h svdutil.h
	${CC} ${CFLAGS} -c las2.c
clean: 
	rm -f *.o

distclean: clean
	rm -rf $(HOSTTYPE)
	rm -f svd libsvd.a

$(HOSTTYPE):
	if test ! -d $(HOSTTYPE); \
	then mkdir $(HOSTTYPE); fi
