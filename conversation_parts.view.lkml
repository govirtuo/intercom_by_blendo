view: conversations_parts {
  derived_table: {
    sql:  with ic as (
            select a.*,b.user_id from intercom.conversation_parts a, intercom.conversations b where b.id=a.conversation_id
            UNION
            select
              id,
              received_at,
              uuid_ts,
              assignee_id as assigned_to_id,
              assignee_type as assigned_to_type,
              message_author_id as "author_id",
              message_author_type as "author_type",
              message_body as body,
              id as "conversation_id",
              created_at,
              created_at as notified_at,
              'first' as part_type,
              created_at as updated_at,
              user_id
            from intercom.conversations
          ),

          ic1 as
              (select *,
                      ROW_NUMBER() OVER(PARTITION BY user_id, date(updated_at) ORDER BY updated_at) as sequence_number,
                      user_id || date(updated_at) as alt_id
              from ic),
          ic2 as -- same table, for previous messages
              (select conversation_id,
                      user_id || date(updated_at) as alt_id,
                      id,
                      author_type,
                      updated_at,
                      part_type,
                      body,
                      ROW_NUMBER() OVER(PARTITION BY user_id, date(updated_at)  ORDER BY updated_at) as sequence_number
              from ic),
          ic4t as  -- same table, for the fourth message (useful in case of calls)
              (select conversation_id,
                      user_id || date(updated_at) as alt_id,
                      id,
                      author_type,
                      part_type,
                      updated_at,
                      body,
                      ROW_NUMBER() OVER(PARTITION BY user_id, date(updated_at) ORDER BY updated_at) as sequence_number
              from ic),
          icfa as --first message of the conversation
              (select user_id || date(updated_at) as alt_id,
                      min(case when (author_type='admin' AND (part_type='comment' OR part_type='assignment') AND body is not null) OR (part_type='first' AND body like '%Outbout%') then updated_at else null end) as first_answer,
                      --NBED: add first missed call and first message/callback after the missed call
                      min(case when body is not null and author_type='user' then updated_at else null end) as beginning
              from ic
              group by user_id, date(updated_at))
          select ic1.*,
                  ic2.id as previous_message,
                  ic2.body as previous_body,
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
            on ic1.alt_id=icfa.alt_id ;;
    indexes: ["id"]
    sql_trigger_value: SELECT FLOOR((EXTRACT(epoch from NOW())-80*60)/(60*60*6)) ;;

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

  dimension: user_id {
    description: "Unique identifier of the user (customer) of the conversation"
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: alt_id {
    description: "User_id || date"
    type: string
    sql: ${TABLE}.alt_id ;;
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
    description: "Part type, i.e Comment, Close, Note, Assignment or First"
    type: string
    sql: ${TABLE}.part_type ;;
  }

  dimension: body {
    description: "Message body"
    type: string
    sql: ${TABLE}.body ;;
  }

  dimension: previous_body {
    description: "Message body of the previous message"
    type: string
    sql: ${TABLE}.previous_body ;;
    hidden: yes
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

  dimension: is_welcome_previous {
    description: "Is previous message the automatic welcome"
    type: yesno
    sql: ${previous_body} like '%<p>N''hésitez pas à nous contacter ici si vous avez des questions :-)</p>'
        OR ${previous_body} like '%n’hésitez pas à nous contacter ici si vous avez la moindre question ! <br></p>'
        OR ${previous_body} like '%<p>If you’ve got any questions or feedback while you’re getting started, let me know :-)</p>%'
        OR ${previous_body} like '%feel free to get in touch if you have any questions! <br></p>' ;;
    hidden: yes
  }

  dimension: is_welcome {
    description: "Is previous message the automatic welcome"
    type: yesno
    sql: ${sequence_number}=1 AND
        (${body} like '%<p>N''hésitez pas à nous contacter ici si vous avez des questions :-)</p>'
        OR ${body} like '%n’hésitez pas à nous contacter ici si vous avez la moindre question ! <br></p>'
        OR ${body} like '%<p>If you’ve got any questions or feedback while you’re getting started, let me know :-)</p>%'
        OR ${body} like '%feel free to get in touch if you have any questions! <br></p>') ;;
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

  dimension: call_duration_interim {
    group_label: "Call informations"
    description: "Call duration interim"
    hidden: no
    type: string
    sql: case when position('Duration' in ${body})=0
    then null else substring(${body}, position('Duration' in ${body})+10,5) end  ;;
  }

  dimension: call_duration {
    group_label: "Call informations"
    description: "Call duration"
    type: number
    value_format_name: decimal_1
    sql:  case
          when ${is_inbound_call} is true and ${part_type}='note' and (${is_missed_call} is false) THEN
            DATE_PART('hour', ${fourth_message_raw} - ${updated_raw})*60 +
            DATE_PART('minute', ${fourth_message_raw} - ${updated_raw}) +
            DATE_PART('second', ${fourth_message_raw} - ${updated_raw})/60
          when ${is_inbound_call} is true and ${part_type}='first' and ${is_missed_call} is false
            THEN cast(substring(${call_duration_interim},1,2) as real)+cast(substring(${call_duration_interim},4,2) as real)/60
          when ${is_outbound_call} is true and ${part_type}='first' --and ${is_answered} is true (in case of unanswered calls to clients, call duration is also counted)
            THEN cast(substring(${call_duration_interim},1,2) as real)+cast(substring(${call_duration_interim},position(':' in ${call_duration_interim})+1,2) as real)/60
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

  dimension: is_sc_message {
    group_label: "Type of message"
    description: "Message from SC"
    type: yesno
    sql: (${part_type}='comment' OR ${part_type}='assignment') AND ${body} is not null AND ${author_type}='admin' ;;
  }

  dimension: is_user_message {
    group_label: "Type of message"
    description: "Message from client"
    type: yesno
    sql: (${part_type}='comment' OR ${part_type}='assignment' OR ${part_type}='first') AND ${body} is not null AND ${is_outbound_call} is false AND ${author_type}='user';;
  }

  dimension: is_new_conversation {
    group_label: "Type of message"
    description: "First message from client"
    type: yesno
    sql: ${author_type}='user' AND ${is_outbound_call} is false AND ${is_empty} is false  AND (${sequence_number}=1 OR (${sequence_number}=2 and ${is_welcome_previous} is true)) ;;
  }

  dimension: is_sc_sollicitation {
    group_label: "Type of message"
    description: "Sollicitation from SC"
    type: yesno
    sql: (${part_type}='open' or ${part_type}='first') AND ${body} is not null AND ${author_type}='admin' and ${is_welcome} is false ;;
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
    sql:  (
          (${part_type}='note')
          AND ${body}  like '<p>Caller%'
          )
        OR
          (${part_type}='first'
          AND
          (${body} like '%Inbound call%' OR ${body} like '%Inbound answered call%')
          );;
  }

  dimension: is_outbound_call {
    group_label: "Type of call"
    description: "Inbound call"
    type: yesno
    sql: ${part_type}='first' AND (${body} like '%Outbound call%' OR ${body} like '%Outbound answered call%' OR ${body} like '%Outbound unanswered call%') ;;
  }

  dimension: is_infoge_call {
    group_label: "Type of call"
    description: "Infos gés call"
    type: yesno
    sql: ${is_inbound_call} AND ${body}  like '%Infos générales%' ;;
  }

  dimension: is_missed_call {
    group_label: "Type of call"
    description: "Missed call"
    type: yesno
    sql: ${is_inbound_call} AND
          (
            (${body} not like '%Answered by%' AND ${part_type}='note')
            OR
            (${body} like '%(missed)%' AND ${part_type}='first')
          ) ;;
  }

  dimension: is_answered {
    group_label: "Type of call"
    description: "Call answered by the client"
    type: yesno
    sql: ${is_outbound_call} AND (${body} like '% answered%' OR ${body} like '%(answered)%') ;;
  }

  dimension: is_true_call {
    group_label: "Type of call"
    description: "Call answered by any of the two parties"
    type: yesno
    sql: (${is_inbound_call} AND NOT ${is_missed_call})
          OR
          (${is_outbound_call} AND NOT ${is_answered}) ;;
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
    sql:case
          when ${is_inbound_call}=true and ${part_type}='note' then
            cast(substring(${waiting_duration_string}, 15, 2) as real)*60
            +cast(substring(${waiting_duration_string}, 19, 2) as real)
            +cast(substring(${waiting_duration_string}, 22, 2) as real)/60
          null end;;
  }

## Measures

  measure: count {
    type: count
    drill_fields: [updated_time, count]
  }

  measure: count_conversations {
    type: count_distinct
    sql: ${alt_id} ;;
    drill_fields: [updated_time, count]
  }

  measure: count_distinct_callers {
    group_label: "Count calls"
    type: count_distinct
    sql: case when ${is_inbound_call} or ${is_outbound_call} then ${user_id} else null end ;;
  }

  measure: count_distinct_calls {
    group_label: "Count calls"
    type: count_distinct
    sql: case when ${is_inbound_call} or ${is_outbound_call} then ${conversation_id} else null end ;;
    # NB : un call en réponse apparaît dans une nouvelle conversation
  }


  measure: count_SC_messages {
    type: count_distinct
    sql: case when ${is_sc_message} then ${id} else null end ;;
    drill_fields: [updated_time, count]
  }

  measure: count_inbound_messages {
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
    group_label: "Answer delay"
    description: "Average answer delay"
    type: average
    value_format_name: decimal_1
    sql: ${delay} ;;
  }

  measure: median_delay {
    group_label: "Answer delay"
    description: "Median answer delay"
    type: median
    value_format_name: decimal_1
    sql: ${delay} ;;
  }

  measure: median_first_answer {
    group_label: "Answer delay"
    description: "Median delay in first answer"
    type: median
    value_format_name: decimal_1
    sql: ${conversation_delay} ;;
  }


  measure: median_call {
    group_label: "Call duration stats"
    description: "Median call duration"
    type: median
    value_format_name: decimal_1
    sql: ${call_duration} ;;
  }

  measure: total_call_duration {
    group_label: "Call duration stats"
    description: "Total call duration"
    type: sum
    value_format_name: decimal_0
    sql: ${call_duration} ;;
  }

  measure: median_call_waiting {
    group_label: "Call duration stats"
    description: "Median call waiting"
    type: median
    value_format_name: decimal_1
    sql: ${waiting_duration} ;;
  }

  measure: median_SC_answer {
    group_label: "Answer delay"
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
