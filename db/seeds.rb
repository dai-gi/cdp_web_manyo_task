priority = '高'
status = '完了'

50.times do |n|
  n += 1

  case n
  when 20 then
    priority = '中'
    status = '着手中'
  when 35 then
    priority = '低'
    status = '未着手'
  end

  Task.create(title: "タスク#{n}", content: "タスク#{n}を行う" ,created_at: '2022-11-10', deadline_on: '2022-11-30', priority: "#{priority}", status: "#{status}")
end