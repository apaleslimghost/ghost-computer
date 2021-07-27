task update_mentions: [:environment] do
	Mention.all.each do |mention|
		ScrapeMentionJob.perform_later(mention)
	end
end
