- dashboard: agent_statistics
  title: Agent Statistics
  layout: newspaper
  elements:
  - name: Admin Type
    title: Admin Type
    model: intercom
    explore: conversations_parts
    type: looker_column
    fields:
    - admins.type
    - admins.count
    filters:
      admins.type: "-NULL"
    sorts:
    - admins.count desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 16
    col: 0
    width: 12
    height: 8
  - name: Distibution of Assignment
    title: Distibution of Assignment
    model: intercom
    explore: conversations_parts
    type: looker_column
    fields:
    - conversations_parts.count
    - admins.name
    filters:
      admins.name: "-NULL"
      conversations_parts.part_type: assignment
    sorts:
    - conversations_parts.count desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    series_types: {}
    row: 0
    col: 0
    width: 12
    height: 8
  - name: Distribution of Closures
    title: Distribution of Closures
    model: intercom
    explore: conversations_parts
    type: looker_pie
    fields:
    - admins.name
    - conversations.tickets_cnt
    filters:
      admins.name: "-NULL"
      conversations.close: 'Yes'
    sorts:
    - conversations.tickets_cnt desc
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 0
    col: 12
    width: 12
    height: 8
  - name: Distribution of One Touch
    title: Distribution of One Touch
    model: intercom
    explore: conversations_parts
    type: looker_pie
    fields:
    - ticket_stats.one_touch
    - admins.name
    filters:
      admins.name: "-NULL"
    sorts:
    - ticket_stats.one_touch desc
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 8
    col: 0
    width: 12
    height: 8
