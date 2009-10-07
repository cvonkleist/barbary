require 'view'
include Barbary

describe View do
  it "should render with specified file" do
    File.should_receive(:read).with(ROOT / DATA / VIEWS / 'foo.haml').and_return('%p= var')
    view = View.new
    view.render_with('foo', :var => 'baz').should match(%r#<p>baz</p>#)
  end

  it "should render contents" do
    view = View.new
    view.should_receive(:render_with)
    view.render(:foo => 'bar')
  end

  it "should escape HTML" do
    view = View.new
    view.h('<foo').should match(/foo/)
    view.h('<foo').should_not match(/</)
  end

  it "should increase heading levels in HTML" do
    view = View.new
    view.increase_headings('<p>foo</p><h2>bar</h2>', 2).should == '<p>foo</p><h4>bar</h4>'
  end
end
