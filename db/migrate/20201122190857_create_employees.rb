class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :department
      t.string :title
      t.string :email
      t.string :password_digest
      t.integer :manager_id
    end
  end
end
