variable "credentials" {
  description = "My Credentials"
  default     = "<Path to Service Account json file>"
}

variable "project" {
  description = "Project"
  default     = "<Project ID>"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "BigQuery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "Storage Bucket Name"
  default     = "terraform-demo-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}