class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :header
      t.string :sub_header

      t.timestamps
    end
  end
end
