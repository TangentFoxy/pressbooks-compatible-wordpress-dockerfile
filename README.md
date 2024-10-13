# pressbooks-compatible-wordpress-dockerfile
Modifying the WordPress docker image to install Pressbooks' dependencies.

Don't forget to add the following to `/var/www/html/wp-config.php`:

```
define( 'PB_EPUBCHECK_COMMAND', '/usr/bin/java -jar /opt/epubcheck/epubcheck.jar' );
```
