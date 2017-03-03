import { ajax } from 'discourse/lib/ajax'

const Post = Ember.Object.extend({
  asJSON () {
    return {
      datetime: this.get('datetime'),
      username: this.get('user.username'),
      category_id: this.get('category_id'),
      topic_title: this.get('topic_title'),
      topic_id: this.get('topic_id'),
      raw: this.get('raw')
    }
  },

  create () {
    return ajax('/admin/plugins/post-generator', { type: 'POST', data: this.asJSON() })
  },

  update () {
    var id = this.get('id')
    return ajax(`/admin/plugins/post-generator/${id}`, { type: 'PATCH', data: this.asJSON() })
  },

  destroy () {
    var id = this.get('id')
    return ajax(`/admin/plugins/post-generator/${id}`, { type: 'DELETE' })
  }
})

Post.reopenClass({
  find (id) {
    return ajax(`/admin/plugins/post-generator/${id}`).then(result => {
      return Post.create(result)
    })
  },

  findAll () {
    return ajax('/admin/plugins/post-generator').then(result => {
      return result.map(post => Post.create(post))
    })
  }
})

export default Post
