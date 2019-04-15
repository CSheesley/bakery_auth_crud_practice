class AddsEmailAndPasswordToBaker < ActiveRecord::Migration[5.1]
  def change
    add_column :bakers, :email, :string
    add_column :bakers, :password_digest, :string
  end
end
