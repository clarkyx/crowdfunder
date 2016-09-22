class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :pledges
  has_many :users, through: :pledges
  has_many :rewards, inverse_of: :project
  accepts_nested_attributes_for :rewards
end
