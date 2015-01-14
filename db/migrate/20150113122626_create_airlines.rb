class CreateAirlines < ActiveRecord::Migration
  def change
    create_table :airlines do |t|

      t.string :name
      t.string :iata
      t.string :icao
      t.string :url

      t.timestamps
    end
  end
end
