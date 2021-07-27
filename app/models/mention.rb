class Mention < ApplicationRecord
  belongs_to :post

  after_create :fetch_source
  after_update :fetch_source, if: :saved_change_to_source?

  # TODO async
  def fetch_source
    uri = URI.parse(source)
    response = Net::HTTP.get_response uri
    collection = Microformats.parse(response.body)

    update(data: collection.to_hash)
  rescue StandardError => exception
    # TODO better error handling?
    p exception
  end

  def first_h_entry
    return unless data

    data["items"].find do |entry|
      entry["type"].include? "h-entry"
    end
  end

  def title
    if h_entry = first_h_entry
      h_entry["properties"]["name"][0]
    end
  end

  def author
    if h_entry = first_h_entry
      h_entry["properties"]["author"][0]["properties"].transform_values(&:first)
    end
  end

end
