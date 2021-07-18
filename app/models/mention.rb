class Mention < ApplicationRecord
  belongs_to :post

  after_create :fetch_source
  after_update :fetch_source, if: :saved_change_to_source?

  # TODO async
  def fetch_source
    puts 'FETCHING SOURCE'
    uri = URI.parse(source)
    response = Net::HTTP.get_response uri
    collection = Microformats.parse(response.body)

    update(data: collection.to_hash)
  rescue StandardError => exception
    # TODO better error handling?
    p exception
  end
end
