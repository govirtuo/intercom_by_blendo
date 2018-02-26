- dashboard: general_statistics
  title: General Statistics
  layout: newspaper
  elements:
  - name: Location Distribution
    title: Location Distribution
    model: intercom
    explore: cont_ic_users
    type: looker_pie
    fields:
    - cont_ic_users.city
    - cont_ic_users.count
    filters:
      cont_ic_users.city: "-NULL"
    sorts:
    - cont_ic_users.count desc
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    col: 0
    width: 12
    height: 7
  - name: Ticket Closures
    title: Ticket Closures
    model: intercom
    explore: conversations_parts
    type: looker_line
    fields:
    - conversations_parts.updated_month
    - conversations_parts.count
    fill_fields:
    - conversations_parts.updated_month
    filters:
      conversations_parts.part_type: close
    sorts:
    - conversations_parts.updated_month desc
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 0
    col: 12
    width: 12
    height: 7
  - name: Percent of Tickets Solved
    title: Percent of Tickets Solved
    model: intercom
    explore: conversations_parts
    type: looker_column
    fields:
    - conversations.percent_of_tickets
    - conversations.close
    fill_fields:
    - conversations.close
    sorts:
    - conversations.percent_of_tickets desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
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
    show_null_points: true
    point_style: none
    interpolation: linear
    value_labels: legend
    label_type: labPer
    series_types: {}
    row: 7
    col: 0
    width: 6
    height: 8
  - name: Ticket Creation
    title: Ticket Creation
    model: intercom
    explore: conversations_parts
    type: looker_line
    fields:
    - conversations.created_at_month
    - conversations.tickets_cnt
    fill_fields:
    - conversations.created_at_month
    filters:
      admins.name: "-NULL"
    sorts:
    - conversations.created_at_month desc
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
    show_null_points: true
    point_style: none
    interpolation: linear
    value_labels: legend
    label_type: labPer
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 7
    col: 12
    width: 12
    height: 8
  - name: One Touch Tickets
    title: One Touch Tickets
    model: intercom
    explore: conversations_parts
    type: single_value
    fields:
    - ticket_stats.one_touch
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 15
    col: 6
    width: 6
    height: 6
  - name: New Tickets
    title: New Tickets
    model: intercom
    explore: conversations_parts
    type: single_value
    fields:
    - ticket_stats.new_count
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 15
    col: 12
    width: 6
    height: 6
  - name: Read Conversations
    title: Read Conversations
    model: intercom
    explore: conversations_parts
    type: looker_column
    fields:
    - conversations.percent_of_tickets
    - conversations.read
    fill_fields:
    - conversations.read
    sorts:
    - conversations.percent_of_tickets desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
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
    row: 7
    col: 6
    width: 6
    height: 8
