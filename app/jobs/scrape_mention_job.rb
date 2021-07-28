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
    scraper = Scraper.new(mention.source)
    mention.update(data: scraper.microformats)
  rescue StandardError => exception
    # TODO better error handling?
    puts "ERROR scraping mention from #{mention.source}:"
    p exception
  end
end
