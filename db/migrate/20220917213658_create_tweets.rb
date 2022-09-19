class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :content
      t.references :user, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
