tp-dj-tools.deb:
	dpkg-deb --build src/tp-dj-tools tp-dj-tools.deb

tp-dj-bootstrap.deb:
	dpkg-deb --build src/tp-dj-bootstrap tp-dj-bootstrap.deb

all: tp-dj-tools.deb tp-dj-bootstrap.deb

clean:
	rm tp-dj-tools.deb tp-dj-bootstrap.deb

