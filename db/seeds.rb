contents = ['買い物', 'ジムに行く', '晩御飯を作る', '打ち合わせ', '犬の散歩']
created_at = ['2023-2-18', '2023-2-17', '2023-2-16', '2023-2-15', '2023-2-14']
deadline_on = ['2023-3-18', '2023-3-17', '2023-3-16', '2023-3-15', '2023-3-14']
priorities = ['低', '中', '高']
status = ['未着手', '着手中', '完了']

10.times do |i|
  Task.create(title: "タスク#{i+1}", content: contents[rand(0..4)], created_at: created_at[rand(0..4)], deadline_on: deadline_on[rand(0..4)], priority: priorities[rand(0..2)], status: status[rand(0..2)])
end