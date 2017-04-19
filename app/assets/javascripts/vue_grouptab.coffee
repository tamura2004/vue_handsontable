class GroupTab
  props: ['groups','current','path']
  methods:
    url: (group) -> "/groups/#{group.id}/#{@path}"
  template: '''
    <ul class="nav nav-tabs">
      <li
        v-for="group in groups"
        :class="{'active':group.id == current.id}"
      >
        <a
          :href="url(group)"
        >
          {{group.name}}
        </a>
      </li>
    </ul>

  '''

Vue.component "grouptab", new GroupTab

