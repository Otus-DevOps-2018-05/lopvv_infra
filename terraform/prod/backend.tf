terraform {
  backend "gcs" {
    bucket = "tf-state-prod-rnd"
    prefix = "terraform/state"
    region = "europe-west1"
  }
}
