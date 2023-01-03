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

  scope :search, -> (task_params) do

    if task_params[:sort_deadline_on].present?
      order(deadline_on: :ASC)
    elsif task_params[:sort_priority].present?
      order(priority: :DESC)
    elsif task_params.present?
      if task_params[:title].present? and task_params[:status].present?
        where("title LIKE ?", "%#{task_params[:title]}%").where(status: task_params[:status])
      elsif task_params[:title].present?
        where("title LIKE ?", "%#{task_params[:title]}%")
      elsif task_params[:status].present?
        where(status: task_params[:status])
      end
    else
      order(created_at: :DESC)
    end

  end
end