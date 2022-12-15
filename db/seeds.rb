50.times do |n|
  n += 1
  Task.create(title: "タスク#{n}", content: "タスク#{n}を行う" ,created_at: '2022-11-10'  )
end