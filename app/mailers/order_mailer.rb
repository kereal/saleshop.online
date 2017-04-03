class OrderMailer < ApplicationMailer

  def email_to_admin(order_id)
    @order = Order.find order_id
    mail(to: "kereal@gmail.com", subject: "[saleshop.online] Новый заказ! (\##{@order.id})")
    mail(to: "qvinton@gmail.com", subject: "[saleshop.online] Новый заказ! (\##{@order.id})")
  end

end
