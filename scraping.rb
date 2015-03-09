require 'rubygems'
require 'nokogiri'
require 'open-uri'
 
class Post
  attr_accessor :title, :url, :points, :item_id, :num_comments, :comment_list
 
  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
    @comment_list = []
  end
 
  def scrape_post_information
    @title = @doc.search('.title > a:first-child').map {|link| link.inner_text}
    @url = @doc.search('.title > a:first-child').map {|link| link['href']}
    @points = @doc.search('.subtext > span:first-child').map { |span| span.inner_text } 
    @num_comments = @doc.search('.subtext > a:nth-child(3)').map {|link| link.inner_text }
    item_id_href = @doc.search('.subtext > a:nth-child(3)').map {|link| link['href'] }	
    @item_id = item_id_href[0].scan(/\d+/)
  end
 
  def create_comment_list
    comments_strings = @doc.search('.comment').map {|comment| comment.inner_text } # Array of Strings
    comments_strings.each { |comments| @comment_list << Comment.new(comments)}
  end
 
  def add_comment(string)
    @comment_list << Comment.new(string)
  end
 
  def comments
    @comment_list
  end
 
end
 
  class Comment
    def initialize(string)
    @comment_text = string
  end
end
 
url = ARGV[0]
post = Post.new
post.scrape_post_information
p post.title.first
p post.url.first
p post.points.first
p post.num_comments.first
p post.item_id.first
 
puts "comments are below: "
post.create_comment_list
post.add_comment("donkeys are the best")
p post.comments
