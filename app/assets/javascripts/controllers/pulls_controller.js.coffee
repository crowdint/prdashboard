PRDashboard.PullsController = Em.ArrayController.extend(
  PRDashboard.Filters,
  PRDashboard.UI,
  PRDashboard.Reviews,
  PRDashboard.Interactions,

  sortProperties: ['created_at']
  isLoading: false

  privateCount: (->
    @get('all').filterBy('is_private').length
  ).property('all.@each')

  publicCount: (->
    @get('all').filterBy('is_private', false).length
  ).property('all.@each')

  allCount: (->
    @get('all.length')
  ).property('all.@each')
)

