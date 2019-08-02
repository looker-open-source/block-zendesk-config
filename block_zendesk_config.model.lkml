datagroup: block_zendesk_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "2 hour"
}

persist_with: block_zendesk_datagroup

# Used exclusively to calculate user response times
explore: agent_config {
  extends: [agent_core]
  extension: required
}

explore: ticket_config {
  extends: [ticket_core]
  extension: required
}
