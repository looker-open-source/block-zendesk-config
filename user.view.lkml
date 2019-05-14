include: "//block-zendesk/user_core.view.lkml"

view: user {
  extends: [user_core]

  #TODO: Define what it means for a user to be support agent
  dimension: is_agent {
    type: yesno
    sql: ${organization_id} = 27173710 ;;
  }
}
