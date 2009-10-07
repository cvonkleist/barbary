require 'boot'
require 'erb'
require 'haml'
require 'bluecloth'

module Barbary
  class View
    # Render the view with the specified local variables
    #
    # *contents* is a hash like {:foo => foo} which sets the template's local
    # variables
    def render(vars)
      render_with('blog', vars)
    end

    # Example:
    #
    # view.render('post', :post => post)
    def render_with(layout, vars = {})
      contents = File.read(ROOT / DATA / VIEWS / layout + '.haml')
      engine = Haml::Engine.new(contents)      
      engine.render(self, vars)
    end

    def h(text)
      ERB::Util::h(text)
    end

    # Increases heading levels by _add_ steps for provided HTML
    def increase_headings(html, add)
      html.gsub(%r(</?h[1-6])) do |h_tag|
        h_tag.gsub(/\d/) { |level| level.to_i + add }
      end
    end
  end

  class PostView < View
    def render(vars)
      super(:content => render_with('post', vars))
    end
  end

  class IndexView < View
    def render(vars)
      super(:content => render_with('index', vars))
    end
  end

  class TagView < View
    def render(vars)
      super(:content => render_with('tag', vars))
    end
  end

  class FeedView < View
    def render(vars)
      render_with('feed', vars)
    end
  end
end
