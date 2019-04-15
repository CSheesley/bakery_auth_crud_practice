require "rails_helper"

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name } 
    it {should validate_presence_of :bake_time }
    it {should validate_presence_of :oven_temp }
  end

  describe 'relationships' do
    it { should belong_to :baker }
    it { should have_many(:ingredients).through(:recipe_ingredients)}
  end
end
