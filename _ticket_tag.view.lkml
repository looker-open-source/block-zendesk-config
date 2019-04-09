view: ticket_tag {
  sql_table_name: zendesk.ticket_tag ;;

  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: concat (${tag} , ${ticket_id}) ;;
  }

  dimension: tag {
    type: string
    sql: ${TABLE}.tag ;;
  }

  dimension: ticket_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.ticket_id ;;
  }

  measure: count {
    type: count
    drill_fields: [ticket.id]
  }
}
