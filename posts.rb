require 'boot'
require 'post'

module Barbary
  # A collection class
  class Posts
    include Enumerable

    def initialize(posts = [])
      @posts = posts
    end

    # This is how we support enumeration!
    def each
      @posts.each { |p| yield p }
    end

    # Returns all tags of all the posts
    #
    # Each tag only appears once in the result even if multiple posts share it.
    def tags
      tags_with_counts.keys
    end

    # A lot like #tags, but returns a hash of tags with their corresponding post counts
    #
    # e.g.: {:tag1 => 5, :tag2 => 22}
    def tags_with_counts
      counts = Hash.new(0)
      @posts.collect { |p| p.tags}.flatten.each { |tag| counts[tag] += 1 }
      counts
    end

    # Returns array of posts with the specified tag
    def with_tag(tag)
      Posts.new(@posts.select { |p| p.tags.include?(tag) })
    end

    # Returns array of up to *count* posts ordered by published date
    def most_recent(count = RECENT)
      Posts.new(@posts.sort_by { |p| p.published }.reverse.last(count))
    end

    # Load all files in the POSTS directory
    def load_posts
      @posts = Dir[ROOT / DATA / POSTS / '*'].collect do |file|
        Post.new(file)
      end
    end

    # Return number of posts stored in this Posts collection
    def length
      @posts.length
    end

    # Return post at index i
    def [](i)
      @posts[i]
    end
  end
end
