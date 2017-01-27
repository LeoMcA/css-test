module PostGenerator
  class GeneratedQueuedPost < ActiveRecord::Base
    belongs_to :category
    belongs_to :user

    attr_accessor :username

    before_validation do
      user = User.find_by_username(self.username)
      unless user
        user = User.new(:username => self.username,
                        :email => "fake+#{self.username}@example.com")
        user.save!
      end
      self.user_id = user.id
    end

    def self.new_from_csv(row)
      category = Category.find_by_slug(row[2])
      category_id = category.nil? ? -1 : category.id
      generated_queued_post = self.new(:datetime => row[0],
               :username => row[1],
               :category_id => category_id,
               :topic_title => row[3],
               :topic_id => row[4],
               :raw => row[5])
      generated_queued_post.save!
    end

  end
end
