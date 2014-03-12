PRDashboard.Pull = DS.Model.extend
  title:         DS.attr('string')
  url:           DS.attr('string')
  created_at:     DS.attr('date')
  comments_count: DS.attr('number')
  user:          DS.belongsTo('user', { async: true })
  repository:    DS.belongsTo('repository', { async: true })

