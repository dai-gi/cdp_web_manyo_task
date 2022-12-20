priority = '低'
status = '完了'
created_at = '2022-11-10'
deadline_on = '2022-11-25'

50.times do |n|
  n += 1

  case n
  when 20 then
    priority = '高'
    status = '着手中'
    created_at = '2022-11-15'
    deadline_on = '2022-11-30'
  when 35 then
    priority = '中'
    status = '未着手'
    created_at = '2022-11-20'
    deadline_on = '2022-12-1'
  end

  Task.create(title: "タスク#{n}", content: "タスク#{n}を行う" ,created_at: "#{created_at}", deadline_on: "#{deadline_on}", priority: "#{priority}", status: "#{status}")
end