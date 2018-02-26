view: admins {
  sql_table_name: public.cont_ic_admins ;;

  dimension: id {
    description: "Admin's unique identifier"
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: blendo_imported_at {
    type: number
    sql: ${TABLE}.blendo_imported_at ;;
  }

  dimension: email {
    description: "Admin's professional email"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: name {
    description: "Admin's name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: type {
    description: "Admin's duty type"
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    description: "Count of admins"
    type: count
    drill_fields: [type, name, id]
  }
}
