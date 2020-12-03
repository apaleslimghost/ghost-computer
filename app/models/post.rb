class Post < ApplicationRecord
  after_initialize :defaults

  def defaults
    self.posted ||= Date.today
  end
end
