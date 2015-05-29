class AddTeamToNinjas < ActiveRecord::Migration
  def change
    add_column :ninjas, :team, :string
  end
end
