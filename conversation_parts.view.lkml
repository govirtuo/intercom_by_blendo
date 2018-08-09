view: conversations_parts {
  derived_table: {
    sql:  with ic1 as (select *, ROW_NUMBER() OVER(PARTITION BY conversation_id ORDER BY updated_at) as sequence_number from intercom.conversation_parts),
          ic2 as (select conversation_id, id, updated_at, ROW_NUMBER() OVER(PARTITION BY conversation_id ORDER BY updated_at) as sequence_number from intercom.conversation_parts)
          select ic1.*, ic2.id as previous_message, ic2.updated_at as previous_message_time from ic1 left join ic2 on ic1.conversation_id=ic2.conversation_id and ic1.sequence_number=ic2.sequence_number+1 ;;
    }


  dimension: id {
    primary_key: yes
    description: "Unique identifier of conversation part"
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: previous_id {
    description: "Unique identifier of the previous conversation part"
    type: string
    sql: ${TABLE}.previous_message ;;
  }

  dimension: assigned_to_id {
    description: "Unique identifier of assignee"
    type: string
    sql: ${TABLE}.assigned_to_id ;;
  }

  dimension: sequence_number {
    description: "Sequence number"
    type: number
    sql: ${TABLE}.sequence_number ;;
    hidden: yes
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

  dimension_group: updated_previous {
    description: "Previous time"
    type: time
    timeframes: [time, date, week, month, raw,day_of_week,hour_of_day]
    sql: ${TABLE}.previous_message_time;;
    hidden: yes
  }

  dimension: delay {
    description: "Delay"
    type: number
    value_format_name: decimal_1
    sql:  DATE_PART('hour', ${updated_raw} - ${updated_previous_raw} ) * 60 +
          DATE_PART('minute', ${updated_raw} - ${updated_previous_raw} ) +
          DATE_PART('second', ${updated_raw} - ${updated_previous_raw} )/60 ;;
  }


  dimension: is_sc_answer {
    description: "Message from SC"
    type: yesno
    sql: (${part_type}='comment' OR ${part_type}='assignment') AND ${body} is not null AND ${author_type}='admin' ;;
  }

  dimension: is_new_conversation {
    description: "First message from client"
    type: yesno
    sql: (${part_type}='assignment') AND ${sequence_number}=1 ;;
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
