class TestCase < ApplicationRecord
  belongs_to :test
  belongs_to :run
  has_one :test_case_failure
end
