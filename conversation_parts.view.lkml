view: conversations_parts {
  derived_table: {
    sql:  with ic1 as
              (select *,
                      ROW_NUMBER() OVER(PARTITION BY conversation_id ORDER BY updated_at) as sequence_number
              from intercom.conversation_parts),
          ic2 as
              (select conversation_id,
                      id,
                      author_type,
                      updated_at,
                      part_type,
                      ROW_NUMBER() OVER(PARTITION BY conversation_id ORDER BY updated_at) as sequence_number
              from intercom.conversation_parts),
          ic4t as
              (select conversation_id,
                      id,
                      author_type,
                      part_type,
                      updated_at,
                      body,
                      ROW_NUMBER() OVER(PARTITION BY conversation_id ORDER BY updated_at) as sequence_number
              from intercom.conversation_parts),
          icfa as
              (select conversation_id,
                      min(case when author_type='admin' AND (part_type='comment' OR part_type='assignment') then updated_at else null end) as first_answer,
                      min(updated_at) as beginning
              from intercom.conversation_parts
              group by conversation_id)
          select ic1.*,
                  ic2.id as previous_message,
                  ic4t.id as fourth_message,
                  ic4t.updated_at as fourth_message_time,
                  ic2.updated_at as previous_message_time,
                  ic2.author_type as previous_author,
                  icfa.first_answer, icfa.beginning,
                  ic4t.part_type as fourth_message_type,
                  ic4t.body as fourth_message_body
          from ic1
          left join ic2
            on ic1.conversation_id=ic2.conversation_id and ic1.sequence_number=ic2.sequence_number+1
          left join ic4t
            on ic1.conversation_id=ic4t.conversation_id and ic1.sequence_number=ic4t.sequence_number-3
          left join icfa
            on ic1.conversation_id=icfa.conversation_id ;;
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

  dimension_group: fourth_message {
    description: "Fourth answer"
    type: time
    timeframes: [time, date, week, month, raw,day_of_week,hour_of_day]
    sql: ${TABLE}.fourth_message_time;;
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

  dimension: call_duration {
    group_label: "Call informations"
    description: "Call duration"
    type: number
    value_format_name: decimal_1
    sql:  case when ${is_inbound_call} is true then
          DATE_PART('hour', ${fourth_message_raw} - ${updated_raw} ) * 60 +
          DATE_PART('minute', ${fourth_message_raw} - ${updated_raw} ) +
          DATE_PART('second', ${fourth_message_raw} - ${updated_raw} )/60
          else null end ;;
  }

  dimension: conversation_delay {
    view_label: "Conversations"
    description: "Delay of first answer"
    type: number
    value_format_name: decimal_1
    sql:  DATE_PART('hour', ${first_answer_raw} - ${beginning_raw} ) * 60 +
          DATE_PART('minute', ${first_answer_raw} - ${beginning_raw} ) +
          DATE_PART('second', ${first_answer_raw} - ${beginning_raw} )/60 ;;
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

  dimension: call_informations {
    group_label: "Call informations"
    description: "Call informations"
    type: yesno
    sql: (${part_type}='note') AND ${body}  like '<p>Duration of call : %' ;;
    hidden: yes
  }

  dimension: waiting_duration_string {
    type: string
    sql: substring(${body},position('Waiting time : ' in ${body}),23);;
    hidden: yes
  }

  dimension: waiting_duration {
    group_label: "Call informations"
    description: "Waiting duration"
    type: number
    value_format_name: decimal_1
    sql:case when ${is_inbound_call}=true then
        cast(substring(${waiting_duration_string}, 15, 2) as real)*60
        +cast(substring(${waiting_duration_string}, 19, 2) as real)
        +cast(substring(${waiting_duration_string}, 22, 2) as real)/60
        else null end;;
  }

## Measures

  measure: count {
    type: count
    drill_fields: [updated_time, count]
  }

  measure: count_conversations {
    type: count_distinct
    sql: ${conversation_id} ;;
    drill_fields: [updated_time, count]
  }


  measure: count_SC_messages {
    type: count
    filters: {
      field: is_sc_answer
      value: "true"
    }
    drill_fields: [updated_time, count]
  }

  measure: count_inbound_conversations {
    type: count
    filters: {
      field: is_user_message
      value: "true"
    }
    drill_fields: [updated_time, count]
  }




  measure: percent_of_tickets{
    description: "Calculates a cell’s portion of the column total. The percentage is being calculated against the total of the displayed rows"
    type: percent_of_total
    sql: ${count} ;;
    hidden: yes
  }

  measure: average_delay {
    description: "Average answer delay"
    type: average
    value_format_name: decimal_1
    sql: ${delay} ;;
  }

  measure: median_delay {
    description: "Median answer delay"
    type: median
    value_format_name: decimal_1
    sql: ${delay} ;;
  }

  measure: median_first_answer {
    description: "Median delay in first answer"
    type: median
    value_format_name: decimal_1
    sql: ${conversation_delay} ;;
  }


  measure: median_call {
    description: "Median call duration"
    type: median
    value_format_name: decimal_1
    sql: ${call_duration} ;;
  }

  measure: total_call_duration {
    description: "Total call duration"
    type: sum
    value_format_name: decimal_0
    sql: ${call_duration} ;;
  }

  measure: median_call_waiting {
    description: "Median call duration"
    type: median
    value_format_name: decimal_1
    sql: ${waiting_duration} ;;
  }

  measure: median_SC_answer {
    description: "Median SC answer"
    type: median
    filters: {
      field: is_sc_answer
      value: "true"
    }
    value_format_name: decimal_1
    sql: ${delay} ;;
  }

}
