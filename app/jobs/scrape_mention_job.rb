class ScrapeMentionJob < ApplicationJob
  queue_as :default

  after_enqueue do |job|
    mention = job.arguments[0]
		puts "queuing update for #{mention.source}"
  end

  after_perform do |job|
    mention = job.arguments[0]
		puts "updated mention for #{mention.source}"
  end

  def perform(mention)
    uri = URI.parse(mention.source)
    response = Net::HTTP.get_response uri
    collection = Microformats.parse(response.body)

    mention.update(data: collection.to_hash)
  rescue StandardError => exception
    # TODO better error handling?
    puts "ERROR scraping mention from #{mention.source}:"
    p exception
  end
end
