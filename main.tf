terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      # version = ">= 1.0"
    }
  }
}

provider "mongodbatlas" {}

resource "mongodbatlas_alert_configuration" "test" {
  project_id = "YOUR-PROJECT-ID" # update with "<YOUR-PROJECT-ID>"
  event_type = "OUTSIDE_METRIC_THRESHOLD"
  enabled    = true

  notification {
    type_name     = "GROUP"
    interval_min  = 5
    delay_min     = 0
    sms_enabled   = false
    email_enabled = true
    roles         = ["GROUP_CLUSTER_MANAGER"]
  }

  matcher {
    field_name = "HOSTNAME_AND_PORT"
    operator   = "EQUALS"
    value      = "SECONDARY"
  }

  metric_threshold_config {
    metric_name = "ASSERT_REGULAR"
    operator    = "LESS_THAN"
    threshold   = 99.0
    units       = "RAW"
    mode        = "AVERAGE"
  }
}
