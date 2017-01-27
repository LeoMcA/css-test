class CreateGeneratedQueuedPosts < ActiveRecord::Migration
  def change
    create_table :post_generator_generated_queued_posts do |t|
      t.datetime :datetime, null: false
      t.belongs_to :user, index: true, null: false
      t.belongs_to :category, index: true
      t.string :topic_title
      t.string :topic_id
      t.text :raw, null: false
      t.timestamps
    end
  end
end
