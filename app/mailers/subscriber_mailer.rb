class SubscriberMailer < ApplicationMailer


  def confirm_email(subscriber_id)

    @subscriber = Subscriber.find subscriber_id
    mail(to: @subscriber.email, subject: 'Подтвердите подписку на рассылку!')

  end


  
  

end
