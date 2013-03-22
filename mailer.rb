require 'mandrill'

def send_email(email_address, subject, body)
  mailer = Mandrill::API.new
  config = {
    :html => body,
    :from_email => "casey@kolderup.org",
    :from_name => "Scrobblehop",
    :subject => subject,
    :to => [ {:email => email_address} ],
    :async => true
  }
  mailer.messages.send(config)
end
