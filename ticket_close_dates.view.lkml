# Calculates the "Closed Date" for each ticket (i.e. date diff between when status was last changed to "closed" and ticket created date)
view: ticket_close_dates {
  derived_table: {
    explore_source: ticket {
      filters: {field: ticket_field_history.field_name value: "status"}
      filters: {field: ticket_field_history.value value: "closed"}
      column: ticket_id {field: ticket.id}
      column: created_time {field: ticket.created_raw}
      column: close_time {field: ticket_field_history.max_updated_time}
      derived_column: time_to_resolution {sql: TIMESTAMP_DIFF(close_time, created_time, HOUR) ;;}
    }
  }

  dimension: ticket_id {
    type: number
    sql: ${TABLE}.ticket_id ;;
    primary_key: yes
  }

  dimension_group: created_time {
    type: time
  }

  dimension_group: close_time {
    type: time
  }

  # In Hours
  dimension: time_to_resolution {
    hidden: yes
    type: number
  }

  dimension: time_to_resolution_formatted {
    label: "Time To Resolution"
    type: string
    sql:  CONCAT(
          CONCAT(CAST(FLOOR(${time_to_resolution}/7/24) AS STRING), " Weeks "),
          CONCAT(CAST(FLOOR(MOD(${time_to_resolution},7*24)/24) AS STRING), " Days "),
          CONCAT(CAST(MOD(MOD(${time_to_resolution},7*24),24) AS STRING), " Hours"));;
  }

  measure: average_time_to_resolution {
    type: average
    description: "In Hours"
    sql: ${time_to_resolution} ;;
    value_format_name: decimal_0
  }
}
