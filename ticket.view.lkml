include: "_ticket.view"

view: ticket {
  extends: [_ticket]

  dimension: dash_title {
    type: string
    sql: 'foo' ;;
    html: <font color="#5A2FC2" size="8"><center>Agent Overview Dashboard</center></font> ;;
  }

  dimension: priority {
    type: string
    sql: case when LOWER(${TABLE}.priority) = 'low' then '2 - Low'
          when LOWER(${TABLE}.priority) = 'normal' then '3 - Normal'
          when LOWER(${TABLE}.priority) = 'high' then '4 - High'
          when LOWER(${TABLE}.priority) = 'urgent' then '5 - Urgent'
          when LOWER(${TABLE}.priority) is null then '1 - Not Assigned' end ;;
    description: "The urgency with which the ticket should be addressed. Possible values: urgent, high, normal, low"
    html: {% if value == '1 - Not Assigned' %}
            <div style="color: black; background-color: grey; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '2 - Low' %}
            <div style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '3 - Normal' %}
            <div style="color: black; background-color: yellow; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '4 - High' %}
            <div style="color: white; background-color: darkred; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '5 - Urgent' %}
            <div style="color: white; background-color: black; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% else %}
            <div style="color: black; background-color: blue; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% endif %}
    ;;
  }

  dimension: priority_raw {
    type: string
    sql: ${TABLE}.priority ;;
  }

  dimension: priority_rank {
    type: string
    sql: case when ${priority_raw} = 'low' THEN 1
              when ${priority_raw} = 'normal' THEN 2
              when ${priority_raw} = 'high' THEN 3
              when ${priority_raw} = 'urgent' THEN 4
              else null end;;
  }

  measure: prio_rank {
    type: max
    sql: ${priority_rank} ;;
  }

  dimension: ticket_link {
    type: number
    sql: ${TABLE}.id ;;
    html: <img src="http://www.google.com/s2/favicons?domain=www.zendesk.com" height=16 width=16> {{ value }} ;;
    link: {
      label: "Zendesk Ticket"
      url: "https://{{ ticket._ZENDESK_INSTANCE_DOMAIN._value }}.zendesk.com/agent/tickets/{{ value }}"
      icon_url: "https://d1eipm3vz40hy0.cloudfront.net/images/logos/zendesk-favicon.ico"
    }
    # link: {
    #   label: "Zendesk Ticket Detail"
    #   url: "https://{{ ticket._LOOKER_INSTANCE_DOMAIN._value }}.looker.com/dashboards/{{ ticket._ZENDESK_TICKET_DETAIL_DASHBOARD_ID._value }}?Ticket={{ value }}"
    #   icon_url: "http://www.looker.com/favicon.ico"
    # }
  }

  dimension: _ZENDESK_INSTANCE_DOMAIN {
    sql:  'looker' ;;
  }

  dimension_group: open {
    description: "Ticket Age"
    type: duration
    sql_end: CURRENT_TIMESTAMP ;;
    sql_start: ${created_raw} ;;
  }

  dimension: ticket_age_days_tier {
    description: "Tiered ticket age in days"
    type: tier
    tiers: [0, 30, 60, 90]
    style: integer
    sql: ${days_open} ;;
  }


  dimension: days_to_solve {
    type: number
    sql: 1.00 * DATE_DIFF(${ticket_history_fact.solved_date}, ${created_date}, DAY) ;;
  }

  dimension: days_to_first_response {
    type: number
    sql: 1.00 * DATE_DIFF(${ticket_history_fact.first_response_date}, ${created_date}, DAY) ;;
  }

  dimension: minutes_to_first_response {
    type: number
    sql: 1.00 * DATETIME_DIFF(EXTRACT(DATETIME FROM ${ticket_history_fact.first_response_raw}), EXTRACT(DATETIME FROM ${created_raw}), MINUTE) ;;
  }

  dimension: hours_to_first_response {
    type: number
    sql: 1.00 * DATETIME_DIFF(EXTRACT(DATETIME FROM ${ticket_history_fact.first_response_raw}), EXTRACT(DATETIME FROM ${created_raw}), HOUR) ;;
  }

  dimension: hours_to_solve {
    type: number
    sql: 1.00 * DATETIME_DIFF(${ticket_history_fact.solved_raw}, ${created_raw}, HOUR) ;;
  }

  dimension: is_responded_to {
    type: yesno
    sql: ${minutes_to_first_response} is not null ;;
  }

  dimension_group: last_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: days_since_updated {
    type: number
    sql: 1.00 * DATE_DIFF(CURRENT_DATE(), ${last_updated_date}, DAY)  ;;
    html: {% if value > 60 %}
            <div style="color: white; background-color: darkred; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% else %}
            <div style="color: black; background-color: yellow; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% endif %}
      ;;
  }

  measure: avg_days_to_solve {
    type: average
    sql: ${days_to_solve} ;;
    value_format_name: decimal_2
  }

  parameter: name_select {
    type: string
  }

  measure: my_avg_days_to_solve {
    type: average
    sql: CASE WHEN ${assignee.name} = {% parameter name_select %} THEN ${days_to_solve}
      ELSE NULL END ;;
    value_format_name: decimal_2
  }

  measure: avg_hours_to_first_response {
    type: average
    sql: ${hours_to_first_response} ;;
    value_format_name: decimal_2
  }

