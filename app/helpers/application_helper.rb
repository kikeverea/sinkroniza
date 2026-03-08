module ApplicationHelper
  def boolean_icon(boolean)
    boolean ?
      "<i class='fa-solid fa-check text-success'></i>".html_safe :
      "<i class='fa-solid fa-xmark text-danger'></i>".html_safe
  end

  def badge(text, color, classes: "")
    "<span class='badge text-white text-bg-#{color} #{classes}'>#{text}</span>".html_safe
  end
end
