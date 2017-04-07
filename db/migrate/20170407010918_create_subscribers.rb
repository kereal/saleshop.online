class CreateSubscribers < ActiveRecord::Migration[5.0]

  def change

    create_table :subscribers do |t|
      t.string :email, unique: true
      t.string :token, unique: true
      t.boolean :confirmed, default: false
      t.boolean :subscribed, default: true
      t.timestamps
    end

  end

end
