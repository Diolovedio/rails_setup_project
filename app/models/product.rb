class Product < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  validates :sku, presence: true, uniqueness: true,
    format: { with: /\A[a-zA-Z0-9]+\z/, message: :invalid_sku }
  validates :minimum_stock, presence: true,
    numericality: { greater_than_or_equal_to: 0, only_integer: true }

  scope :by_name, ->(name) { where("unaccent(name) ILIKE unaccent(?)", "%#{name}%") }
  scope :ordered_by, ->(field, direction) {
    col = sanitize_field(field)
    dir = sanitize_direction(direction)
    order(arel_table[col].public_send(dir))
  }

  def self.sanitize_field(field)
    %w[id name sku].include?(field.to_s) ? field.to_s : "id"
  end

  def self.sanitize_direction(direction)
    direction.to_s.downcase == "desc" ? :desc : :asc
  end

end
