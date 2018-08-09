view: conversations_parts {
  derived_table: {
    sql:  with ic1 as (select *, ROW_NUMBER() OVER(PARTITION BY conversation_id ORDER BY updated_at) as sequence_number from intercom.conversation_parts),
          ic2 as (select conversation_id, id, author_type, updated_at, ROW_NUMBER() OVER(PARTITION BY conversation_id ORDER BY updated_at) as sequence_number from intercom.conversation_parts),
          icfa as (select conversation_id, min(case when author_type='admin' then updated_at else null end) as first_answer, min(updated_at) as beginning from intercom.conversation_parts  group by conversation_id)
          select ic1.*, ic2.id as previous_message, ic2.updated_at as previous_message_time, ic2.author_type as previous_author, icfa.first_answer, icfa.beginning  from ic1 left join ic2 on ic1.conversation_id=ic2.conversation_id and ic1.sequence_number=ic2.sequence_number+1 left join icfa on ic1.conversation_id=icfa.conversation_id ;;
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

  dimension: previous_author {
    type: string
    hidden: yes
    sql: ${TABLE}.previous_author ;;
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

  dimension_group: first_answer {
    description: "First answer"
    type: time
    timeframes: [time, date, week, month, raw,day_of_week,hour_of_day]
    sql: ${TABLE}.first_answer;;
    hidden: yes
  }

  dimension_group: beginning {
    description: "First answer"
    type: time
    timeframes: [time, date, week, month, raw,day_of_week,hour_of_day]
    sql: ${TABLE}.beginning;;
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

  dimension: conversation_delay {
    view_label: "Conversations"
    description: "Delay of first answer"
    type: number
    value_format_name: decimal_1
    sql:  DATE_PART('hour', ${first_answer_raw} - ${beginning_raw} ) * 60 +
          DATE_PART('minute', ${first_answer_raw} - ${beginning_raw} ) +
          DATE_PART('second', ${first_answer_raw} - ${beginning_raw} )/60 ;;
    required_fields: [is_new_conversation]
  }



  dimension: is_sc_answer {
    group_label: "Type of message"
    description: "Message from SC"
    type: yesno
    sql: (${part_type}='comment' OR ${part_type}='assignment') AND ${body} is not null AND ${author_type}='admin' AND (${previous_author}='user' OR ${sequence_number}=2);;
  }

  dimension: is_user_message {
    group_label: "Type of message"
    description: "Message from client"
    type: yesno
    sql: (${part_type}='comment' OR ${part_type}='assignment') AND ${body} is not null AND ${author_type}='user';;
  }

  dimension: is_new_conversation {
    group_label: "Type of message"
    description: "First message from client"
    type: yesno
    sql: ((${part_type}='assignment' AND ${author_type}='bot') OR (${author_type}='user' AND ${is_empty} is false))  AND ${sequence_number}=1 ;;
  }

  dimension: is_sc_sollicitation {
    group_label: "Type of message"
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
    group_label: "Type of call"
    description: "Inbound call"
    type: yesno
    sql: (${part_type}='note') AND ${body}  like '<p>Caller%' ;;
  }

  dimension: is_infoge_call {
    group_label: "Type of call"
    description: "Infos gés call"
    type: yesno
    sql: (${part_type}='note') AND ${body}  like '<p>Caller%' AND ${body}  like '%Infos générales%' ;;
  }

  dimension: is_missed_call {
    group_label: "Type of call"
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

  measure: average_delay {
    description: "Average answer delay"
    type: average
    sql: ${delay} ;;
  }

  measure: median_delay {
    description: "Median answer delay"
    type: median
    sql: ${delay} ;;
  }

}
