class AddProfilePictureAndNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile_picture, :string
    add_column :users, :name, :string
  end
end
