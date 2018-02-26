view: conversations {
  sql_table_name: public.cont_ic_conversations ;;

  dimension: id {
    description: "Conversation unique identifier"
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  measure: tickets_cnt {
    description: "Total Number of conversation"
    type:  count_distinct
    sql: ${id} ;;
  }

  dimension: close{
    description: "Checks if a conversation is closed"
    type: yesno
    sql: NOT ${TABLE}.open ;;
  }

  dimension: read{
    description: "Check if a conversation is read"
    type: yesno
    sql: NOT ${TABLE}.read ;;
  }

  measure: percent_of_tickets{
    description: "Calculates a cell’s portion of the column total. The percentage is being calculated against the total of the displayed rows"
    type: percent_of_total
    sql: ${tickets_cnt} ;;
    drill_fields: [tickets_cnt]
  }


  dimension: assignee_id {
    description: "Unique identifier of the agent to whom the ticket is assigned"
    type: string
    sql: ${TABLE}.assignee_id ;;
  }

  dimension_group: created_at {
    description: "Ticket's creation time"
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
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: updated {
    description: "Ticket's last update"
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
}
