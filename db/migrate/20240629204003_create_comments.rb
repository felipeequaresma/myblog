class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.string :name
      t.text :comment
      t.references :post, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
