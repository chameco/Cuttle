OBJECTS = src/utils.o
CFLAGS = -Iinclude -Wall -fPIC
INSTALL = install
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644
prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(prefix)/bin
datarootdir = $(prefix)/share
datadir = $(datarootdir)
includedir = $(prefix)/include/
libdir = $(exec_prefix)/lib/
all: shared
static: $(OBJECTS)
	ar -cvq libcuttle.a $(OBJECTS)
shared: $(OBJECTS)
	$(CC) -shared -Wl,-soname,libcuttle.so.1.0 -o libcuttle.so.1.0 $(OBJECTS)
install: all
	$(INSTALL_DATA) libcuttle.so.1.0 $(DESTDIR)$(libdir)
	ln -sf $(DESTDIR)$(libdir)/libcuttle.so.1.0 $(DESTDIR)$(libdir)/libcuttle.so.1
	ln -sf $(DESTDIR)$(libdir)/libcuttle.so.1.0 $(DESTDIR)$(libdir)/libcuttle.so
	mkdir -p $(DESTDIR)$(incdir)/cuttle/
	$(INSTALL_DATA) include/utils.h $(DESTDIR)$(includedir)/cuttle/
	$(INSTALL_DATA) include/debug.h $(DESTDIR)$(includedir)/cuttle/
uninstall:
	rm $(DESTDIR)$(libdir)/libcuttle.so.1.0
	rm $(DESTDIR)$(libdir)/libcuttle.so.1
	rm $(DESTDIR)$(libdir)/libcuttle.so
	rm -r $(DESTDIR)$(incdir)/cuttle
clean:
	rm $(OBJECTS)
