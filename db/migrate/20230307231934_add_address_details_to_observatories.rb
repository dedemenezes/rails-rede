class AddAddressDetailsToObservatories < ActiveRecord::Migration[7.0]
  def change
    add_column :observatories, :street, :string
    add_column :observatories, :number, :string
    add_column :observatories, :city, :string
    add_column :observatories, :state, :string
    add_column :observatories, :zip_code, :string
    add_column :observatories, :neighborhood, :string
    add_column :observatories, :municipality, :string
  end
end
