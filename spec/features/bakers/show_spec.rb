require 'rails_helper'

RSpec.describe 'Baker Profile Page', type: :feature do
  before :each do
    @baker = Baker.create(name: "Corey", email: "corey@email.com", password: "password", password_confirmation: "password")

    @cookies = @baker.recipes.create(name: "Cookies", bake_time: 15, oven_temp: 350)
    @cookies.ingredients.create(name: "Flour")
    @cookies.ingredients.create(name: "Peanut Butter")

    @brownies = @baker.recipes.create(name: "Brownies", bake_time: 40, oven_temp: 400)
    @brownies.ingredients.create(name: "Chocolate")
    @brownies.ingredients.create(name: "Egg")

    visit login_path

    fill_in "Email", with: "corey@email.com"
    fill_in "Password", with: "password"
    click_on "Submit"

    expect(current_path).to eq(profile_path)
  end

  context 'when I am logged in and visit my profile page' do
    it 'shows all of my recipes and their info, along with a link to edit or delete' do
      save_and_open_page
      within "#recipe-#{@cookies.id}" do
        expect(page).to have_content(@cookies.name)
        expect(page).to have_content("Bake Time: #{@cookies.bake_time}")
        expect(page).to have_content("Oven Temp: #{@cookies.oven_temp}")

        expect(page).to have_link("Ingredients")
        expect(page).to have_link("Edit")
        expect(page).to have_link("Delete")
      end

      within "#recipe-#{@brownies.id}" do
        expect(page).to have_content(@brownies.name)
        expect(page).to have_content("Bake Time: #{@brownies.bake_time}")
        expect(page).to have_content("Oven Temp: #{@brownies.oven_temp}")

        expect(page).to have_link("Ingredients")
        expect(page).to have_link("Edit")
        expect(page).to have_link("Delete")
      end
    end
  end

  context 'when I click on the add recipe link' do
    it 'shows a form which I can fill out, I receive a confirmation message, and I now see my added recipe' do

      click_on  "Add Recipe"
      expect(current_path).to eq(new_baker_recipe_path(@baker))

      fill_in "Name", with: "Muffins"
      fill_in "Bake Time", with: 30
      fill_in "Oven Temp", with: 450
      click_on "Submit"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Muffins Recipe Added!")

      @muffins = Recipe.last
      expect(page).to have_selector('section', id: "recipe-#{@muffins.id}")
    end
  end

  context 'when I click on the edit recipe link' do
    it 'shows a pre-filled form which I can edit, I receive a confirmation message once submitted, and I now see my edited recipe' do

      within "#recipe-#{@brownies.id}" do
        click_on  "Edit"
        expect(current_path).to eq(edit_baker_recipe_path(@baker, @brownies))
      end

      expect(find_field("Name").value).to eq("#{@brownies.name}")
      expect(find_field("Bake Time").value).to eq("#{@brownies.bake_time}")
      expect(find_field("Oven Temp").value).to eq("#{@brownies.oven_temp}")

      fill_in "Name", with: "Gluten Free Brownies"
      fill_in "Bake Time", with: 30
      fill_in "Oven Temp", with: 450
      click_on "Submit"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Recipe Updated")
      expect(page).to have_content("Gluten Free Brownies")
    end
  end

  context 'when I click on the delete recipe link' do
    it 'I receive a confirmation message, and I no longer see my recipe' do

      expect(@baker.recipes).to eq([@cookies, @brownies])

      within "#recipe-#{@brownies.id}" do
        click_on  "Delete"
      end

      expect(current_path).to eq(profile_path)
      expect(page).to_not have_content("#{@brownies.name} recipe deleted")

      @baker.reload
      expect(page).to_not have_selector('section', id: "recipies-#{@brownies.id}")
      expect(@baker.recipes).to eq([@cookies])
    end
  end
end
  # click on ingredients - see ingredients index - add ingredients (form_for nested)
