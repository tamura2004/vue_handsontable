class GroupTab
  props: ['groups','current','path']
  template: '''
    <ul class="nav nav-tabs">
      <li
        v-for="group in groups"
        :class="{'active':group.id == current.id}"
      >
        <a
          href="/groups/{{group.id}}/{{path}}"
        >
          {{group.name}}
        </a>
      </li>
    </ul>

  '''

Vue.component "grouptab", new GroupTab

