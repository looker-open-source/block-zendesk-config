connection: "@{CONNECTION_NAME}"

# include all the views
include: "*.view"

include: "//block-zendesk/*.view"
include: "//block-zendesk/*.dashboard"
include: "//block-zendesk/*.explore"

datagroup: block_zendesk_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "2 hour"
}

persist_with: block_zendesk_datagroup

# Used exclusively to calculate user response times
explore: agent {
  extends: [agent_core]
}

explore: ticket {
  extends: [ticket_core]
}
