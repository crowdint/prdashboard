Em.Handlebars.registerBoundHelper 'friendlyDate', (date) ->
  if date
    moment(date).format('MMMM Do YYYY, h:mm:ss a')
  else
    '';
