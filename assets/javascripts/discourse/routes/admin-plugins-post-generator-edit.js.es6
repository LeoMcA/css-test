import Post from '../../discourse/models/post'

export default Discourse.Route.extend({
  model (params) {
    return Post.find(params.id).then(result => {
      return result
    })
  }
})
