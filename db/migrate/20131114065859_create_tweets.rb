class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
        t.string :body
        t.belongs_to :user
      t.timestamps
    end
  end
end
