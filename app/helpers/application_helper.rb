module ApplicationHelper
  def boolean_icon(boolean)
    boolean ?
      "<i class='fa-solid fa-check text-success'></i>".html_safe :
      "<i class='fa-solid fa-xmark text-danger'></i>".html_safe
  end
end
