class Category < ActiveRecord::Base
  attr_accessor :name
  belongs_to :movie
  validates :name, presence: true
end
