class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  after_initialize :defaults

  def defaults
    self.posted ||= Date.today
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      tables: true,
      no_intra_emphasis: true,
      autolink: true,
      footnotes: true,
      fenced_code_blocks: true
    )
  end

  def html_body
    markdown.render(body).html_safe
  end
end
