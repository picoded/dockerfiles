FROM            nginx:1.10
MAINTAINER      Eugene Cheah <eugene@picoded.com>

# Add in the config
ADD default /etc/nginx/sites-available/default
ADD default /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]