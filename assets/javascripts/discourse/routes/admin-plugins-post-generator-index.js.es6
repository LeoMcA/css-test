import Post from '../../discourse/models/post'

export default Discourse.Route.extend({
  model () {
    return Post.findAll().then(result => {
      return result
    })
  }
})
