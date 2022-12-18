class Task < ApplicationRecord

  enum priority: [ "低", "中", "高"]
  enum status: [ "未着手", "着手中", "完了"]

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  def set_date
    created_at.strftime("%Y/%m/%d %R %z")
  end

  def set_deadline_on
    deadline_on.strftime("%F")
  end
end
