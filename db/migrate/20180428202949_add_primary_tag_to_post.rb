class AddPrimaryTagToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :main_tag, :string
  end
end
