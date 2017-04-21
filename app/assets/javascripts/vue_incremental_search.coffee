class IncrementalSearch
  props: ['text']
  computed:
    visible: -> @$root.query is "" or !!~ @text.indexOf(@$root.query)
  template: '''
    <div v-show="visible">
      <slot></slot>
    </div>

  '''
Vue.component "incrementalsearch", new IncrementalSearch

