SHELL:=/bin/bash

.PHONY:install
install:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash > /dev/null
	(source ~/.nvm/nvm.sh > /dev/null; nvm install 10.16.3; node -e "console.log('Running Node.js ' + process.version)"; npm install express-generator -g; express --view=pug ieee_site; cd ieee_site; npm install; npm install mongoose; npm audit fix)

	rm -rf ieee_site/public
	rm -rf ieee_site/routes
	rm -f ieee_site/app.js

	cp -r src/html/ ieee_site/public
	cp -r src/routes/ ieee_site/routes 
	cp -r src/images/ ieee_site/public/images
	cp src/app.js ieee_site

	mkdir mongodata
	mongod -dbpath mongodata

.PHONY:update
update:
	git pull

	rm -rf ieee_site/public
	rm -rf ieee_site/routes
	rm -f ieee_site/app.js

	cp -r src/html/ ieee_site/public
	cp -r src/routes/ ieee_site/routes 
	cp -r src/images/ ieee_site/public/images
	cp src/app.js ieee_site


.PHONY:ubuntu_setup
ubuntu_setup:
	sudo apt update
	sudo apt upgrade -y
	sudo apt install -y gcc git mongodb nginx


.PHONY:arch_setup
arch_setup:
	sudo pacman -Syu
	sudo pacman -S gcc git


.PHONY:routing
routing:
	sudo rm -f /etc/nginx/sites-enabled/default

	echo "server {
	    listen 80;
	    server_name uaieee.com www.uaieee.com uaieee.org www.uaieee.org arizona.ieee.org www.arizona.ieee.org;

	    location / {
	        proxy_set_header   X-Forwarded-For \$remote_addr;
	        proxy_set_header   Host \$http_host;
	        proxy_pass         \"http://127.0.0.1:3000\";
	    }
	}" >> .tmpsrv

	sudo cp .tmpsrv /etc/nginx/sites-available/uaieee

	sudo ln /etc/nginx/sites-available/uaieee /etc/nginx/sites-enabled/uaieee
	sudo service nginx restart

.PHONY:clean
clean:
	rm -rf ieee_site
	rm -rf mongodata
