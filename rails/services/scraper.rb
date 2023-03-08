class Scraper
	def initialize(source)
		@uri = URI.parse(source)
	end

	def body
		@body ||= Net::HTTP.get_response(@uri).body
	end

	def microformats
		Microformats.parse(body).to_hash
	end
end
