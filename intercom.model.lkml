connection: "production"

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
  join: cont_ic_users {
    type: left_outer
    sql_on: ${conversations.user_id} = ${cont_ic_users.id} ;;
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
  join: tags {
    type: left_outer
    sql_on: ${tags.id} = ${conversations.tags} ;;
    #NBED review join so that all tags included in a conversation can be explored in the tags table
    # and not only the conversations with one tag only
    relationship: many_to_many
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

explore: tags {
  label: "Tags"
}
