# phabricator-smtp
#
# VERSION               0.0.1
#
# Note this is referenced from 
# - https://hub.docker.com/_/php/
# - https://secure.phabricator.com/book/phabricator/article/installation_guide/
#
FROM picoded/phabricator:latest
MAINTAINER Eugene Cheah <eugene@picoded.com>

WORKDIR /phabricator

ENV MAIL_ADAPTER PhabricatorMailImplementationPHPMailerAdapter
ENV SMTP_HOST smtp_host_here
ENV SMTP_PORT 25
ENV SMTP_USER phabricator
ENV SMTP_PASS password_over_here
ENV SMTP_PROT ""

RUN echo "#!/bin/bash" > setup-smtp.sh && \
	echo 'PHAB_DIR="/phabricator/phabricator"' >> setup-smtp.sh && \
	echo '$PHAB_DIR/bin/config set metamta.mail-adapter "${MAIL_ADAPTER}"' >> setup-smtp.sh && \
	echo '$PHAB_DIR/bin/config set phpmailer.mailer "smtp"' >> setup-smtp.sh && \
	echo '$PHAB_DIR/bin/config set phpmailer.smtp-host "${SMTP_HOST}"' >> setup-smtp.sh && \
	echo '$PHAB_DIR/bin/config set phpmailer.smtp-port "${SMTP_PORT}"' >> setup-smtp.sh && \
	echo '$PHAB_DIR/bin/config set phpmailer.smtp-user "${SMTP_USER}"' >> setup-smtp.sh && \
	echo '$PHAB_DIR/bin/config set phpmailer.smtp-password "${SMTP_PASS}"' >> setup-smtp.sh && \
	echo '$PHAB_DIR/bin/config set phpmailer.smtp-protocol "${SMTP_PROT}"' >> setup-smtp.sh && \
	chmod +x setup-smtp.sh

# expose port 22 & 80
EXPOSE 22 80

# And start up the slave
ENTRYPOINT ./setup-smtp.sh && ./update-and-setup.sh && apache2-foreground
CMD ./setup-smtp.sh && ./update-and-setup.sh && apache2-foreground