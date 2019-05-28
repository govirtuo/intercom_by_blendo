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

  dimension: country {
    type: string
    sql: ${TABLE}.location_country_code ;;
  }

  dimension: anonymous {
    type: string
    sql: ${TABLE}.anonymous ;;
  }

  dimension: avatar_image_url {
    type: string
    sql: ${TABLE}.avatar_image_url ;;
  }

  dimension: companies {
    type: string
    sql: ${TABLE}.companies ;;
  }

  dimension: created_at {
    type: string
    sql: ${TABLE}.created_at ;;
  }

  dimension: custom_apple_pay {
    type: string
    sql: ${TABLE}.custom_apple_pay ;;
  }

  dimension: custom_company_name {
    type: string
    sql: ${TABLE}.custom_company_name ;;
  }

  dimension: custom_diduenjoy_survey_link {
    type: string
    sql: ${TABLE}.custom_diduenjoy_survey_link ;;
  }

  dimension: custom_first_name {
    type: string
    sql: ${TABLE}.custom_first_name ;;
  }

  dimension: custom_flag_booked_once {
    type: string
    sql: ${TABLE}.custom_flag_booked_once ;;
  }

  dimension: custom_flag_business_account {
    type: string
    sql: ${TABLE}.custom_flag_business_account ;;
  }

  dimension: custom_flag_conveyor {
    type: string
    sql: ${TABLE}.custom_flag_conveyor ;;
  }

  dimension: custom_flag_deleted {
    type: string
    sql: ${TABLE}.custom_flag_deleted ;;
  }

  dimension: custom_flag_has_credit_card {
    type: string
    sql: ${TABLE}.custom_flag_has_credit_card ;;
  }

  dimension: custom_flag_has_pending_credit_card {
    type: string
    sql: ${TABLE}.custom_flag_has_pending_credit_card ;;
  }

  dimension: custom_flag_locked {
    type: string
    sql: ${TABLE}.custom_flag_locked ;;
  }

  dimension: custom_flag_pin_validated {
    type: string
    sql: ${TABLE}.custom_flag_pin_validated ;;
  }

  dimension: custom_flag_preparator {
    type: string
    sql: ${TABLE}.custom_flag_preparator ;;
  }

  dimension: custom_flag_refused {
    type: string
    sql: ${TABLE}.custom_flag_refused ;;
  }

  dimension: custom_flag_user_is_ambassador {
    type: string
    sql: ${TABLE}.custom_flag_user_is_ambassador ;;
  }

  dimension: custom_flag_validated {
    type: string
    sql: ${TABLE}.custom_flag_validated ;;
  }

  dimension: custom_flag_very_young_driver {
    type: string
    sql: ${TABLE}.custom_flag_very_young_driver ;;
  }

  dimension: custom_flag_young_driver {
    type: string
    sql: ${TABLE}.custom_flag_young_driver ;;
  }

  dimension: custom_intercom_id {
    type: string
    sql: ${TABLE}.custom_intercom_id ;;
  }

  dimension: custom_job_title {
    type: string
    sql: ${TABLE}.custom_job_title ;;
  }

  dimension: custom_language {
    type: string
    sql: ${TABLE}.custom_language ;;
  }

  dimension: custom_last_search_booking_duration {
    type: number
    sql: ${TABLE}.custom_last_search_booking_duration ;;
  }

  dimension: custom_last_search_booking_fail_station {
    type: string
    sql: ${TABLE}.custom_last_search_booking_fail_station ;;
  }

  dimension: custom_last_search_booking_fail_type {
    type: string
    sql: ${TABLE}.custom_last_search_booking_fail_type ;;
  }

  dimension: custom_last_search_booking_station {
    type: string
    sql: ${TABLE}.custom_last_search_booking_station ;;
  }

  dimension: custom_mobile {
    type: string
    sql: ${TABLE}.custom_mobile ;;
  }

  dimension: custom_phone {
    type: string
    sql: ${TABLE}.custom_phone ;;
  }

  dimension: custom_prefered_model {
    type: string
    sql: ${TABLE}.custom_prefered_model ;;
  }

  dimension: custom_row_number {
    type: number
    sql: ${TABLE}.custom_row_number ;;
  }

  dimension: custom_sponsorship_balance {
    type: number
    sql: ${TABLE}.custom_sponsorship_balance ;;
  }

  dimension: custom_sponsorship_times_redeemed {
    type: number
    sql: ${TABLE}.custom_sponsorship_times_redeemed ;;
  }

  dimension: custom_stripe_account_balance {
    type: number
    sql: ${TABLE}.custom_stripe_account_balance ;;
  }

  dimension: custom_stripe_card_brand {
    type: string
    sql: ${TABLE}.custom_stripe_card_brand ;;
  }

  dimension: custom_stripe_card_expires_at {
    type: number
    sql: ${TABLE}.custom_stripe_card_expires_at ;;
  }

  dimension: custom_stripe_deleted {
    type: string
    sql: ${TABLE}.custom_stripe_deleted ;;
  }

  dimension: custom_stripe_delinquent {
    type: string
    sql: ${TABLE}.custom_stripe_delinquent ;;
  }

  dimension: custom_stripe_id {
    type: string
    sql: ${TABLE}.custom_stripe_id ;;
  }

  dimension: custom_stripe_last_charge_amount {
    type: number
    sql: ${TABLE}.custom_stripe_last_charge_amount ;;
  }

  dimension: custom_stripe_last_charge_at {
    type: number
    sql: ${TABLE}.custom_stripe_last_charge_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: last_request_at {
    type: string
    sql: ${TABLE}.last_request_at ;;
  }

  dimension: location_city_name {
    type: string
    sql: ${TABLE}.location_city_name ;;
  }

  dimension: location_continent_code {
    type: string
    sql: ${TABLE}.location_continent_code ;;
  }

  dimension: location_country_code {
    type: string
    sql: ${TABLE}.location_country_code ;;
  }

  dimension: location_country_name {
    type: string
    sql: ${TABLE}.location_country_name ;;
  }

  dimension: location_latitude {
    type: number
    sql: ${TABLE}.location_latitude ;;
  }

  dimension: location_longitude {
    type: number
    sql: ${TABLE}.location_longitude ;;
  }

  dimension: location_postal_code {
    type: string
    sql: ${TABLE}.location_postal_code ;;
  }

  dimension: location_region_name {
    type: string
    sql: ${TABLE}.location_region_name ;;
  }

  dimension: location_timezone {
    type: string
    sql: ${TABLE}.location_timezone ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: pseudonym {
    type: string
    sql: ${TABLE}.pseudonym ;;
  }

  dimension: remote_created_at {
    type: string
    sql: ${TABLE}.remote_created_at ;;
  }

  dimension: segments {
    type: string
    sql: ${TABLE}.segments ;;
  }

  dimension: session_count {
    type: number
    sql: ${TABLE}.session_count ;;
  }

  dimension: signed_up_at {
    type: string
    sql: ${TABLE}.signed_up_at ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
  }

  dimension: unsubscribed_from_emails {
    type: string
    sql: ${TABLE}.unsubscribed_from_emails ;;
  }

  dimension: updated_at {
    type: string
    sql: ${TABLE}.updated_at ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: custom_adjust_adgroup {
    type: string
    sql: ${TABLE}.custom_adjust_adgroup ;;
  }

  dimension: custom_adjust_campaign {
    type: string
    sql: ${TABLE}.custom_adjust_campaign ;;
  }

  dimension: custom_adjust_creative {
    type: string
    sql: ${TABLE}.custom_adjust_creative ;;
  }

  dimension: custom_adjust_network {
    type: string
    sql: ${TABLE}.custom_adjust_network ;;
  }

  dimension: custom_booking_confirmed_add_driver {
    type: string
    sql: ${TABLE}.custom_booking_confirmed_add_driver ;;
  }

  dimension: custom_booking_confirmed_baby_seat {
    type: string
    sql: ${TABLE}.custom_booking_confirmed_baby_seat ;;
  }

  dimension: custom_booking_confirmed_carmodel {
    type: string
    sql: ${TABLE}.custom_booking_confirmed_carmodel ;;
  }

  dimension: custom_booking_confirmed_date {
    type: string
    sql: ${TABLE}.custom_booking_confirmed_date ;;
  }

  dimension: custom_booking_confirmed_from {
    type: string
    sql: ${TABLE}.custom_booking_confirmed_from ;;
  }

  dimension: custom_booking_confirmed_insurance {
    type: string
    sql: ${TABLE}.custom_booking_confirmed_insurance ;;
  }

  dimension: custom_booking_confirmed_location {
    type: string
    sql: ${TABLE}.custom_booking_confirmed_location ;;
  }

  dimension: custom_booking_confirmed_mileage_package {
    type: number
    sql: ${TABLE}.custom_booking_confirmed_mileage_package ;;
  }

  dimension: custom_booking_confirmed_snow_chain {
    type: string
    sql: ${TABLE}.custom_booking_confirmed_snow_chain ;;
  }

  dimension: custom_booking_confirmed_to {
    type: string
    sql: ${TABLE}.custom_booking_confirmed_to ;;
  }

  dimension: custom_booking_pending_carmodel {
    type: string
    sql: ${TABLE}.custom_booking_pending_carmodel ;;
  }

  dimension: custom_booking_pending_date {
    type: string
    sql: ${TABLE}.custom_booking_pending_date ;;
  }

  dimension: custom_booking_pending_from {
    type: string
    sql: ${TABLE}.custom_booking_pending_from ;;
  }

  dimension: custom_booking_pending_location {
    type: string
    sql: ${TABLE}.custom_booking_pending_location ;;
  }

  dimension: custom_booking_pending_to {
    type: string
    sql: ${TABLE}.custom_booking_pending_to ;;
  }

  dimension: custom_card_amex {
    type: string
    sql: ${TABLE}.custom_card_amex ;;
  }

  dimension: custom_card_mastercard {
    type: string
    sql: ${TABLE}.custom_card_mastercard ;;
  }

  dimension: custom_card_visa {
    type: string
    sql: ${TABLE}.custom_card_visa ;;
  }

  dimension: custom_validated_at {
    type: number
    sql: ${TABLE}.custom_validated_at ;;
  }

  dimension: custom_validation_retried_at {
    type: number
    sql: ${TABLE}.custom_validation_retried_at ;;
  }

  dimension: custom_booking_started_carmodel {
    type: string
    sql: ${TABLE}.custom_booking_started_carmodel ;;
  }

  dimension: custom_booking_started_date {
    type: string
    sql: ${TABLE}.custom_booking_started_date ;;
  }

  dimension: custom_booking_started_from {
    type: string
    sql: ${TABLE}.custom_booking_started_from ;;
  }

  dimension: custom_booking_started_location {
    type: string
    sql: ${TABLE}.custom_booking_started_location ;;
  }

  dimension: custom_booking_started_to {
    type: string
    sql: ${TABLE}.custom_booking_started_to ;;
  }

  dimension: custom_booking_started_energy_type {
    type: string
    sql: ${TABLE}.custom_booking_started_energy_type ;;
  }

  dimension: user_agent_data {
    type: string
    sql: ${TABLE}.user_agent_data ;;
  }

  dimension: custom_flag_good_customer {
    type: string
    sql: ${TABLE}.custom_flag_good_customer ;;
  }

  dimension: custom_paris_garage_province {
    type: string
    sql: ${TABLE}.custom_paris_garage_province ;;
  }

  dimension: custom_lyon_lyon_saint_exupery_airport {
    type: string
    sql: ${TABLE}.custom_lyon_lyon_saint_exupery_airport ;;
  }

  dimension: custom_paris_carossa {
    type: string
    sql: ${TABLE}.custom_paris_carossa ;;
  }

  dimension: custom_paris_gare_du_nord {
    type: string
    sql: ${TABLE}.custom_paris_gare_du_nord ;;
  }

  dimension: custom_paris_virtuo_hq {
    type: string
    sql: ${TABLE}.custom_paris_virtuo_hq ;;
  }

  dimension: custom_orly_aeroport_paris_orly {
    type: string
    sql: ${TABLE}.custom_orly_aeroport_paris_orly ;;
  }

  dimension: custom_nice_aeroport_de_nice {
    type: string
    sql: ${TABLE}.custom_nice_aeroport_de_nice ;;
  }

  dimension: custom_london_waterloo_station {
    type: string
    sql: ${TABLE}.custom_london_waterloo_station ;;
  }

  dimension: custom_lyon_gare_lyon_part_dieu {
    type: string
    sql: ${TABLE}.custom_lyon_gare_lyon_part_dieu ;;
  }

  dimension: custom_lyon_lyon_perrache_train_station {
    type: string
    sql: ${TABLE}.custom_lyon_lyon_perrache_train_station ;;
  }

  dimension: custom_paris_place_de_la_madeleine {
    type: string
    sql: ${TABLE}.custom_paris_place_de_la_madeleine ;;
  }

  dimension: custom_blagnac_toulouse_blagnac_airport {
    type: string
    sql: ${TABLE}.custom_blagnac_toulouse_blagnac_airport ;;
  }

  dimension: custom_lille_lilles_gares_europe_flandres {
    type: string
    sql: ${TABLE}.custom_lille_lilles_gares_europe_flandres ;;
  }

  dimension: custom_blagnac_hotel_ibis_blagnac {
    type: string
    sql: ${TABLE}.custom_blagnac_hotel_ibis_blagnac ;;
  }

  dimension: custom_paris_como {
    type: string
    sql: ${TABLE}.custom_paris_como ;;
  }

  dimension: custom_avignon_avignon_gare_tgv {
    type: string
    sql: ${TABLE}.custom_avignon_avignon_gare_tgv ;;
  }

  dimension: custom_heaven {
    type: string
    sql: ${TABLE}.custom_heaven ;;
  }

  dimension: custom_saint_fons_mercedes_st_fons {
    type: string
    sql: ${TABLE}.custom_saint_fons_mercedes_st_fons ;;
  }

  dimension: custom_boulogne_billancourt_como_boulogne {
    type: string
    sql: ${TABLE}.custom_boulogne_billancourt_como_boulogne ;;
  }

  dimension: custom_boulogne_billancourt_boulogne_billancourt {
    type: string
    sql: ${TABLE}.custom_boulogne_billancourt_boulogne_billancourt ;;
  }

  dimension: custom_bruxelles_bruxelles_midi_station {
    type: string
    sql: ${TABLE}.custom_bruxelles_bruxelles_midi_station ;;
  }

  dimension: custom_roissy_en_france_hotel_novotel_convention_spa_roissy_cdg {
    type: string
    sql: ${TABLE}.custom_roissy_en_france_hotel_novotel_convention_spa_roissy_cdg ;;
  }

  dimension: custom_zaventem_brussels_airport {
    type: string
    sql: ${TABLE}.custom_zaventem_brussels_airport ;;
  }

  dimension: custom_london_kings_cross_saint_pancras_train_station {
    type: string
    sql: ${TABLE}.custom_london_kings_cross_saint_pancras_train_station ;;
  }

  dimension: custom_london_kensington_high_st {
    type: string
    sql: ${TABLE}.custom_london_kensington_high_st ;;
  }

  dimension: custom_paris_gare_de_lyon {
    type: string
    sql: ${TABLE}.custom_paris_gare_de_lyon ;;
  }

  dimension: custom_paris_gare_montparnasse {
    type: string
    sql: ${TABLE}.custom_paris_gare_montparnasse ;;
  }

  dimension: custom_neuilly_sur_seine_neuilly_porte_maillot {
    type: string
    sql: ${TABLE}.custom_neuilly_sur_seine_neuilly_porte_maillot ;;
  }

  dimension: custom_aix_en_provence_aix_en_provence_gare_tgv {
    type: string
    sql: ${TABLE}.custom_aix_en_provence_aix_en_provence_gare_tgv ;;
  }

  dimension: custom_london_victoria_station {
    type: string
    sql: ${TABLE}.custom_london_victoria_station ;;
  }

  dimension: custom_paris_place_d_italie {
    type: string
    sql: ${TABLE}.custom_paris_place_d_italie ;;
  }

  dimension: custom_roissy_aeroport_roissy_cdg {
    type: string
    sql: ${TABLE}.custom_roissy_aeroport_roissy_cdg ;;
  }

  dimension: custom_bordeaux_bordeaux_saint_jean_train_station {
    type: string
    sql: ${TABLE}.custom_bordeaux_bordeaux_saint_jean_train_station ;;
  }

  dimension: custom_paris_champs_elysees {
    type: string
    sql: ${TABLE}.custom_paris_champs_elysees ;;
  }

  dimension: custom_london_marble_arch {
    type: string
    sql: ${TABLE}.custom_london_marble_arch ;;
  }

  dimension: custom_undefined {
    type: string
    sql: ${TABLE}.custom_undefined ;;
  }

  dimension: custom_london_uk_heaven {
    type: string
    sql: ${TABLE}.custom_london_uk_heaven ;;
  }

  dimension: custom_london_stratford_int {
    type: string
    sql: ${TABLE}.custom_london_stratford_int ;;
  }

  dimension: custom_london_x_uk_repair {
    type: string
    sql: ${TABLE}.custom_london_x_uk_repair ;;
  }

  dimension: custom_london_y_uk_other {
    type: string
    sql: ${TABLE}.custom_london_y_uk_other ;;
  }

  dimension: custom_last_search_booking_start_date {
    type: number
    sql: ${TABLE}.custom_last_search_booking_start_date ;;
  }

  dimension: custom_last_search_booking_end_date {
    type: number
    sql: ${TABLE}.custom_last_search_booking_end_date ;;
  }

  dimension: custom_last_search_booking_fail_end_date {
    type: number
    sql: ${TABLE}.custom_last_search_booking_fail_end_date ;;
  }

  dimension: custom_last_search_booking_fail_start_date {
    type: number
    sql: ${TABLE}.custom_last_search_booking_fail_start_date ;;
  }

  dimension: custom_booking_ended_to {
    type: string
    sql: ${TABLE}.custom_booking_ended_to ;;
  }

  dimension: custom_booking_ended_carmodel {
    type: string
    sql: ${TABLE}.custom_booking_ended_carmodel ;;
  }

  dimension: custom_booking_confirmed_add_driver_active {
    type: string
    sql: ${TABLE}.custom_booking_confirmed_add_driver_active ;;
  }

  dimension: custom_booking_ended_rating {
    type: number
    sql: ${TABLE}.custom_booking_ended_rating ;;
  }

  dimension: custom_booking_ended_location {
    type: string
    sql: ${TABLE}.custom_booking_ended_location ;;
  }

  dimension: custom_booking_ended_from {
    type: string
    sql: ${TABLE}.custom_booking_ended_from ;;
  }

  dimension: custom_booking_ended_date {
    type: string
    sql: ${TABLE}.custom_booking_ended_date ;;
  }

  measure: count {
    type:  count
  }


}
