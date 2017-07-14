class CircleUser < ApplicationRecord
  has_many :projects
  has_many :builds, through: :projects
  has_many :test_cases, through: :builds
  has_many :tests, through: :test_cases
end
