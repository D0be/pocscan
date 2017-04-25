class CreateVullevels < ActiveRecord::Migration[5.0]
  def change
    create_table :vullevels do |t|
      t.string :levelname

      t.timestamps
    end
  end
end
