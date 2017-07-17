class Build < ApplicationRecord
  belongs_to :project
  has_many :test_cases
  has_many :tests, through: :test_cases

  lookup_for :suite_type
  lookup_for :build_status
end
