class Mention < ApplicationRecord
  belongs_to :post

  after_save :fetch_source, if: :saved_change_to_source?

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
end
