require 'boot'
require 'yaml'

module Barbary
  class Post
    attr_accessor :title, :slug, :tags, :published, :body

    # Optionally load data from a file
    def initialize(file = nil)
      load_from file if file
    end

    # Read properties from a .post file
    #
    # The top of the file is a meta section with
    def load_from(file)
      contents = File.read(file)

      # Body begins after a blank line
      meta, @body = contents.split(/(?:\r?\n){2,}/, 2)

      YAML.load(meta).each do |property, value|
        send property + '=', value
      end
    end

    # Assign tags array with space-separated text
    def tags=(text)
      @tags = text.strip.split
    end
  end
end
