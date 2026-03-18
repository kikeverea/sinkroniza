module ApplicationHelper
  def boolean_icon(boolean)
    boolean ?
      "<i class='fa-solid fa-check text-success'></i>".html_safe :
      "<i class='fa-solid fa-xmark text-danger'></i>".html_safe
  end

  def badge(text, color, classes: "", color_as_style: false)
    "<span class='badge text-white #{"text-bg-#{color}" unless color_as_style} #{classes}' #{"style='background-color: #{color};'" if color_as_style}'}>#{text}</span>".html_safe
  end

  def can_read_user_roles(roles, cancancan)
    roles.reduce(true) { |can_read, role| can_read && cancancan.call(role) }
  end

  def to_currency(amount)
    "#{number_to_currency(amount, unit: '', separator: ',', delimiter: '.', precision: 2)} €"
  end
end
