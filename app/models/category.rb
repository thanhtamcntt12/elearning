class Category < ApplicationRecord
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50, minimum: 3}
  accepts_nested_attributes_for :words

  scope :alphabetically, ->{order name: :asc}
  scope :order_date_desc, ->{order created_at: :desc}
  scope :search_name, ->name do
    where "name LIKE ?", "%#{name}%" if name.present?
  end
end
