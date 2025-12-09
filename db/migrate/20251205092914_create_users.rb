# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      # Core auth fields
      t.string :email, null: false
      t.string :phone_number, null: true
      t.string :password_digest, null: false
      t.string :username

      # Custom fields (keep these)
      t.integer :role, default: 0  # user=0, admin=1
      t.boolean :email_verified, default: false
      t.text :bio
      t.bigint :subscription_id

      # Optional: password reset (minimal)
      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      # otp verification
      t.string :otp_code
      t.datetime :otp_expires_at

      t.timestamps
    end

    # Indexes
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :users, :password_reset_token, unique: true
    add_index :users, :subscription_id
    add_index :users, :otp_code
  end
end
