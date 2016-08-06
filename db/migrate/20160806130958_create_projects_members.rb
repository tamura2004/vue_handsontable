class CreateProjectsMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :projects_members do |t|
      t.references :project, foreign_key: true
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
