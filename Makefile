repo=tp-dj
snapshot=tp-dj-snapshot
packages=tp-dj-bootstrap.deb tp-dj-tools.deb

all: $(packages)
	aptly repo remove $(repo) tp-dj-tools
	aptly repo add $(repo) tp-dj-tools.deb

tp-dj-tools.deb:
	dpkg-deb --build src/tp-dj-tools tp-dj-tools.deb

tp-dj-bootstrap.deb:
	dpkg-deb --build src/tp-dj-bootstrap tp-dj-bootstrap.deb

.PHONY: all clean publish

clean:
	rm $(packages)
	find . -name '*~' -exec rm {} \;

publish: all
	if ( aptly publish show test tp-dj 2> /dev/null ) ; then aptly publish drop test tp-dj ; fi
	aptly snapshot drop $(snapshot)
	aptly snapshot create $(snapshot) from repo $(repo)
	aptly publish snapshot -origin=ThoughtPatterns -gpg-key=jamie@thoughtpatterns.com.au $(snapshot) tp-dj
	rsync -av $(HOME)/.aptly/public/tp-dj milonga@thoughtpatterns.com.au:www/html/repo

bootstrap: tp-dj-bootstrap.deb
	scp tp-dj-bootstrap.deb milonga@thoughtpatterns.com.au:www/html/repo



