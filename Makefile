SHELL   = /bin/sh

TARGET  = winsplit
SOURCES = $(shell echo *.c)
OBJECTS = $(SOURCES:.c=.o)
LIBRARY = $(OBJECTS:.o=.so)
CFLAGS  += $(shell pkg-config --cflags --libs  geany)
CFLAGS  += -DPACKAGE_VERSION=\"$$(cat VERSION)\"
CFLAGS  += -W
CFLAGS  += -Wall
CFLAGS  += -O2
PREFIX  = $(DESTDIR)/usr/local
#~ BINDIR  = $(PREFIX)/lib/geany
BINDIR = $(HOME)/.config/geany/plugins


$(LIBRARY): $(SOURCES)
	$(CC) -c $(SOURCES) $(CFLAGS) -fPIC
	$(CC) -shared -o $(LIBRARY) $(OBJECTS);

install: $(LIBRARY)
	install -D $(LIBRARY) $(BINDIR)

uninstall:
	@rm -f $(BINDIR)/$(LIBRARY)

.PHONY : clean
clean :
	@rm -f $(OBJECTS)
	@rm -f $(LIBRARY)
