resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "${var.stage}-${var.database_id}-csql-map"
  combiner     = "OR"

  conditions {
    display_name = "CPU usage"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\" AND resource.database_id=${var.database_id}"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = "80.0"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  conditions {
    display_name = "Memory usage"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/memory/utilization\" AND resource.database_id=${var.database_id}"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = "80.0"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  conditions {
    display_name = "Connections"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/postgresql/num_backends\" AND resource.database_id=${var.database_id}"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = "200"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
}
