class Project < ApplicationRecord
  has_many :builds
  has_many :test_cases, through: :builds
  has_many :tests, through: :test_cases
end
