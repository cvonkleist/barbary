#!/usr/bin/env ruby
require 'boot'
require 'posts'
require 'view'
require 'fileutils'

module Barbary
  class Builder
    def initialize
      @posts = Posts.new
      @posts.load_posts

      # TODO: messy
      $posts = @posts
    end

    # Build every kind of everything, ever
    def build_everything
      puts 'building posts'
      build_posts
      puts 'building tags'
      build_tags
      puts 'building index'
      build_index
      puts 'building feed'
      build_feed
    end

    # Write an HTML file for every post
    def build_posts
      post_view = PostView.new
      @posts.each do |post|
        FileUtils.mkdir_p(ROOT / WWW / 'posts' / post.slug)
        File.open(ROOT / WWW / 'posts' / post.slug / 'index.html', 'w') do |f|
          f.print post_view.render(:post => post)
        end
      end
    end

    # Write tag pages
    def build_tags
      tag_view = TagView.new
      @posts.tags.each do |tag|
        FileUtils.mkdir_p(ROOT / WWW / 'tags' / tag)
        File.open(ROOT / WWW / 'tags' / tag / 'index.html', 'w') do |f|
          f.print tag_view.render(:tag => tag, :posts => @posts.with_tag(tag))
        end
      end
    end

    # Write blog's 'home' page, which is an index of recent posts
    def build_index
      index_view = IndexView.new
      File.open(ROOT / WWW / 'index.html', 'w') do |f|
        f.print index_view.render(:posts => @posts.most_recent)
      end
    end

    # Write feed
    def build_feed
      feed_view = FeedView.new
      File.open(ROOT / WWW / FEED + '.xml', 'w') do |f|
        f.print feed_view.render(:posts => @posts.most_recent)
      end
    end
  end
end

if $0 == __FILE__
  builder = Barbary::Builder.new
  builder.build_everything
end
