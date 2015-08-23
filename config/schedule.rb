every 1.day, :at => '0:00 am' do
  command "backup perform -t database_backup"
end

every 1.week, :at => '0:30 am' do
  command "backup perform -t file_backup"
end
