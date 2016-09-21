class User < ApplicationRecord
  has_many :owned_projects, class_name: "Project"
  has_many :pledges
  has_many :projects, through: :pledges
  has_many :rewards, through: :projects
end
