class TestCase < ApplicationRecord
  belongs_to :test
  belongs_to :build

  lookup_for :test_case_result
end
