# pressbooks-compatible-wordpress-dockerfile

Modifying the WordPress docker image to install Pressbooks' dependencies.

Don't forget to add the following to `/var/www/html/wp-config.php`:

```
define( 'PB_EPUBCHECK_COMMAND', '/usr/bin/java -jar /opt/epubcheck/epubcheck.jar' );
```

## Note to self

1. Use `docker login` to log in to Docker Hub.
2. Run `./build.sh` (or `./build.ps1` on Windows) to take care of the rest.
