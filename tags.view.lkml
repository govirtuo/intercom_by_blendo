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

  dimension: category_raw {
    type: string
    sql: case when position('-' in ${name})=0 then ''
    else lower(substring(${name},0,position(' - ' in ${name}))) end ;;
    hidden: yes
  }

  dimension: category {
    type: string
    sql: case when ${category_raw} is null then null
        when ${category_raw}='csv import'
          or ${category_raw}=''
          or ${category_raw}='other' then 'other'
        when ${category_raw}='during rental'
          or ${category_raw}='during'
          or ${category_raw}='late return' then 'during rental'
        when ${category_raw}='booking confirmed' then ${category_raw}
        when ${category_raw}='before booking'
            or ${category_raw}='before rental'
            or ${category_raw}='before' then 'before booking'
        when ${category_raw}='after rental'
            or ${category_raw}='after' then 'after rental'
        when ${category_raw} like '%on hold%' then 'on hold'
        else 'other'
        end;;
  }

  dimension: subcategory {
    type: string
    sql: case when ${category_raw}='' then null
          when ${category_raw} is null then null
          else lower(substring(${name},length(${category_raw})+4))
        end ;;
  }


  set: detail {
    fields: [id, received_at, uuid_ts, name]
  }
}
