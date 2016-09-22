class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :pledges
  has_many :users, through: :pledges
  has_many :rewards, inverse_of: :project
  accepts_nested_attributes_for :rewards, allow_destroy: true

  validates :startdate, presence: true
  validates :finishdate, presence: true
  validate :project_finishdate_larger_than_current_date, :project_startdate_larger_than_current_date, :startdate_earlier_than_finishdate;

  def project_finishdate_larger_than_current_date
    if finishdate.present? && finishdate < Date.today
      errors.add(:enddate, "Selected date must be larger than current date")
   end
  end

  def project_startdate_larger_than_current_date
      if startdate.present? && startdate < Date.today
        errors.add(:startdate, "Selected date must be larger than current date")
     end
  end

  def startdate_earlier_than_finishdate
    if finishdate < startdate
      errors.add(:datecompare, "End date must be after start date")
    end
  end

end
