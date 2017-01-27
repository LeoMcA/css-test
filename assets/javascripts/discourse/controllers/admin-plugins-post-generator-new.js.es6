import Post from '../../discourse/models/post'

export default Ember.Controller.extend({
  status: '',

  actions: {
    save () {
      this.set('status', 'Saving...')
      var post = Post.create(this.get('model'))
      post.create().then(() => {
        this.set('status', '')
        this.transitionToRoute('adminPlugins.post-generator')
      })
    },

    destroy () {
      this.transitionToRoute('adminPlugins.post-generator')
    }
  }
})
