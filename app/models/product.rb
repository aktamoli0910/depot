#---
# Excerpted from "Agile Web Development with Rails 6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails6 for more book information.
#---
class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  #...

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
# 
  # validates :image_url, allow_blank: true, format: {
  #   with:    %r{\.(gif|jpg|png)\z}i,
  #   message: 'must be a URL for GIF, JPG or PNG image.'
  # }

  validates :image_url, presence: true, url: true
  validates :title, length: {minimum: 10},  uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, if: :price, comparison: { greater_than: :discount_price }, price: true
  validates :permalink, presence: true, uniqueness: true, format: { with: /\A[a-z0-9\-]+\z/, message: "must contain only lowercase letters, digits, and hyphens" }, permalink: true
  validates :description, description: true
  after_initialize :give_default_title, unless: :title
  before_validation :set_default_discount_price, unless: :discount_price
  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end

    def give_default_title
      self.title='abc'
    end

    def set_default_discount_price
      self.discount_price = self.price
    end
end
