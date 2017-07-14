class Test < ApplicationRecord
  has_many :test_cases
  has_many :runs, through: :test_cases
end
