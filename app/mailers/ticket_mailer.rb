class TicketMailer < ActionMailer::Base
  default :from => "wds@semo.edu"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ticket_mailer.updated.subject
  #
  def updated(ticket, currentUser)
	@ticket = ticket
	@emails = Array.new

    @ticket.users.each do |email|
        if !(email.seKey == currentUser)
           @emails.push(email.seKey + "@semo.edu")
        end
     end

    mail :to => @emails, :subject => ticket.responses.last.user.fName + " " + ticket.responses.last.user.lName + " responded to ticket " + "#%06d" % ticket.id
  end
end
