module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end
  
  def is_active?(link_path)
    if current_page?(link_path)
      "class=active"
    else
      ""
    end
  end
end
