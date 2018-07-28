terraform {
  backend "gcs" {
    bucket = "tf-state-stage-rnd"
    prefix = "terraform/state"
    region = "europe-west1"
  }
}
