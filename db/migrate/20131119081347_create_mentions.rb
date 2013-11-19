class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
        t.belongs_to :user
        t.belongs_to :tweet
      t.timestamps
    end
  end
end
