PRDashboard.Pull = DS.Model.extend
  title:         DS.attr('string')
  url:           DS.attr('string')
  createdAt:     DS.attr('date')
  commentsCount: DS.attr('number')

