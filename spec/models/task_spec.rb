require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: '', content: '企画書を作成する。')
        expect(task).not_to be_valid
      end
    end

    context 'タスクの説明が空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: '企画書作成', content: '')
        expect(task).not_to be_valid
      end
    end

    context 'タスクのタイトルと説明に値が入っている場合' do
      it 'タスクを登録できる' do
        task = Task.create(title: '企画書作成', content: '企画書を作成する。')
        expect(task).to eq task
      end
    end
  end

  describe '検索機能' do
    subject { described_class.search(@task_params) }

    let!(:first_task) {create(:first_task)}
    let!(:second_task) {create(:second_task)}
    let!(:third_task) {create(:third_task)}

    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索ワードを含むタスクが絞り込まれる" do
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        @task_params = ActionController::Parameters.new(title: "書類")
        is_expected.to eq [first_task]
        is_expected.not_to eq [second_task]
        is_expected.not_to eq [third_task]
        # 検索されたテストデータの数を確認する
        expect(subject.count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        @task_params = ActionController::Parameters.new(status: "着手中")
        is_expected.to eq [second_task]
        is_expected.not_to eq [first_task]
        is_expected.not_to eq [third_task]
        # 検索されたテストデータの数を確認する
        expect(subject.count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索ワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        @task_params = ActionController::Parameters.new(title: "請求書作成", status: "完了")
        is_expected.to eq [third_task]
        is_expected.not_to eq [first_task]
        is_expected.not_to eq [second_task]
        # 検索されたテストデータの数を確認する
        expect(subject.count).to eq 1
      end
    end
  end
end
