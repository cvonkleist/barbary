require 'builder'
include Barbary

describe Builder do
  it "should build everything" do
    builder = Builder.new
    [:build_posts, :build_index, :build_tags, :build_feed].each do |m|
      builder.should_receive m
    end
    builder.build_everything
  end

  it "should build posts" do
    post_view = mock("post view")
    post_view.should_receive(:render).and_return('foo')
    PostView.should_receive(:new).and_return(post_view)
    FileUtils.should_receive :mkdir_p
    f = StringIO.new
    File.should_receive(:open).and_yield(f)
    builder = Builder.new
    builder.build_posts
    f.string.should == 'foo'
  end

  it "should build index" do
    index_view = mock("index view")
    index_view.should_receive(:render).and_return('index')
    IndexView.should_receive(:new).and_return(index_view)
    f = StringIO.new
    File.should_receive(:open).and_yield(f)
    builder = Builder.new
    builder.build_index
    f.string.should == 'index'
  end

  it "should build tags" do
    pending
    builder = Builder.new
    #FileUtils.should_receive :mkdir_p
    #File.should_receive(:open)
    builder.build_tags
  end

  it "should build feeds" do
    pending
    builder = Builder.new
    FileUtils.should_receive :mkdir_p
    File.should_receive(:open)
    builder.build_feeds
  end
end
