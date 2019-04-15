class Recipe < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :bake_time
  validates_presence_of :oven_temp


  belongs_to :baker
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients, dependent: :destroy

end
