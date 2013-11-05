class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
	t.integer :ticket_id
	t.integer :user_id
	t.boolean :isOwner
      t.timestamps
    end
  end
end
