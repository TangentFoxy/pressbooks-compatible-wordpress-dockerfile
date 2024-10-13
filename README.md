# pressbooks-compatible-wordpress-dockerfile

Modifying the WordPress docker image to install Pressbooks' dependencies.

Don't forget to add the following to `/var/www/html/wp-config.php`:

```
// Pressbooks dependencies
define( 'PB_PRINCE_COMMAND', '/usr/bin/prince' );
define( 'PB_EPUBCHECK_COMMAND', '/usr/bin/java -jar /opt/epubcheck/epubcheck.jar' );
define( 'PB_XMLLINT_COMMAND', '/usr/bin/xmllint' );
define( 'PB_SAXON_COMMAND', '/usr/bin/java -jar /opt/saxon-he/saxon-he.jar' );
```

## Lies in official documentation

Pressbooks' [installation instructions](https://pressbooks.org/user-docs/installation/) has misordered, misleading, incorrect, and duplicate instructions.

1. Step 1 should actually be to set up a WordPress multisite network. Needs to be at least version 6.6.1 with PHP 8.1 or higher. (If this has changed, the newest information is at the [ReadMe here](https://github.com/pressbooks/pressbooks/blob/dev/README.md).)
2. To enable the default themes, you are told to navigate to "Themes → Installed Themes" after enabling Pressbooks, but Pressbooks overwrites the names of WordPress features, so you actually have to go to "Appearance → Activate Book Themes".
3. It tells you to enable Aldine a second time, even though it was already enabled. (I think this might be to "fix" the default site that was created before multisite was enabled, but I disabled the default WordPress theme because obviously it won't be compatible with Pressbooks, so it was automatically reassigned.)
4. Nowhere is it mentioned that EPUB validation needs to be installed for EPUB export to function. (I think the developers confused "validation" and "creation"?)
5. Nowhere is it mentioned that for PDFs to work, XML validation must be enabled (thank goodness for [this thread](https://pressbooks.community/t/help-with-dependencies-config/1036), or I never would've figured this out). (PDFs are created from an XHTML export, but this is not mentioned either.)
6. For some reason, despite configuration for commands being part of the config, they don't work when in a different location than Pressbooks expects. As a result, the installation of Saxon HE is *weird*.
7. Despite following instructions to enable ODT export, it does not appear.
8. PDF export doesn't support covers, or requires manual setup to get covers to export. I haven't figured this one out yet. (Also the "for print" export just removes links within the PDF, so it's just worse in *almost* every way.)

I don't know why it tells you to install two themes, only one of which appears to be usable/real. Perhaps Aldine relies on McLuhan to function? But McLuhan doesn't even appear as an option.

## Notes to self for maintaining this repo

1. Use `docker login` to log in to Docker Hub.
2. Run `./build.sh` (or `./build.ps1` on Windows) to take care of the rest.
