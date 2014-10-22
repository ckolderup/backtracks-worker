require 'json'
require 'httparty'

desc "This task is called by the Heroku scheduler add-on"
task :send_emails, [:day] => :environment do |t, args|
  puts "Sending email..."
  @subject = "Your BackTracks for the Week"
  @admin = 'ckolderup@gmail.com'

  b = 7
  p = args[:day] || Time.now.wday

  #TODO: don't always fetch from production
  response = HTTParty.get("http://backtracks.co/fetch?key=#{ENV['BACKTRACKS_API']}&p=#{p}&b=#{b}")

  if response.code != 200 then
    Mailer.send_email(@admin, 'UNABLE TO FETCH FROM BACKTRACKS USER DB', '')
  else
    users = JSON.parse(response.body)

    count = 0
    users.each do |u|
      count += 1 if Mailer.send_email(u['email'], @subject, Scrobble.chart_v1(u['username']))
    end
    Mailer.send_email(@admin, "Sent #{count} emails (#{users.size} possible users).", '')
  end
end
