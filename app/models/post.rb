class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  after_initialize :defaults

  def defaults
    self.posted ||= DateTime.now
  end

  def html_body
    CommonMarker.render_html(body).html_safe
  end

  def excerpt
    document = CommonMarker.render_doc(body)
    paragraphs = document.each.take_while { |n| n.type == :paragraph }.take 3

    paragraphs.map(&:to_html).join.html_safe
  end
end
