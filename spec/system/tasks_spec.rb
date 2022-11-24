require 'rails_helper'

# 「タスクを登録した場合、登録したタスクが表示される」のテストが成功すること
# 「一覧画面に遷移した場合、登録済みのタスク一覧が表示される」のテストが成功すること
# 「任意のタスク詳細画面に遷移した場合、そのタスクの内容が表示される」のテストが成功すること
# コードが正しいかを検証できるテストが記述されていること

RSpec.describe 'タスク管理機能', type: :system do
  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        visit new_task_path
        fill_in 'Title', with: '請求書作成'
        fill_in 'Content', with: 'Web制作代'
        click_on 'Create Task'
				visit tasks_path
				expect(page).to have_content '請求書作成'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '登録済みのタスク一覧が表示される' do
				task = FactoryBot.create(:task)
				second_task = FactoryBot.create(:second_task)
				visit tasks_path
				expect(page).to have_content '書類作成'
				expect(page).to have_content 'メール送信'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
				task = FactoryBot.create(:task)
				visit tasks_path
        all('tbody tr')[0].click_link 'Show'
				expect(page).to have_content '書類作成'
				expect(page).to have_content '企画書を作成する。'
				expect(page).to have_content task.created_at
				expect(page).to have_link 'Edit'
				expect(page).to have_link 'Back'
      end
    end
  end
end