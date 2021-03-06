require 'mandrill'

module Mailer
  def self.send_email(email_address, subject, body)
    return false if body.nil?

    mailer = Mandrill::API.new
    config = {
      :html => body,
      :from_email => "feedback@backtracks.co",
      :from_name => "BackTracks",
      :subject => subject,
      :to => [ {:email => email_address} ],
      :async => true
    }
    result = mailer.messages.send(config)
    (result.first)[:status] == "sent"

    return true
  end
end
