connection: "fivetran_looker_blocks_demo"

# include all the views
include: "*.view"
# include: "*.dashboard"

datagroup: app_support_analytics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: app_support_analytics_default_datagroup

explore: flat_ticket {}

view: flat_ticket {
  derived_table: {
    explore_source: ticket {
      column: assignee {field: assignee.name }
      column: organization {field: organization.name }
      column: type {field: ticket.type }
      column: status {field: ticket.status }
      column: priority {field: ticket.priority }
      column: tickets {field: ticket.count}
    }
  }

  dimension: assignee {
    type: string
  }

  dimension: organization {
    type: string
  }

  dimension: type {
    type: string
  }

  dimension: status {
    type: string
  }

  dimension: priority {
    type: string
  }

  dimension: tickets {
    type: number
  }
}

explore: ticket {

  sql_always_where: ${is_deleted} IS FALSE;;

  join: ticket_comment {
    type: left_outer
    sql_on: ${ticket.id} = ${ticket_comment.ticket_id} ;;
    relationship: one_to_many
  }
  join: ticket_field_history {
    type: left_outer
    sql_on: ${ticket.id} = ${ticket_field_history.ticket_id} ;;
    relationship: one_to_many
  }
  join: ticket_tag {
    type: left_outer
    sql_on: ${ticket.id} = ${ticket_tag.ticket_id} ;;
    relationship: many_to_many
  }
  join: ticket_tag_history {
    type: left_outer
    sql_on: ${ticket.id} = ${ticket_tag.ticket_id} ;;
    relationship: many_to_many
  }

  join: ticket_close_dates {
    type: left_outer
    sql_on: ${ticket.id} = ${ticket_close_dates.ticket_id} ;;
    relationship: one_to_one
  }

  join: assignee {
    from: user
    relationship: many_to_one
    sql_on: ${ticket.assignee_id} = ${assignee.id} ;;
  }
  join: requester {
    from: user
    relationship: many_to_one
    sql_on: ${ticket.requester_id} = ${requester.id} ;;
  }

  join: organization {
    type: left_outer
    sql_on: ${ticket.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }
  join: organization_member {
    type: left_outer
    sql_on: ${organization.id} = ${organization_member.organization_id} ;;
    relationship: one_to_many
  }
  join: organization_tag {
    type: left_outer
    sql_on: ${organization.id} = ${organization_tag.organization_id} ;;
    relationship: one_to_many
  }


  join: forum_topic {
    type: left_outer
    sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
    relationship: many_to_one
  }

  join: brand {
    type: left_outer
    sql_on: ${ticket.brand_id} = ${brand.id} ;;
    relationship: many_to_one
  }

  join: group {
    type: left_outer
    sql_on: ${ticket.group_id} = ${group.id} ;;
    relationship: many_to_one
  }


}
########################################################################################################################
########################################################################################################################

#
# explore: brand {}
#
# explore: fivetran_audit {}
#
# explore: forum_topic {}
#
# explore: group {}
#
# explore: group_member {
#   join: group {
#     type: left_outer
#     sql_on: ${group_member.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
#
#   join: user {
#     type: left_outer
#     sql_on: ${group_member.user_id} = ${user.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${user.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: organization {
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: organization_member {
#   join: user {
#     type: left_outer
#     sql_on: ${organization_member.user_id} = ${user.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${organization_member.organization_id} = ${organization.id} ;;

#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: organization_tag {
#   join: organization {
#     type: left_outer
#     sql_on: ${organization_tag.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
# }

#
# explore: ticket_comment {
#   join: user {
#     type: left_outer
#     sql_on: ${ticket_comment.user_id} = ${user.id} ;;
#     relationship: many_to_one
#   }
#
#   join: ticket {
#     type: left_outer
#     sql_on: ${ticket_comment.ticket_id} = ${ticket.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${user.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
#
#   join: forum_topic {
#     type: left_outer
#     sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
#     relationship: many_to_one
#   }
#
#   join: brand {
#     type: left_outer
#     sql_on: ${ticket.brand_id} = ${brand.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: ticket_field_history {
#   join: user {
#     type: left_outer
#     sql_on: ${ticket_field_history.user_id} = ${user.id} ;;
#     relationship: many_to_one
#   }
#
#   join: ticket {
#     type: left_outer
#     sql_on: ${ticket_field_history.ticket_id} = ${ticket.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${user.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
#
#   join: forum_topic {
#     type: left_outer
#     sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
#     relationship: many_to_one
#   }
#
#   join: brand {
#     type: left_outer
#     sql_on: ${ticket.brand_id} = ${brand.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: ticket_field_option {}
#
# explore: ticket_tag {
#   join: ticket {
#     type: left_outer
#     sql_on: ${ticket_tag.ticket_id} = ${ticket.id} ;;
#     relationship: many_to_one
#   }
#
#   join: forum_topic {
#     type: left_outer
#     sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
#     relationship: many_to_one
#   }
#
#   join: brand {
#     type: left_outer
#     sql_on: ${ticket.brand_id} = ${brand.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${ticket.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${ticket.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: ticket_tag_history {
#   join: user {
#     type: left_outer
#     sql_on: ${ticket_tag_history.user_id} = ${user.id} ;;
#     relationship: many_to_one
#   }
#
#   join: ticket {
#     type: left_outer
#     sql_on: ${ticket_tag_history.ticket_id} = ${ticket.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${user.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
#
#   join: forum_topic {
#     type: left_outer
#     sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
#     relationship: many_to_one
#   }
#
#   join: brand {
#     type: left_outer
#     sql_on: ${ticket.brand_id} = ${brand.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: user {
#   join: organization {
#     type: left_outer
#     sql_on: ${user.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
# }
