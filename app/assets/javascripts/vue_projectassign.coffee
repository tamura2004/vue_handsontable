class PaHeader
  props: ['member']
  template: '''
    <div class="page-header">
      <h3>
        {{member.number}}
        {{member.name}}
        {{member.job_title_name}}
        <small>{{member.group_name}}</small>
      </h3>
    </div>
  '''

class PaDetail
  props: ['project','handle']
  template: '''
    <div class="checkbox">
      <label>
        <input
          type="checkbox"
          @change="handle(project)"
          v-model="project.checked"
        />
        {{project.number}} {{project.name}}
      </label>
    </div>
  '''

class PaBody
  props: ['projects','handle']
  components:
    paDetail: new PaDetail
  template: '''
    <div class="row">
      <div class="col-xs-6" v-for="col in 2">
        <pa-detail
          v-for="project in projects | limitBy colLength (col*colLength) | filterBy $root.query"
          :project="project"
          :handle="handle"
        >
        </pa-detail>
      </div>
    </div>
  '''
  computed:
    colLength: -> Math.ceil @projects.length / 2

class ProjectAssign
  props: ['member','projects','assigns']
  components:
    "pa-header": new PaHeader
    paBody: new PaBody
  template: '''
    <div>
      <pa-header :member="member"></pa-header>
      <pa-body :projects="projects" :handle="handle"></pa-body>
    </div>
  '''
  created: ->
    @resource = new Resource "assigns"
    for project in @projects
      project.checked = @assigns.some((a) -> a.project_id is project.id)

  methods:
    handle: (project) ->
      if project.checked
        assignment = {member_id: @member.id, project_id: project.id}
        @resource.save assignment, (response) => @assigns.push response.data

      else
        assignment = _.find @assigns, (e)-> e.project_id is project.id
        @resource.delete(assignment.id)

Vue.component "projectassign", new ProjectAssign
