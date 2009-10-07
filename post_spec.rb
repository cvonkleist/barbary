require 'post'
include Barbary

describe Post do
  it "should split tags" do
    p = Post.new
    p.tags = 'foo  bar baz'
    p.tags.should == %w(foo bar baz)
  end

  it "should load from a file" do
    p = Post.new

    File.should_receive(:read).and_return(
      "title: Foo\r\n" +
      "slug: foo\n" +
      "tags: foo bar\n" +
      "published: 2008-08-29\n\r\n" +
      "all your base"
    )

    p.load_from 'foo'

    p.title.should == 'Foo'
    p.slug.should == 'foo'
    p.tags.should == %w(foo bar)
    p.published.should be_kind_of(Date)
    p.body.should == 'all your base'
  end
end
