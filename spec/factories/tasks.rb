FactoryBot.define do
	factory :first_task, class: Task do
		title { '書類作成' }
		content { '企画書を作成する。' }
		created_at { '2025-11-18' }
		deadline_on { '2025-11-18' }
		priority { '中' }
		status { '未着手' }
  end

	factory :second_task, class: Task do
		title { 'メール送信' }
		content { '顧客に営業のメールを送る。' }
		created_at { '2025-11-17' }
		deadline_on { '2025-11-17' }
		priority { '高' }
		status { '着手中' }
  end

	factory :third_task, class: Task do
		title { '請求書作成' }
		content { 'Webアプリケーション作成' }
		created_at { '2025-11-16' }
		deadline_on { '2025-11-16' }
		priority { '低' }
		status { '完了' }
  end
end