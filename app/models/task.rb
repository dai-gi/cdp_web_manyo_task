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

  scope :choose_tasks_processing, -> (processing_params) do
    normal(processing_params)
    .search(processing_params)
    .sort_deadline_on(processing_params[:sort_deadline_on])
    .sort_priority(processing_params[:sort_priority])
  end

  scope :normal, -> (processing_params) { order(created_at: :DESC) if processing_params.blank? }

  scope :search, -> (processing_params) {
    if processing_params[:title].present? and processing_params[:status].present?
      where("title LIKE ?", "%#{processing_params[:title]}%").where(status: processing_params[:status])
    elsif processing_params[:title].present?
      where("title LIKE ?", "%#{processing_params[:title]}%")
    elsif processing_params[:status].present?
      where(status: processing_params[:status])
    end
  }

  scope :sort_deadline_on, -> (processing_params) { order(deadline_on: :ASC) if processing_params.present? }

  scope :sort_priority, -> (processing_params) { order(priority: :DESC) if processing_params.present? }

end