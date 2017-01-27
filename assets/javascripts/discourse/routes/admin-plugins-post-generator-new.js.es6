export default Discourse.Route.extend({
  model () {
    return {
      category: {},
      user: {}
    }
  },
  renderTemplate () {
    this.render('admin-plugins-post-generator-edit', {
      controller: 'admin-plugins-post-generator-new'
    })
  },
  setupController (controller, model) {
    this.controllerFor('admin-plugins-post-generator-new').set('model', model)
  }
})
