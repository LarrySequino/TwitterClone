class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
        t.belongs_to :tweet
        t.belongs_to :user
      t.timestamps
    end
  end
end
