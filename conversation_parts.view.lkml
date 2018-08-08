view: conversations_parts {
  sql_table_name: intercom.conversation_parts;;


  dimension: id {
    primary_key: yes
    description: "Unique identifier of conversation part"
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: assigned_to_id {
    description: "Unique identifier of assignee"
    type: string
    sql: ${TABLE}.assigned_to_id ;;
  }

  dimension: author_id {
    description: "Unique identifier of the author"
    type: string
    sql: ${TABLE}.author_id ;;
  }

  dimension: author_type {
    type: string
    sql: ${TABLE}.author_type ;;
  }

  dimension: part_type {
    description: "Part type, i.e Comment, Close, Note, Assignment"
    type: string
    sql: ${TABLE}.part_type ;;
  }

  dimension: body {
    description: "Message body"
    type: string
    sql: ${TABLE}.body ;;
  }

  dimension: conversation_id {
    description: "Unique identifier of the related conversation"
    type: string
    sql: ${TABLE}.conversation_id ;;
  }

  dimension_group: updated {
    description: "Update time"
    type: time
    timeframes: [time, date, week, month, raw,day_of_week,hour_of_day]
    sql: ${TABLE}.updated_at;;
  }

  dimension: is_sc_answer {
    description: "Message from SC"
    type: yesno
    sql: (${part_type}='comment' OR ${part_type}='assignment') AND ${body} is not null AND ${author_type}='admin' ;;
  }

  dimension: is_new_conversation {
    description: "First message from client"
    type: yesno
    sql: (${part_type}='open') AND ${body} is not null AND ${author_type}='user' ;;
    hidden: yes
  }

  dimension: is_sc_sollicitation {
    description: "Sollicitation from SC"
    type: yesno
    sql: (${part_type}='open') AND ${body} is not null AND ${author_type}='admin' ;;
  }

  dimension: is_empty {
    description: "Message is empty"
    type: yesno
    sql: ${body} is null ;;
  }

  dimension: is_inbound_call {
    description: "Inbound call"
    type: yesno
    sql: (${part_type}='note') AND ${body}  like '<p>Caller%' ;;
  }

  dimension: is_infoge_call {
    description: "Infos gés call"
    type: yesno
    sql: (${part_type}='note') AND ${body}  like '<p>Caller%' AND ${body}  like '%Infos générales%' ;;
  }

  dimension: is_missed_call {
    description: "Missed call"
    type: yesno
    sql: (${part_type}='note') AND ${body}  like '<p>Caller%' AND  ${body}  not like '%<br> Answered%'  ;;
  }

  measure: count {
    type: count
    drill_fields: [updated_month, count]
  }

  measure: percent_of_tickets{
    description: "Calculates a cell’s portion of the column total. The percentage is being calculated against the total of the displayed rows"
    type: percent_of_total
    sql: ${count} ;;
  }

}
