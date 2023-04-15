class ChangePermalinkInProducts < ActiveRecord::Migration[7.0]
  def change
    def up
      change_column :products, :permalink, :text
    end
  
    def down
      change_column :products, :permalink, :string
    end
  
  end
end
