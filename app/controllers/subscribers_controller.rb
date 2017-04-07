class SubscribersController < ApplicationController

  # подписка на рассылку
  def subscribe
    @subscriber = Subscriber.find_by_email(params[:subscriber][:email]) || Subscriber.new(email: params[:subscriber][:email])
    # уже подписан и подтвержден
    if @subscriber.active?
      render :confirm
    else
      # подтвержден, но отписан -> подпишем обратно
      #if @subscriber.confirmed? and not @subscriber.subscribed?
      @subscriber.subscribed = true if not @subscriber.subscribed?
      if @subscriber.save
        # отправка письма для подтверждения подписки
        SubscriberMailer.confirm_email(@subscriber.id).deliver_later
      else
        render html: 'Ошибка подписки', layout: true
      end
    end
  
  end

  # подтверждение подписки (меняем флаг)
  def confirm
    @subscriber = Subscriber.find_by_token params[:token]
    unless @subscriber.present? && @subscriber.update(confirmed: true)
      render html: 'Ошибка подтверждения', layout: true
    end
  end

  # отписка (меняем флаг)
  def unsubscribe
    @subscriber = Subscriber.subscribed.find_by_token params[:token]
    unless @subscriber.present? && @subscriber.update(subscribed: false)
      render html: 'Ошибка отмены подписки. Возможно Вы отменили подписку ранее или не были подписаны.', layout: true
    end
  end

end
