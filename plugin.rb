# name: post-generator
# about: Discourse plugin which generates posts
# version: 0.0.1
# authors: Leo McArdle

load File.expand_path('../lib/post_generator.rb', __FILE__)
load File.expand_path('../lib/post_generator/engine.rb', __FILE__)

after_initialize do
  require_dependency File.expand_path("../jobs/scheduled/post_generator_poll.rb", __FILE__)
end

register_asset 'stylesheets/post_generator.scss'

add_admin_route 'post_generator.title', 'post-generator'

Discourse::Application.routes.append do
  mount PostGenerator::Engine => '/admin/plugins/post-generator', constraints: AdminConstraint.new
end
