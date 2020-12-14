class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  after_initialize :defaults

  def self.from_markdown(body)
    document = CommonMarker.render_doc(body)
    title_node = document.each.find { |node| node.type == :header && node.header_level == 1 }
    title = title_node.each.map(&:string_content).join
    title_node.delete

    Post.new(
      title: title,
      body: document.to_commonmark
    )
  end

  def defaults
    self.posted ||= DateTime.now
  end

  def html_body
    CommonMarker.render_html(body).html_safe
  end

  def excerpt
    document = CommonMarker.render_doc(body)
    paragraphs = document.each.take_while { |node| node.type == :paragraph }.take 3

    paragraphs.map(&:to_html).join.html_safe
  end

  def text_excerpt
    document = CommonMarker.render_doc(body)
    document.each.find { |node| node.type == :paragraph } .each.map(&:string_content).join
  end
end
