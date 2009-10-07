## barbary: what it is

It's a static blog engine. You create posts in special format in a directory and run barbary to compile them into a static site.

## Features

You can browse the blog by the following methods:

- an index page
- posts
- tags

## Basic usage

You need a directory structure like this:

    ./          # we're here
      ./data/
        ./posts/  # your posts
        ./views/  # your customized haml views
      ./static/   # your images and css (will be copied to www dir)
      ./www/      # generated site ends up here

./posts/ contains files of this format:

    % cat data/posts/first.post 
    title: First post
    slug: first-post
    published: 2008-08-29
    tags: foolishness
    
    All your base are belong to us.

Then, run:

    % ruby builder.rb
    building posts
    building tags
    building index
    building feed

The generated site will appear in ./www/:

    % find www/
    www
    www/index.html
    www/posts
    www/posts/barbary
    www/posts/barbary/index.html
    www/posts/firefox-spell-check-in-gentoo
    www/posts/firefox-spell-check-in-gentoo/index.html
    www/posts/first-post
    www/posts/first-post/index.html
    www/blog.css
    www/cvk-blog.xml
    www/tags
    www/tags/linux
    www/tags/linux/index.html
    www/tags/barbary
    www/tags/barbary/index.html
    www/tags/gentoo
    www/tags/gentoo/index.html
    www/tags/firefox
    www/tags/firefox/index.html
    www/tags/coding
    www/tags/coding/index.html
    www/tags/foolishness
    www/tags/foolishness/index.html
    www/images
    www/images/cvksblog.gif
    www/images/kleist.png
    www/images/bglight.png
    www/images/kleist.gif
    www/images/bgdark.png
    www/images/bgpattern.gif

## Requirements

- haml
