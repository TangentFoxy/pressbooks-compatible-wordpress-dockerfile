# pressbooks-compatible-wordpress-dockerfile

Modifying the WordPress docker image to install Pressbooks' dependencies.

## Personal edition of setup instructions

1. Start the container and run basic setup.
2. Add to wp-config.php:
   ```
   /* Multisite */
   define( 'WP_ALLOW_MULTISITE', true );
   ```
   (Above `/* That's all, stop editing! Happy publishing. */`.)
3. (At this point, you must be accessing WordPress from the correct domain.) Click "Tools". Click "Network Setup".
4. Follow the first step in WordPress's network setup instructions (but the 2nd doesn't matter).
5. Find the correct URL for the current release of [pressbooks](https://github.com/pressbooks/pressbooks/releases), [pressbooks-book (McLuhan)](https://github.com/pressbooks/pressbooks-book/releases), and [pressbooks-aldine](https://github.com/pressbooks/pressbooks-aldine/releases) so you can download them to the correct places.
6. Follow steps 3-5 in "Manual Installation" and all of "Activate Plugins & Themes" at https://pressbooks.org/user-guides/installation/
    (Note that steps in "Activate Plugins & Themes" have some redundancies and misnamed instructions.)
7. Don't forget to add the following to `/var/www/html/wp-config.php`:
    ```
    // Pressbooks dependencies
    define( 'PB_PRINCE_COMMAND', '/usr/bin/prince' );
    define( 'PB_EPUBCHECK_COMMAND', '/usr/bin/java -jar /opt/epubcheck/epubcheck.jar' );
    define( 'PB_XMLLINT_COMMAND', '/usr/bin/xmllint' );
    define( 'PB_SAXON_COMMAND', '/usr/bin/java -jar /opt/saxon-he/saxon-he.jar' );
    ```

## Confusion in official documentation

Pressbooks' [installation instructions](https://pressbooks.org/user-docs/installation/) has misleading, incorrect, and duplicate instructions. ([I opened an issue about it](https://github.com/pressbooks/pressbooks/issues/3810).)

1. The first steps seem out of order to me. Step 1 should actually be the WordPress setup, including starting a multisite network. (At time of writing, needs to be at least version 6.6.1 with PHP 8.1 or higher. Newest information should be at the [ReadMe here](https://github.com/pressbooks/pressbooks/blob/dev/README.md).)
2. To enable the default themes, you are told to navigate to "Themes → Installed Themes" after enabling Pressbooks, but Pressbooks overwrites the names of WordPress features, so you actually have to go to "Appearance → Activate Book Themes".
3. It tells you to enable Aldine a second time, even though it was already enabled.
4. Nowhere is it mentioned that EPUB validation needs to be installed for EPUB export to function. (Validation =/= creation.)
5. Nowhere is it mentioned that for PDFs to work, XML validation must be enabled (thank goodness for [this thread](https://pressbooks.community/t/help-with-dependencies-config/1036), or I never would've figured this out). (PDFs are created from an XHTML export, but this is not mentioned either. In their defense, the tool *is* called Prince**XML**, but tool names should not be expected to convery such information.)
6. ~~For some reason, despite configuration for commands being part of the config, they don't work when in a different location than Pressbooks expects. As a result, the installation of Saxon HE is *weird*.~~ This turned out to be an error with my docker build machine running out of disk space and not informing me. :D
7. Despite following instructions to enable ODT export (and verifying installation is correct), it does not appear in the export UI.
8. PDF export doesn't support covers, or requires manual setup to get covers to export. I haven't figured this one out yet. (Also as far as I can tell, the "for print" export just removes links within the PDF? Seems like a weird distinction.)
9. The listed dependencies for using the cover generator are actually only required for EPUB covers. The PDF covers can be generated without them. (This is not stated.) Also, **the cover generator will permanently delete any custom uploaded covers without warning**. Nice.

It's really weird that only one of the themes you have to install ever appears in the UI.

## Notes to self for maintaining this repo

1. Use `docker login` to log in to Docker Hub.
2. Run `./build.sh` (or `./build.ps1` on Windows) to take care of the rest.
