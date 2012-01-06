This is my .conkyrc config file, and the dependent scripts on which it is based.

<a href='https://github.com/rtlong/conkyrc/raw/master/screenshot.png'>
![image of my conky on my desktop](https://github.com/rtlong/conkyrc/raw/master/screenshot_preview.jpg)
</a>

## Environment

There are a few things you'll need, in order to use this conkyrc:

* NetBSD Fortune ('fortune-mod' in the Ubuntu repo — I'm using version 9708, but you shouldn't have
  trouble on anything else)
* Ruby 1.9 (I'm running 1.9.3-p0 — The Conkyrc will expect to find a binary in your path called
  `ruby-1.9.3-p0`, which is set up for you by [RVM][]. I'd highly recommend using that.)
* The included fonts, installed on your system. 'DejaVu' is used at some point as well (that's
  available through the Ubuntu repos). You can install the included fonts by simply extracting the
  Zip files, and copying the TTF files within into `~/.fonts` (create it if it doesn't exist), then
  run `fc-cache`
* The included NetworkManager dispatcher hook, or any other means of automatically placing your
  external IP address in `/tmp/external-ip`
* `xsltproc` and `curl` in your PATH
* A `$HOME/.bin` in your PATH, where a few included scripts can be found

## Set-up

* The string file I'm using for my fortunes is actually one I've generated myself. Using the
  included `tiny_buddha/fetch-tiny-buddha.rb`, I scrape a ton of quotes off of [TinyBuddha.com][]
  and store them in a format accepted by fortune's `strfile` program. You'll need to create a
  directory, `~/.fortunes`, into which to copy the stringfile and index (`*.dat`). The conkyrc
  expects to find them there.

    ```sh
    cd tiny_buddha
    ruby fetch-tiny-buddha.rb
    mkdir -v ~/.fortune
    cp -iv tiny_buddha* ~/.fortune
    fortune ~/.fortune # This should present a quote and 0 errors
    ```

* The included NetworkManager dispatcher hook (`get_external_address.sh`) needs to be installed at
  `/etc/NetworkManager/dispatcher.d/80-external-address` and made executable. This script simply
  tries to reach the internet, fetches your external IP address, and saves it to `/tmp/external-
  address`. In the event the internet can't be reached at all, it will show 'disconnected,' and when
  the devices are connected, but not receiving an IP address, it shows 'problem with connection.'
  The latter is useful to determine if you need to log in to public WiFi for example.
* The contents of the `bin` directory should be copied to your `~/.bin`
* Now you need to customize a few things in the Conkyrc file:
  * The Wunderground weather station ID of the station closest to you
  * The partitions for which you want gauges of free space
  * The name(s) of your network interface(s)

## Feedback

Feedback is very welcome. If you would like to use this but are having trouble setting it up, I'm
happy to help! Email me at ryan@rtlong.com

[RVM]: https://rvm.beginrescueend.com/ "Ruby Version Manager"
[TinyBuddha.com]: http://tinybuddha.com