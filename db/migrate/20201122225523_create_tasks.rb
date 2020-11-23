class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :due_date
      t.string :priority
      t.integer :employee_id
    end
  end
end
