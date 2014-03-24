Em.UnboundOption = Em.SelectOption.extend
  template: Em.Handlebars.compile('{{unbound view.label}}')

Em.UnboundSelect = Em.Select.extend
  template: Em.Handlebars.compile('{{each view.content itemViewClass="Em.UnboundOption"}}')

