curl -L https://github.com/TakesxiSximada/cfseed/archive/master.tar.gz | gzip -dc | tar -xv
mv cfseed-master .cfseed
cp .cfseed/Makefile.tmpl Makefile
cp -R .cfseed/environ .
cp -R .cfseed/templates .
