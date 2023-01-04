require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  describe '登録機能' do
    let!(:first_task) {create(:first_task, created_at: '2022-11-18')}
    let!(:second_task) {create(:second_task, created_at: '2022-11-17')}
    let!(:third_task) {create(:third_task, created_at: '2022-11-16')}

    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: '請求書作成'
        fill_in 'task[content]', with: 'Web制作代'
        fill_in 'task[deadline_on]', with: Date.new(2023, 2, 18)
        select '高', from: 'task_priority'
        select '着手中', from: 'task_status'
        click_on '登録する'
				visit tasks_path
				expect(page).to have_content '請求書作成'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:first_task) {create(:first_task, created_at: '2022-11-18')}
    let!(:second_task) {create(:second_task, created_at: '2022-11-17')}
    let!(:third_task) {create(:third_task, created_at: '2022-11-16')}


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
        fill_in 'task[deadline_on]', with: Date.new(2023, 2, 18)
        select '高', from: 'task_priority'
        select '着手中', from: 'task_status'
        click_on '登録する'
				expect(all('tbody tr')[0].text).to have_content Task.last.title
      end
    end
  end

  describe '詳細表示機能' do
    let!(:first_task) {create(:first_task, created_at: '2022-11-18')}
    let!(:second_task) {create(:second_task, created_at: '2022-11-17')}
    let!(:third_task) {create(:third_task, created_at: '2022-11-16')}


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

  describe 'ソート機能' do
    before do
      visit tasks_path
      create(:first_task, created_at: '2022-11-18')
      create(:second_task, created_at: '2022-11-17')
      create(:third_task, created_at: '2022-11-16')
    end

    context '「終了期限」というリンクをクリックした場合' do
      it "終了期限昇順に並び替えられたタスク一覧が表示される" do
        # allメソッドを使って複数のテストデータの並び順を確認する
        all('thead tr')[0].click_link '終了期限'
				expect(all('tbody tr')[0].text).to have_content Task.find_by(title: '請求書作成').title
				expect(all('tbody tr')[1].text).to have_content Task.find_by(title: 'メール送信').title
        expect(all('tbody tr')[2].text).to have_content Task.find_by(title: '書類作成').title
      end
    end

    context '「優先度」というリンクをクリックした場合' do
      it "優先度の高い順に並び替えられたタスク一覧が表示される" do
        # allメソッドを使って複数のテストデータの並び順を確認する
        all('thead tr')[0].click_link '優先度'
				expect(all('tbody tr')[0].text).to have_content Task.find_by(title: 'メール送信').title
        expect(all('tbody tr')[1].text).to have_content Task.find_by(title: '書類作成').title
				expect(all('tbody tr')[2].text).to have_content Task.find_by(title: '請求書作成').title
      end
    end
  end

  describe '検索機能' do
    let!(:first_task) {create(:first_task, created_at: '2022-11-18')}
    let!(:second_task) {create(:second_task, created_at: '2022-11-17')}
    let!(:third_task) {create(:third_task, created_at: '2022-11-16')}

    before do
      visit tasks_path
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索ワードを含むタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        fill_in 'task[title]', with: '書類作成'
        click_on '検索'
				expect(all('tbody tr')[0].text).to have_content first_task.title
				expect(all('tbody tr')[0].text).not_to have_content second_task.title
				expect(all('tbody tr')[0].text).not_to have_content third_task.title
      end
    end
    context 'ステータスで検索した場合' do
      it "検索したステータスに一致するタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        select '完了', from: 'task_status'
        click_on '検索'
				expect(all('tbody tr')[0].text).to have_content third_task.title
				expect(all('tbody tr')[0].text).not_to have_content first_task.title
				expect(all('tbody tr')[0].text).not_to have_content second_task.title
      end
    end
    context 'タイトルとステータスで検索した場合' do
      it "検索ワードをタイトルに含み、かつステータスに一致するタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        select '着手中', from: 'task_status'
        fill_in 'task[title]', with: 'メール'
        click_on '検索'
				expect(all('tbody tr')[0].text).to have_content second_task.title
				expect(all('tbody tr')[0].text).not_to have_content first_task.title
				expect(all('tbody tr')[0].text).not_to have_content third_task.title
      end
    end
  end
end