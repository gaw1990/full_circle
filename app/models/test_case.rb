class TestCase < ApplicationRecord
  belongs_to :test
  belongs_to :build
  has_one :test_case_failure
end
