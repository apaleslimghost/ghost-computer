class Mention < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :post

  after_create :fetch_source!
  after_update :fetch_source!, if: :saved_change_to_source?

  def fetch_source!
    ScrapeMentionJob.perform_later self
  end

  def first_h_entry
    return unless data

    data["items"].find do |entry|
      entry["type"].include? "h-entry"
    end
  end

  def title
    if h_entry = first_h_entry
      h_entry.dig("properties", "name", 0)
    end
  end

  def author
    if h_entry = first_h_entry
      h_entry.dig("properties", "author", 0, "properties")&.transform_values(&:first)
    end
  end

  def is_like?
    if h_entry = first_h_entry
      h_entry["properties"].has_key?("like-of") && h_entry["properties"]["like-of"].one? do |like|
        if like.is_a? String
           like == post_url(post)
        elsif like.is_a?(Hash) && like.has_key?("properties")
          like["properties"]["url"][0] == post_url(post)
        end
      end
    end
  end

  def is_repost?
    if h_entry = first_h_entry
      h_entry["properties"].has_key?("repost-of") && h_entry["properties"]["repost-of"].include?(post_url(post))
    end
  end
end
