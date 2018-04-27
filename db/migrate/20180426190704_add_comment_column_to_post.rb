class AddCommentColumnToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comment, :string, array: true, default: []
  end
end
