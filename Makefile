.POSIX :

DERP = /usr/local/libderp-dev-0.1.0

CFLAGS  = -std=c99 -pedantic -D_POSIX_C_SOURCE=200112L -Wall -Wextra \
          -I$(DERP)/include
LDFLAGS = -L$(DERP)/lib/static
LDLIBS  = -lpthread -lderp

ringfifo : ringfifo.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $? $(LDLIBS)
