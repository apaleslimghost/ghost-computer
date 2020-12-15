class ImageBlobRenderer < CommonMarker::HtmlRenderer
  def image(node)
    case node.url
    when %r{/post_assets/(.+)}
      blob = ActiveStorage::Blob.find_by_filename!(URI.decode(Regexp.last_match(1)))
      block do
        out ApplicationController.helpers.tag(
          'img',
          src: node.url,
          alt: node.each.map(&:string_content).join,
          width: blob.metadata[:width],
          height: blob.metadata[:height]
        )
      end
    else
      super
    end
  end
end

class Post < ApplicationRecord
  belongs_to :author, class_name: :User
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

    Post.new(
      title: title,
      body: document.to_commonmark
    )
  end

  def renderer
    ImageBlobRenderer.new
  end

  def defaults
    self.posted ||= DateTime.now
  end

  def document
    CommonMarker.render_doc(body)
  end

  def html_body
    renderer.render(document).html_safe
  end

  def excerpt
    doc = document

    doc.each.each_with_index do |node, index|
      node.delete if index > 3
    end

    renderer.render(doc).html_safe
  end

  def main_image
    document.walk.find { |node| node.type == :image } &.url
  end
end
