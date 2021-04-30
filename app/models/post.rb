require 'uri'

class ImageBlobRenderer < CommonMarker::HtmlRenderer
  include Rails.application.routes.url_helpers

  def image(node)
    case node.url
    when %r{/post_assets/(.+)}
      blob = ActiveStorage::Blob.find_by_filename!(CGI.unescape(Regexp.last_match(1)))
      block do
        out ApplicationController.helpers.tag(
          'img',
          src: url_for(blob),
          alt: node.each.map(&:string_content).join,
          width: blob.metadata[:width],
          height: blob.metadata[:height]
        )
      end
    else
      super
    end
  end

  def link(node)
    out('<a href="', node.url.nil? ? '' : escape_href(node.url), '"')
    out(' title="', escape_html(node.title), '"') if node.title && !node.title.empty?
    out(' target="_blank"') if node.url && node.url.starts_with?('http')
    out('>', :children, '</a>')
  end

  def softbreak(_)
    out("<br />\n")
  end
end

class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :author, class_name: :User
  has_and_belongs_to_many :tags
  after_initialize :defaults

  def self.from_markdown(body)
    document = CommonMarker.render_doc(body)

    title_node = document.each.find { |node| node.type == :header && node.header_level == 1 }
    title = title_node.each.map(&:string_content).join
    title_node.delete

    document.walk do |node|
      if (node.type == :image) && !node.url.starts_with?('https://', 'http://', '/post_assets')
        node.url = "/post_assets/#{node.url}"
      end
    end

    tag_paragraph = document.each.find do |node|
      node.type == :paragraph and node.to_commonmark =~ %r{(#blog/\S+ )+}
    end

    tags = if tag_paragraph
             tags = tag_paragraph.each.flat_map do |node|
               node.string_content.split(' ').map { |t| t.delete_prefix('#blog/') }
             rescue StandardError # why tho
               []
             end
             tag_paragraph.delete
             tags
           else [] end

    Post.new(
      title: title,
      body: document.to_commonmark,
      tags: Tag.tags_from_array(tags)
    )
  end

  def renderer
    ImageBlobRenderer.new
  end

  def defaults
    self.posted ||= DateTime.now
  end

  def document
    CommonMarker.render_doc(body, :DEFAULT, %i[autolink strikethrough])
  end

  def html_body
    renderer.render(document).html_safe
  end

  def excerpt(paragraphs: 3)
    doc = document

    doc.each.each_with_index do |node, index|
      node.delete if index > paragraphs - 1
    end

    renderer.render(doc).html_safe
  end

  def main_image
    url = document.walk.find { |node| node.type == :image }&.url

    case url
    when %r{/post_assets/(.+)}
      blob = ActiveStorage::Blob.find_by_filename!(CGI.unescape(Regexp.last_match(1)))
      url_for(blob)
    else
       url
    end
  end
end
