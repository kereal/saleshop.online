class OrderMailer < ApplicationMailer

  def email_to_admin(order_id)
    @order = Order.find order_id
    mail(to: ["kereal@gmail.com", "info@saleshop.online", "Miloserdovalex@mail.ru"], subject: "[saleshop.online] Новый заказ! (\##{@order.id})")
  end

end
