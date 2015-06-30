class AddTwoFactorColumns < ActiveRecord::Migration
  def change
  	add_column :users, :pin, :string
  	# add_column :users, :phone_number, :pin

  	# accidentally setting type as ":pin" instead of ":string" caused major
  	# flaws with database, disabling db:rollback and db:migrate.  Manual
  	# adjustment of the database was required, hence the change to this
  	# migration.  The next migration (...change_users_pin_column_type.rb)
  	# will now create the pin column instead of trying to update it.
  end
end