#### Status Flags ####

#   # TODO: Define the threshold for meeting SLAs in hours
#
#   dimension: urgent_sla {sql: 6 ;;}
#   dimension: high_sla {sql: 24 ;;}
#   dimension: normal_sla {sql: 36 ;; }
#   dimension: low_sla {sql: 48 ;;}
#
#
# # will use ${hours_to_first_response} when elliot is done with pdt
#   dimension: is_meeting_sla {
#     type: yesno
#     sql: CASE WHEN ${priority} = 'Urgent' and ${hours_to_first_response} > ${urgent_sla}  THEN FALSE
#               WHEN ${priority} = 'High' and ${hours_to_first_response} > ${high_sla}  THEN FALSE
#               WHEN ${priority} = 'Normal' and ${hours_to_first_response} > ${normal_sla}  THEN FALSE
#               WHEN ${priority} = 'Low' and ${hours_to_first_response} > ${low_sla}  THEN FALSE
#               ELSE NULL
#               END
#             ;;
#   }

#   # TODO: Define if a ticket has been escalated
#   dimension: is_escalated {
#     type: yesno
#     sql:  ;;
# }

dimension: is_hold {
  type: yesno
  sql: ${status} = 'hold'   ;;
}

dimension: is_pending {
  type: yesno
  sql: ${status} = 'pending' ;;
}

dimension: is_new {
  type: yesno
  sql: ${status} = 'new' ;;
}

dimension: is_open {
  type: yesno
  sql: ${status} = 'open' ;;
}

dimension: is_deleted {
  type: yesno
  sql: ${status} = 'deleted' ;;
}

### THIS ASSUMES NO DISTINCTION BETWEEN SOLVED AND CLOSED
dimension: is_solved {
  type: yesno
  sql: ${status} = 'solved' OR ${status} = 'closed' ;;
}

dimension: subject_category {
  sql: CASE
      WHEN ${subject} LIKE 'Chat%' THEN 'Chat'
      WHEN ${subject} LIKE 'Offline message%' THEN 'Offline Message'
      WHEN ${subject} LIKE 'Phone%' THEN 'Phone Call'
      ELSE 'Other'
      END
       ;;
}

measure: count {
  label: "Count Tickets"
  type: count
}

measure: count_pending_tickets {
  type: count
  label: "Pending"
  filters: {
    field: is_pending
    value: "Yes"
  }
}

measure: count_new_tickets {
  type: count

  filters: {
    field: is_new
    value: "Yes"
  }
}

measure: count_tickets_on_hold {
  type: count
  label: "Hold"
  filters: {
    field: is_new
    value: "Yes"
  }
}

measure: count_open_tickets {
  type: count
  label: "Open"
  filters: {
    field: is_open
    value: "Yes"
  }
}

measure: count_solved_tickets {
  type: count
  label: "Solved"
  filters: {
    field: is_solved
    value: "Yes"
  }
}


############ TIME FIELDS ###########

dimension_group: hidden_created {
  hidden: yes
  type: time
  ###   use day_of_week
  timeframes: [day_of_week_index]
  sql: ${TABLE}.created_at ;;
}

#   dimension: created_day_of_week {
#     case: {
#       when: {
#         sql: ${hidden_created_day_of_week_index} = 6 ;;
#         label: "Sunday"
#       }
#
#       when: {
#         sql: ${hidden_created_day_of_week_index} = 0 ;;
#         label: "Monday"
#       }
#
#       when: {
#         sql: ${hidden_created_day_of_week_index} = 1 ;;
#         label: "Tuesday"
#       }
#
#       when: {
#         sql: ${hidden_created_day_of_week_index} = 2 ;;
#         label: "Wednesday"
#       }
#
#       when: {
#         sql: ${hidden_created_day_of_week_index} = 3 ;;
#         label: "Thursday"
#       }
#
#       when: {
#         sql: ${hidden_created_day_of_week_index} = 4 ;;
#         label: "Friday"
#       }
#
#       when: {
#         sql: ${hidden_created_day_of_week_index} = 5 ;;
#         label: "Saturday"
#       }
#     }
#   }


}
