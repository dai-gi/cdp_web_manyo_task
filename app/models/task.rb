class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def set_date
    created_at.strftime("%Y/%m/%d %T %z")
  end
end
