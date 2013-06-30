desc "This task is called by the Heroku scheduler add-on"
task :send_emails => :environment do
  puts "Sending email..."
  @subject = "Weekly Album Charts"

  #TODO: fetch these from the web process by day-partition
  @users = [ {email: 'ckolderup@gmail.com', username: 'caseyk'} ]


  @users.each do |u|
    Mailer.send_email(u[:email], @subject, Scrobble.chart_v1(u[:username]))
  end
  puts "done."
end

