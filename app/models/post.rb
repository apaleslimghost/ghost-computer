class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  after_initialize :defaults

  def defaults
    self.posted ||= Date.today
  end
end
