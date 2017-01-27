import Post from '../../discourse/models/post'

export default Ember.Controller.extend({
  status: '',

  actions: {
    new () {
      this.transitionToRoute('adminPlugins.post-generator.new')
    },

    refresh () {
      this.set('status', 'Refreshing...')
      Post.findAll().then(result => {
        this.set('model', result)
        this.set('status', '')
      })
    }
  }
})
