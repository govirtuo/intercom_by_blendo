view: cont_ic_users {
  sql_table_name: intercom.users ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
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

  dimension_group: last_request {
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
    sql: ${TABLE}.last_request_at ;;
  }

  dimension: last_seen_ip {
    type: string
    sql: ${TABLE}.last_seen_ip ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.location_city_name ;;
  }

  measure: count {
    type:  count
  }


}
