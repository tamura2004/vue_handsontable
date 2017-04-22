class MaHeader
  props: ['project']
  template: '''
    <div class="page-header">
      <h3>
        <small>{{project.number}}</small>
        {{project.name}}
      </h3>
    </div>
  '''

class MaDetail
  props: ['member','handle']
  template: '''
    <div class="checkbox">
      <label>
        <input
          type="checkbox"
          @change="handle(member)"
          v-model="member.checked"
        />
        {{member.job_title_name}}
        {{member.number}}
        {{member.name}}
      </label>
    </div>
  '''

class MaBody
  props: ['members','handle']
  components:
    maDetail: new MaDetail
  template: '''
    <div class="row">
      <div class="col-xs-3" v-for="col in 4">
        <ma-detail
          v-for="member in members | limitBy colLength (col*colLength) | filterBy $root.query"
          :member="member"
          :handle="handle"
        >
        </ma-detail>
      </div>
    </div>
  '''
  computed:
    colLength: -> Math.ceil @members.length / 4

class MemberAssign
  props: ['project','members','assigns']
  components:
    maHeader: new MaHeader
    maBody: new MaBody
  template: '''
    <div>
      <ma-header :project="project"></ma-header>
      <ma-body :members="members" :handle="handle"></ma-body>
    </div>
  '''
  created: ->
    @resource = new Resource "assigns"
    for member in @members
      member.checked = @assigns.some((a) -> a.member_id is member.id)

  methods:
    handle: (member) ->
      if member.checked
        assignment = {project_id: @project.id, member_id: member.id}
        @resource.save assignment, (response) => @assigns.push response.data

      else
        assignment = _.find @assigns, (e) -> e.member_id is member.id
        @resource.delete(assignment.id)

Vue.component "ma", new MemberAssign
