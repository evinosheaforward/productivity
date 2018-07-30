class CreateAccomplishments < ActiveRecord::Migration[5.2]
  def change
    create_table :accomplishments do |t|
      t.string :name
      t.decimal :time_working
      t.decimal :time_productive
      t.datetime :date

      t.timestamps
    end
  end
end
