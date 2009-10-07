require 'posts'
require 'ostruct'
include Barbary

describe Posts do
  it "should be enumerable" do
    posts = Posts.new([:foo])
    posts.any? { |p| p == :foo }.should be_true
    posts.any? { |p| p == :bar }.should be_false
  end

  it "should gather its posts' tags (with counts)" do
    posts = Posts.new(
      [
        OpenStruct.new(:tags => %w(foo bar)),
        OpenStruct.new(:tags => %w(foo)),
        OpenStruct.new(:tags => %w(baz foo))
      ]
    )
    posts.tags.sort.should == %w(bar baz foo)
    posts.tags_with_counts.should == {'foo' => 3, 'bar' => 1, 'baz' => 1}
  end

  it "should find posts with the specified tag" do
    posts = Posts.new(
      [
        OpenStruct.new(:tags => %w(foo bar)),
        OpenStruct.new(:tags => %w(foo bar)),
        OpenStruct.new(:tags => %w(foo bar)),
        OpenStruct.new(:tags => %w(baz bar)),
        OpenStruct.new(:tags => %w(baz bar)),
        OpenStruct.new(:tags => [])
      ]
    )

    posts.with_tag('baz').length.should == 2
    posts.with_tag('foo').each do |p|
      p.tags.should include('foo')
    end
  end

  it "should return post by index" do
    posts = Posts.new([:foo, :bar, :baz])
    posts[0].should == :foo
    posts[2].should == :baz
  end

  it "should find most recent posts" do
    posts = Posts.new(
      [
        OpenStruct.new(:published => Date.parse('1999-01-01')),
        OpenStruct.new(:published => Date.parse('2000-01-01')),
        OpenStruct.new(:published => Date.parse('1999-02-01'))
      ]
    )
    posts.most_recent(1).length.should == 1
    posts.most_recent.length.should == 3
    recent_posts = posts.most_recent(3)
    recent_posts[0].published.should > recent_posts[1].published
    recent_posts[1].published.should > recent_posts[2].published
  end

  it "should load posts" do
    Dir.should_receive(:[]).and_return(%w(foo.post bar.post))
    Post.should_receive(:new).twice
    posts = Posts.new
    posts.load_posts
  end

  it "should count posts" do
    Posts.new.length.should == 0
    Posts.new([:foo, :bar]).length.should == 2
  end
end
