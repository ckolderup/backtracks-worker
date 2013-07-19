require 'json'
require 'httparty'

desc "This task is called by the Heroku scheduler add-on"
task :send_emails => :environment do
  puts "Sending email..."
  @subject = "Your BackTracks for the Week"
  @admin = 'ckolderup@gmail.com'

  response = HTTParty.get("http://backtracks.co/fetch?key=#{ENV['BACKTRACKS_API']}")

  if response.code != 200 then
    Mailer.send_email(@admin, 'UNABLE TO FETCH FROM BACKTRACKS USER DB', '')
  else
    users = JSON.parse(response.body)

    users.each do |u|
      Mailer.send_email(u['email'], @subject, Scrobble.chart_v1(u['username'], [1,2,3]))
    end
    Mailer.send_email(@admin, "Processed #{users.size} users successfully.", '')
  end
end

task :send_casey_email => :environment do
  Mailer.send_email('ckolderup@gmail.com', 'BackTracks Manually Triggered Test Email', Scrobble.chart_v1('caseyk', [1,2,3,5,10]))
end
