module PostGenerator
  class GeneratedQueuedPostsController < Admin::AdminController
    requires_plugin 'post-generator'

    def index
      generated_queued_posts = GeneratedQueuedPost.all
      render json: generated_queued_posts.to_json(:include => [:category, :user])
    end

    def new
    end

    def create
      generated_queued_post = GeneratedQueuedPost.new(generated_queued_post_params)
      generated_queued_post.save!
      render nothing: true, status: 204
    end

    def show
      generated_queued_post = GeneratedQueuedPost.find(params[:id])
      render json: generated_queued_post.to_json(:include => [:category, :user])
    end

    def update
      generated_queued_post = GeneratedQueuedPost.find(params[:id])
      generated_queued_post.update_attributes!(generated_queued_post_params)
      render nothing: true, status: 204
    end

    def destroy
      generated_queued_post = GeneratedQueuedPost.find(params[:id])
      generated_queued_post.delete
      render nothing: true, status: 204
    end

    def upload
      file = params[:file] || params[:files].first
      CSV.foreach(file.tempfile) do |row|
        unless row[0] == 'datetime'
          GeneratedQueuedPost.new_from_csv(row)
        end
      end
      render json: success_json
    end

    private

    def generated_queued_post_params
      params[:datetime] = DateTime.parse(params[:datetime]).iso8601
      if params[:topic_title].blank?
        params[:category_id] = nil
      elsif params[:category_id].to_i == 0
        params[:category_id] = 1
      end
      params.permit(:datetime,
                    :username,
                    :category_id,
                    :topic_title,
                    :topic_id,
                    :raw)
    end
  end
end
