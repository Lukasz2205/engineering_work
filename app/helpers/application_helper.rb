module ApplicationHelper
  include Pagy::Frontend

  def date_format(date)
    time_ago_in_words(date)
  end
end
