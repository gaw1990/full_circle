class Project < ApplicationRecord
  belongs_to :circle_user
  has_many :builds
  has_many :test_cases, through: :builds
  has_many :test_case_failures, through: :test_cases
  has_many :tests, through: :test_cases
end
