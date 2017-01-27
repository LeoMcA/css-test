module Jobs
  class PostGeneratorPoll < Jobs::Scheduled

    sidekiq_options retry: false

    every 1.minute

    def execute(args)
      queued_posts = PostGenerator::GeneratedQueuedPost.where('datetime <= ?', Time.now)
      queued_posts.each do |post|
        begin
          unless post.topic_title.nil? || post.topic_title.empty?
            category_id = post.category.nil? ? -1 : post.category.id
            creator = PostCreator.new(post.user,
                                      title: post.topic_title,
                                      raw: post.raw,
                                      skip_validations: true,
                                      bypass_rate_limiter: true,
                                      category: category_id,
                                      custom_fields: { :post_generator_id => post.topic_id },
                                      created_at: post.datetime)
            creator.create!
            post.delete
          else
            custom_field = PostCustomField.find_by(name: 'post_generator_id', value: post.topic_id)
            unless custom_field.nil? || custom_field.post.nil? || custom_field.post.topic.nil?
              creator = PostCreator.new(post.user,
                                        topic_id: custom_field.post.topic.id,
                                        raw: post.raw,
                                        skip_validations: true,
                                        bypass_rate_limiter: true,
                                        created_at: post.datetime)
              creator.create!
              post.delete
            else
              topic = Topic.find_by(id: post.topic_id.to_i)
              unless topic.nil?
                creator = PostCreator.new(post.user,
                                          topic_id: topic.id,
                                          raw: post.raw,
                                          skip_validations: true,
                                          bypass_rate_limiter: true,
                                          created_at: post.datetime)
                creator.create!
                post.delete
              else
                Rails.logger.error "Error generating post from queue: couldn't find topic to reply to"
              end
            end
          end
        rescue Exception => e
          Rails.logger.error "Error generating post from queue: #{e.message}"
        end
      end
    end
  end
end
