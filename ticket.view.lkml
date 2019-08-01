include: "//block-zendesk/ticket_core.view"

view: ticket {
  extends: [ticket_core]

  # Customize: Configure your ticket priority settings
  dimension: priority {
    type: string
    sql: case when LOWER(${priority_raw}) = 'low' then '2 - Low'
          when LOWER(${priority_raw}) = 'normal' then '3 - Normal'
          when LOWER(${priority_raw}) = 'high' then '4 - High'
          when LOWER(${priority_raw}) = 'urgent' then '5 - Urgent'
          when LOWER(${priority_raw}) is null then '1 - Not Assigned' end ;;
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

  # Customize: Define what makes a ticket solved
  dimension: is_solved {
    type: yesno
    sql: ${status} = 'solved' OR ${status} = 'closed' ;;
  }

  # Customize: Define your subject category buckets
  dimension: subject_category {
    sql: CASE
        WHEN ${subject} LIKE 'Chat%' THEN 'Chat'
        WHEN ${subject} LIKE 'Offline message%' THEN 'Offline Message'
        WHEN ${subject} LIKE 'Phone%' THEN 'Phone Call'
        ELSE 'Other'
        END
         ;;
  }
}
