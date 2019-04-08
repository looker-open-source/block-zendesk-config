include: "_ticket_history.view.lkml"


view: ticket_history {
  extends: [_ticket_history]
  ## The SQL in this dimensions should be updated to reflect whatever your business
  ## considers and "agent touch"
  dimension: number_of_agent_touches {
    type: number
    hidden: yes
    sql: CASE
      WHEN ${new_value} IN ('true','false','incident') THEN 1
      ELSE 0
      END

       ;;
  }

  measure: total_agent_touches {
    type: sum
    sql: ${number_of_agent_touches} ;;
  }

  measure: count_unique_tickets {
    type: count_distinct
    sql: ${ticket_id} ;;
  }

  measure: average_agents_touches {
    type: average
    sql: ${number_of_agent_touches} ;;
  }
}
