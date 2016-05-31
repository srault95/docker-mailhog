Docker Mailhog
==============

**Docker for `Mailhog`_**

Build
-----

::
    
    docker build -t rs/mailhog https://github.com/srault95/rs-mailhog.git
    
    # OR

    git clone https://github.com/srault95/rs-mailhog.git
    cd rs-mailhog
    docker build -t rs/mailhog .
    
Run
---

- Default storage: maildir

::

    # For help:
    docker run -it --rm rs/mailhog --help

    # Run
    docker run -d --name mailhog \
      -p 1025:1025 -p 8025:8025 \
      -v /var/lib/mail:/var/lib/mail rs/mailhog
    
    # Open web - default login/password (admin/admin) 
    http://YOUR_PUBLIC_IP:1025

Optional
--------

::
    
    # Set password by adding environ variables to docker run:
    -e MAILHOG_USERNAME=username -e MAILHOG_PASSWORD=password
    
    # Set password by generating file
    mkdir /etc/mailhog
    MYPASS=$(docker run -it --rm rs/mailhog bcrypt mypassword)
    echo "myusername:${MYPASS}" > /etc/mailhog/passwd
    # Add to docker run:
    -v /etc/mailhog:/etc/mailhog
    
TODO
----

* storage mongo
* Jim filter

.. _`Mailhog`: https://github.com/mailhog/MailHog
