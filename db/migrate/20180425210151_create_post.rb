class CreatePost < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :hypothetical
      t.string :tags, array: true, default: []
    end
  end
end
