view: resolution_metrics {
  derived_table: {
    sql:  SELECT  abs(EXTRACT(epoch FROM (fRe.fullResolution - fOp.firstOpen))/3600) as fullRes_dif,
          abs(EXTRACT(epoch FROM (fRe.firstResolution - fOp.firstOpen))/3600) as firstRes_dif,
          abs(EXTRACT(epoch FROM (fCo.firstComment - fOp.firstOpen))/3600) as firstResp_dif,
          fRe.fullResolution as date,
          fRe.conversation_id as conversation_id
             FROM
      (SELECT conversation_id, min(updated_at) AS firstResolution,
      max(updated_at) AS fullResolution
      FROM cont_ic_conversations_parts
      WHERE part_type='close'
      GROUP BY conversation_id) fRe,

      (SELECT conversation_id,
      min(updated_at) AS firstOpen
      FROM cont_ic_conversations_parts
      WHERE part_type='comment'
      AND author_type='user'
      GROUP BY conversation_id) fOp,

      (SELECT conversation_id,
                min(updated_at) AS firstComment
         FROM cont_ic_conversations_parts
         WHERE part_type='comment'
           AND author_type='admin'
         GROUP BY conversation_id) fCo

      WHERE fRe.conversation_id=fOp.conversation_id and fCo.conversation_id=fOp.conversation_id
      AND (fRe.fullResolution - fOp.firstOpen)>=interval '0' AND (fCo.firstComment - fOp.firstOpen)>=interval '0'
       ;;
  }

  dimension: conversation_id {
    description: "Unique identifier of related conversation"
    type: string
    primary_key: yes
    sql: ${TABLE}.conversation_id ;;
  }

  measure: full_Resolution_maximum {
    type: max
    sql: ${TABLE}.fullRes_dif ;;
  }

  measure: full_Resolution_minimum {
    type: min
    sql:${TABLE}.fullRes_dif ;;
  }

  measure: full_Resolution_average {
    type: average
    sql:${TABLE}.fullRes_dif  ;;
  }

  measure: full_Resolution_median {
    type: median
    sql:${TABLE}.fullRes_dif  ;;
  }

  measure: first_Resolution_maximum {
    type: max
    sql: ${TABLE}.firstRes_dif ;;
  }

  measure: first_Resolution_minimum {
    type: min
    sql:${TABLE}.firstRes_dif ;;
  }

  measure: first_Resolution_average {
    type: average
    sql:${TABLE}.firstRes_dif  ;;
  }

  measure: first_Resolution_median {
    type: median
    sql:${TABLE}.firstRes_dif  ;;
  }

  measure: first_Response_maximum {
    type: max
    sql: ${TABLE}.firstResp_dif ;;
  }

  measure: first_Response_minimum {
    type: min
    sql:${TABLE}.firstResp_dif ;;
  }

  measure: first_Response_average {
    type: average
    sql:${TABLE}.firstResp_dif  ;;
  }

  measure: first_Response_median {
    type: median
    sql:${TABLE}.firstResp_dif  ;;
  }

  dimension_group: date {
    type: time
    timeframes: [date, day_of_week, week, month]
    sql: ${TABLE}.date ;;
    drill_fields: [date_date, date_day_of_week, date_week, date_month]
  }

}
