FROM alpine

ENV MAILHOG_RELEASE v0.2.1
ENV MAILHOG_USERNAME admin
ENV MAILHOG_PASSWORD admin

RUN apk update \ 
	&& apk add --no-cache curl \
	&& curl -L https://github.com/mailhog/MailHog/releases/download/${MAILHOG_RELEASE}/MailHog_linux_amd64 > /usr/local/bin/mailhog \
	&& chmod +x /usr/local/bin/mailhog \
	&& mkdir /var/lib/mail /etc/mailhog \
	&& rm -rf /var/cache/apk/* \
	&& apk del curl

#SMTP
EXPOSE 1025

#HTTP
EXPOSE 8025

VOLUME ["/var/lib/mail", "/etc/mailhog"]

ADD docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["-maildir-path", "/var/lib/mail", "-storage", "maildir", "-auth-file", "/etc/mailhog/passwd"]