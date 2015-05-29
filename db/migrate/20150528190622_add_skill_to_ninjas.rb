class AddSkillToNinjas < ActiveRecord::Migration
  def change
    add_column :ninjas, :skill, :string
  end
end
