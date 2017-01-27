export default {
  resource: 'admin.adminPlugins',
  path: '/plugins',
  map () {
    this.route('post-generator', function () {
      this.route('new')
      this.route('edit', { path: '/:id' })
    })
  }
}
