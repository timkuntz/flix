module ApplicationHelper
  def nav_link_to(name, path)
    link_to name, path, class: class_for_path(path)
  end

  def class_for_path(path)
    current_page?(path) ? "active" : "inactive"
  end
end
