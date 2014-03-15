PRDashboard.Comment = DS.Model.extend
  body:     DS.attr('string')
  username: DS.attr('string')
  avatar:   DS.attr('string')

  user_url: (->
    "https://github.com/#{@get('username')}"
  ).property('username')
