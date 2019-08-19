

view: user_config {
  extends: [user_core]
  extension: required

  #TODO: Define what it means for a user to be support agent
  dimension: is_agent {
    type: yesno
    sql: ${organization_id} = 27173710 ;;
  }
}