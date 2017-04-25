class Changetypevultypes < ActiveRecord::Migration[5.0]
  def change
		
		change_table :vultypes do |t|
			t.rename :type, :typename
		end
  end
end
