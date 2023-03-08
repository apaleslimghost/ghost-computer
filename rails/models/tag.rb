class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  def to_param
    name
  end

  def self.tags_from_string(tags_string)
    tags_from_array tags_string.split(/[, ]/)
  end

  def self.tags_from_array(tags)
    tags
      .map(&:strip)
      .map(&:parameterize)
      .reject(&:blank?)
      .map { |t| Tag.find_or_create_by(name: t) }
      .uniq
  end
end
