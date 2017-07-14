class Application < ApplicationRecord
  has_many :runs
  has_many :test_cases, through: :runs
  has_many :tests, through: :test_cases
end
