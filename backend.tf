terraform {
  backend "gcs" {
    bucket = "mukeshbhoir199222"
    prefix = "env/dev"
   }
}
