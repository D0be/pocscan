class CreatePorts < ActiveRecord::Migration[5.0]
  def change
    create_table :ports do |t|
      t.string :title
      t.string :target
      t.integer :status

      t.timestamps
    end
  end
end
