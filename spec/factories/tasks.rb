FactoryBot.define do
	factory :first_task, class: Task do
		title { '書類作成' }
		content { '企画書を作成する。' }
		created_at { '2022-11-18' }
  end

	factory :second_task, class: Task do
		title { 'メール送信' }
		content { '顧客に営業のメールを送る。' }
		created_at { '2022-11-17' }
  end

	factory :third_task, class: Task do
		title { '請求書作成' }
		content { 'Webアプリケーション作成' }
		created_at { '2022-11-16' }
  end
end