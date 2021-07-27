task update_mentions: [:environment] do
	Mention.all.each do |mention|
		ScrapeMentionJob
			.set(priority: 10)
			.perform_later(mention)
	end
end
