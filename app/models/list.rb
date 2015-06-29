class List < ActiveRecord::Base

  has_many :items
  belongs_to :user

  validates :name, presence: true
  validates :permission, presence: true, inclusion: { in: %w(private viewable open)}

end
