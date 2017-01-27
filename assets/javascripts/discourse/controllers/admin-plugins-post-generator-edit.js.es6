export default Ember.Controller.extend({
  status: '',

  actions: {
    save () {
      this.set('status', 'Saving...')
      this.get('model').update().then(() => {
        this.set('status', '')
        this.transitionToRoute('adminPlugins.post-generator')
      })
    },

    destroy () {
      this.set('status', 'Deleting...')
      this.get('model').destroy().then(() => {
        this.set('status', '')
        this.transitionToRoute('adminPlugins.post-generator')
      })
    }
  }
})
