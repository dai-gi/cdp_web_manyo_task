require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:first_task) {create(:first_task)}
  let!(:second_task) {create(:second_task)}
  let!(:third_task) {create(:third_task)}

  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: '請求書作成'
        fill_in 'task[content]', with: 'Web制作代'
        click_on '登録する'
				visit tasks_path
				expect(page).to have_content '請求書作成'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時の降順で表示される' do
				expect(all('tbody tr')[0].text).to have_content first_task.set_date
				expect(all('tbody tr')[1].text).to have_content second_task.set_date
				expect(all('tbody tr')[2].text).to have_content third_task.set_date
      end
    end

    context '新たにタスクを作成した場合' do
      it '新しいタスクが一番上に表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'プレゼン'
        fill_in 'task[content]', with: 'プレゼン資料'
        click_on '登録する'
				expect(all('tbody tr')[0].text).to have_content Task.last.title
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
        visit tasks_path
        all('tbody tr')[0].click_link '詳細'
				expect(page).to have_content '書類作成'
				expect(page).to have_content '企画書を作成する。'
				expect(page).to have_content first_task.set_date
				expect(page).to have_link '編集'
				expect(page).to have_link '戻る'
      end
    end
  end
end