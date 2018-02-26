connection: "blendo_database"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: conversations_parts {
  label: "Ticket Statistics"
  join: admins {
    type: left_outer
    sql_on: ${conversations_parts.assigned_to_id} = ${admins.id} ;;
    relationship: many_to_one
  }
  join: conversations {
    type: left_outer
    sql_on: ${conversations.id} = ${conversations_parts.conversation_id} ;;
    relationship: many_to_one
  }
  join: ticket_stats {
    type: left_outer
    sql_on:${ticket_stats.conversation_id}=${conversations.id}  ;;
    relationship: one_to_one
  }
  join: resolution_metrics {
    type: left_outer
    sql_on: ${conversations_parts.conversation_id} = ${resolution_metrics.conversation_id};;
    relationship: many_to_one
  }

  join: requester_wait_time {
    type: left_outer
    sql_on: ${conversations_parts.conversation_id} = ${requester_wait_time.id};;
    relationship: many_to_one
  }
}

explore: cont_ic_users {
  label: "Users"
}
