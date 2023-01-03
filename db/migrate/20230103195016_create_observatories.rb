class CreateObservatories < ActiveRecord::Migration[7.0]
  def change
    create_table :observatories do |t|
      t.string :headline
      t.string :name
      t.string :description
      t.string :email
      t.string :phone_number
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :type
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
