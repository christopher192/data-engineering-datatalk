terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.45.0"
    }
  }
}

provider "google" {
  project = "<Project ID>"
  region  = "us-central1"
}

resource "google_storage_bucket" "data-lake-bucket" {
  name          = "<Unique Bucket Name>"
  location      = "US"

  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30
    }
  }

  force_destroy = true
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "<Unique Dataset ID>"
  project    = "<Project ID>"
  location   = "US"
}