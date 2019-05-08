include: "_user.view.lkml"

view: user {
  extends: [_user]
  derived_table: {
    sql: SELECT * FROM zendesk.user ;;
  }

  #TODO: Define what it means for a user to be support agent
  dimension: is_agent {
    type: yesno
    sql: ${organization_id} = 27173710 ;;
    # sql: ${id} IN (418155650,794385300,1134334407,1178141988,3205490828,3248387357,3546805988,5645036168, 7566147747, 9899556348, 12851260247, 13896009768,17068001387,17344482987)   ;;
    # sql: ${role} IN ('Agent','Admin')  ;;
  }
}





# Potenially more robust solution
#
# explore: _user {
#   join: user_list {
#     sql: JOIN _user ON ${_user.id} IN ${user_list.assignee_list}
#       ;;
#   }
# }
#
# view: user_list {
#   derived_table: {
#     explore_source: ticket {
#       column: assignee_list {field: assignee.id}
#     }
#   }
#   dimension: assignee_list {}
#   dimension: is_agent {sql:'Yes';;}
# }
