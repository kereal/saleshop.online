module ApplicationHelper

  # для генерации <title> страниц
  def title(text)
    content_for :title, text
  end

end
