view: authors {
  derived_table: {
    sql: select id, name from intercom.users
      UNION
        select id, name from intercom.admins;;
  }

  dimension: id {}

  dimension: name {}

}
