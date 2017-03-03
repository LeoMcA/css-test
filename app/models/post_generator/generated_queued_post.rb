module PostGenerator
  class GeneratedQueuedPost < ActiveRecord::Base
    belongs_to :category
    belongs_to :user

    attr_accessor :username

    default_scope { order datetime: :asc }

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
      row[3] = nil if row[3].blank?
      category = Category.find_by_slug(row[2], row[3])
      category_id = category.nil? ? nil : category.id
      generated_queued_post = self.new(:datetime => row[0],
               :username => row[1],
               :category_id => category_id,
               :topic_title => row[4],
               :topic_id => row[5],
               :raw => row[6])
      generated_queued_post.save!
    end

  end
end
