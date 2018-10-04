view: tags {
  derived_table: {
    sql: SELECT * from intercom.tags
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: received_at {
    type: string
    sql: ${TABLE}.received_at ;;
  }

  dimension: uuid_ts {
    type: string
    sql: ${TABLE}.uuid_ts ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  set: detail {
    fields: [id, received_at, uuid_ts, name]
  }
}
