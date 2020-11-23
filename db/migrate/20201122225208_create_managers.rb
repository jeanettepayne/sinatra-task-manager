class CreateManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :managers do |t|
      t.string :name
      t.string :department
      t.string :title
      t.string :email
      t.string :password_digest
    end
  end
end
