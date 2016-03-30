module MoviesHelper

  def formatted_date(date)
    # if !date.nil?
      date.strftime("%b %d, %Y")
    # else
    #   "Release date not yet provided."
    # end
  end
  
end
