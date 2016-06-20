FROM            nginx:1.10
MAINTAINER      Eugene Cheah <eugene@picoded.com>

# Add in the config
ADD default /etc/nginx/sites-available/default
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]