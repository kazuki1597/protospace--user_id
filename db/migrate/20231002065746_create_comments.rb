class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :prototype,   null: false, foreign_key: true
      t.text :text,          null: false
      t.references :user,       null: false, foreign_key: true
    end
  end
end
