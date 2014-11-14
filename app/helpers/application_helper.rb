module ApplicationHelper
  def humanized_page_title
    page_title.humanize
  end

  def facebook_login_path
    "/auth/facebook"
  end
end
