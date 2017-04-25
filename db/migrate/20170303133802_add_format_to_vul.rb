class AddFormatToVul < ActiveRecord::Migration[5.0]
  def change
    add_column :vuls, :format, :string
  end
end
