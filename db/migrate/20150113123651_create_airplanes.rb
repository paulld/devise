class CreateAirplanes < ActiveRecord::Migration
  def change
    create_table :airplanes do |t|

      t.integer :airline_id

      t.string :registration_code
      t.string :mode_s
      t.string :plane_type_code
      t.string :plane_type
      t.string :s_n

      t.timestamps
    end
  end
end
