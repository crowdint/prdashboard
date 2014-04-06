PRDashboard.Pull = DS.Model.extend
  title:          DS.attr('string')
  url:            DS.attr('string')
  created_at:     DS.attr('date')
  comments_count: DS.attr('number')
  number:         DS.attr('string')
  is_private:     DS.attr('boolean')
  mergeable:      DS.attr('boolean')
  user:           DS.belongsTo('user', { async: true })
  repository:     DS.belongsTo('repository', { async: true })
  comments:       DS.hasMany('comment')

  files_url: (->
    @get('url') + '/files'
  ).property('url')

