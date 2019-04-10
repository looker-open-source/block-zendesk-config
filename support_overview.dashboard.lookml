- dashboard: support_overview
  title: Overview
  layout: newspaper
  elements:
  - title: Open Tickets
    name: Open Tickets
    model: zendesk_analytics
    explore: ticket
    type: single_value
    fields: [ticket.count_open_tickets]
    limit: 500
    query_timezone: America/Los_Angeles
    row: 0
    col: 6
    width: 6
    height: 4
  - title: Solved Tickets
    name: Solved Tickets
    model: zendesk_analytics
    explore: ticket
    type: single_value
    fields: [ticket.count_solved_tickets]
    limit: 500
    query_timezone: America/Los_Angeles
    row: 0
    col: 0
    width: 6
    height: 4
  - title: Median Response Time
    name: Median Response Time
    model: zendesk_analytics
    explore: agent
    type: single_value
    fields: [ticket_comment_response_times.median_response_time]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: 'concat(to_string(round(${ticket_comment_response_times.median_response_time},2)),"
          Hours")', value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: string}]
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    hidden_fields: [ticket_comment_response_times.median_response_time]
    listen: {}
    row: 0
    col: 12
    width: 6
    height: 4
  - title: Median Time to Resolution
    name: Median Time to Resolution
    model: zendesk_analytics
    explore: ticket
    type: single_value
    fields: [ticket_close_dates.median_time_to_resolution]
    limit: 500
    dynamic_fields: [{table_calculation: present, label: Present, expression: 'concat(to_string(${ticket_close_dates.median_time_to_resolution}),
          " Hours")', value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    hidden_fields: [ticket_close_dates.median_time_to_resolution]
    row: 0
    col: 18
    width: 6
    height: 4
  - title: "% of Tickets Created by Hour"
    name: "% of Tickets Created by Hour"
    model: zendesk_analytics
    explore: ticket
    type: looker_column
    fields: [ticket.created_hour_of_day, ticket.count]
    fill_fields: [ticket.created_hour_of_day]
    sorts: [ticket.created_hour_of_day]
    limit: 500
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: "${ticket.count}/sum(${ticket.count})",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: d3bbf1c2-a6ec-4210-b1e7-3e48461cc45b
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      calculation_1: "#9E7FD0"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: calculation_1, name: Calculation
              1, axisId: calculation_1}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [ticket.count]
    listen: {}
    row: 4
    col: 7
    width: 10
    height: 12
  - title: "% of Tickets Created by Weekday"
    name: "% of Tickets Created by Weekday"
    model: zendesk_analytics
    explore: ticket
    type: looker_column
    fields: [ticket.created_day_of_week, ticket.count]
    fill_fields: [ticket.created_day_of_week]
    sorts: [ticket.created_day_of_week]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ticket.count}/sum(${ticket.count})", value_format: !!null '',
        value_format_name: percent_2, _kind_hint: measure, _type_hint: number}]
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: d3bbf1c2-a6ec-4210-b1e7-3e48461cc45b
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      percent_of_total: "#7CC8FA"
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: percent_of_total, name: Percent
              of Total, axisId: percent_of_total}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [ticket.count]
    listen: {}
    row: 4
    col: 17
    width: 7
    height: 12
  - title: Daily Activity for the last 30 days
    name: Daily Activity for the last 30 days
    model: zendesk_analytics
    explore: ticket
    type: looker_column
    fields: [ticket.created_date, ticket.count_solved_tickets, ticket.count_tickets_on_hold,
      ticket.count_pending_tickets, ticket.count_open_tickets]
    fill_fields: [ticket.created_date]
    filters:
      ticket.created_date: 30 days
    sorts: [ticket.created_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: normal
    trellis: ''
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: d3bbf1c2-a6ec-4210-b1e7-3e48461cc45b
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      ticket.count_pending_tickets: "#FCCF41"
      ticket.count_open_tickets: "#f56776"
      ticket.count_solved_tickets: "#10C871"
      ticket.count_tickets_on_hold: "#7CC8FA"
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 16
    col: 0
    width: 24
    height: 12
  - title: Tickets by Group
    name: Tickets by Group
    model: zendesk_analytics
    explore: ticket
    type: looker_pie
    fields: [ticket.count, group.name]
    filters:
      group.name: "-EMPTY"
    sorts: [group.name]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    inner_radius: 60
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      custom:
        id: afa91170-d05d-2031-a3a4-b3b804195cef
        label: Custom
        type: discrete
        colors:
        - "#7CC8FA"
        - "#ACE9F5"
        - "#C8A7F9"
        - "#9E7FD0"
        - "#f56776"
        - "#FD9577"
        - "#FDEC85"
        - "#AEC8C1"
        - "#F29ED2"
      options:
        steps: 5
    series_colors: {}
    series_types: {}
    row: 10
    col: 0
    width: 7
    height: 6
  - title: Tickets by Channel
    name: Tickets by Channel
    model: zendesk_analytics
    explore: ticket
    type: looker_pie
    fields: [ticket.via_channel, ticket.count]
    sorts: [ticket.count desc]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    inner_radius: 60
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      custom:
        id: 3a9ebf3e-4723-159c-079e-42f4d2a0e924
        label: Custom
        type: discrete
        colors:
        - "#f56776"
        - "#FD9577"
        - "#FDEC85"
        - "#F29ED2"
      options:
        steps: 5
    series_colors: {}
    series_types: {}
    row: 4
    col: 0
    width: 7
    height: 6
