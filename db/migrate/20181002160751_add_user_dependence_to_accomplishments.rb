class AddUserDependenceToAccomplishments < ActiveRecord::Migration[5.2]
  def change
    add_reference :accomplishments, :user, foreign_key: true
		add_index :accomplishments, [:user_id, :created_at]
  end
end
