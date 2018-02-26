view: requester_wait_time {
  derived_table: {
    sql:SELECT EXTRACT(epoch FROM SUM (timeDif))/3600 as tD ,
              id
   FROM
     (SELECT tmp3.admin-tmp3.user AS timeDif,
             id, tmp3.admin as date
      FROM
        (SELECT min(tmp2.admin) AS ADMIN,
                tmp2.id,
                tmp2.user
         FROM
           (SELECT tmp.adminTime AS ADMIN,
                   tmp.conversation_id AS id,
                   max(p.updated_at) AS USER
            FROM cont_ic_conversations_parts AS p,

              (SELECT author_type,
                      updated_at AS adminTime,
                      conversation_id
               FROM cont_ic_conversations_parts
               WHERE author_type='admin'
                 AND part_type ='comment') tmp
            WHERE tmp.conversation_id=p.conversation_id
              AND p.updated_at<adminTime
            GROUP BY ADMIN,
                     tmp.conversation_id) tmp2
         GROUP BY tmp2.user,
                  tmp2.id) tmp3)tmp4
   GROUP BY id
       ;;
  }

  dimension: id {
    primary_key: yes
    description: "Unique identifier of conversation"
    type: string
    sql: ${TABLE}.id ;;
  }

  measure: average_requester_wait_time {
    type: average
    sql:${TABLE}.tD  ;;
  }

  measure: maximum_requester_wait_time {
    type: max
    sql: ${TABLE}.tD ;;
  }

  measure: minimum_requester_wait_time {
    type: min
    sql:${TABLE}.tD ;;
  }

  measure: median_requester_wait_time {
    type: median
    sql:${TABLE}.tD  ;;
  }
}
