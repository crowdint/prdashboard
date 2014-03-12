PRDashboard.Pull = DS.Model.extend
  title:         DS.attr('string')
  url:           DS.attr('string')
  createdAt:     DS.attr('date')
  commentsCount: DS.attr('number')
  user:          DS.belongsTo('user', { async: true })
  repository:    DS.belongsTo('repository', { async: true })

