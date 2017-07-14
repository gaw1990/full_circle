class Test < ApplicationRecord
  has_many :test_cases
  has_many :builds, through: :test_cases
end
