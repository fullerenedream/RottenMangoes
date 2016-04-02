class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  # validates :poster_image_url,
  #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  mount_uploader :poster, PosterUploader

  def review_average
    if reviews.size > 0
      "#{reviews.sum(:rating_out_of_ten)/reviews.size}/10"
    else
      "This movie has not yet been rated."
    end
  end

  def self.search_by_title(title)
    self.where("title like ?", title)
  end

  def self.search_by_director(director)
    self.where("director like ?", director)
  end

  def self.search_by_duration(duration)
    if duration == "Under 90 minutes"
      result = self.where("runtime_in_minutes < '90'")
    elsif duration == "Between 90 and 120 minutes"
      result = self.where("runtime_in_minutes >= '90' AND runtime_in_minutes < '120'")
    elsif duration == "Over 120 minutes"
      result = self.where("runtime_in_minutes > '120'")
    end
    result
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
