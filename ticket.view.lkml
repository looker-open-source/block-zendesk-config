include: "_ticket.view"

view: ticket {
  extends: [_ticket]


#### Status Flags ####

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

    filters: {
      field: is_new
      value: "Yes"
    }
  }

  measure: count_open_tickets {
    type: count

    filters: {
      field: is_open
      value: "Yes"
    }
  }

  measure: count_solved_tickets {
    type: count

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

  dimension: created_day_of_week {
    case: {
      when: {
        sql: ${hidden_created_day_of_week_index} = 6 ;;
        label: "Sunday"
      }

      when: {
        sql: ${hidden_created_day_of_week_index} = 0 ;;
        label: "Monday"
      }

      when: {
        sql: ${hidden_created_day_of_week_index} = 1 ;;
        label: "Tuesday"
      }

      when: {
        sql: ${hidden_created_day_of_week_index} = 2 ;;
        label: "Wednesday"
      }

      when: {
        sql: ${hidden_created_day_of_week_index} = 3 ;;
        label: "Thursday"
      }

      when: {
        sql: ${hidden_created_day_of_week_index} = 4 ;;
        label: "Friday"
      }

      when: {
        sql: ${hidden_created_day_of_week_index} = 5 ;;
        label: "Saturday"
      }
    }
  }


}
