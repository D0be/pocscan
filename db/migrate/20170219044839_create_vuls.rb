class CreateVuls < ActiveRecord::Migration[5.0]
  def change
    create_table :vuls do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :description
      t.integer :type_id
      t.integer :level_id
      t.string :search_key
      t.string :file

      t.timestamps
    end
		add_index :vuls, :type_id
		add_index :vuls, :level_id
		add_index :vuls, [:user_id, :created_at]
  end
end
