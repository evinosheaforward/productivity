class CreateAccomplishments < ActiveRecord::Migration[5.2]
  def change
    create_table :accomplishments do |t|
      t.string :name
      t.decimal :timeWorking
      t.decimal :timeProductive
      t.datetime :date

      t.timestamps
    end
  end
end
