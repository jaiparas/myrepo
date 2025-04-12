# Create new storage bucket in the US
# location with Standard Storage

resource "google_storage_bucket" "static" {
 name          = "mybucket"
 location      = "us-central1"
 storage_class = "STANDARD"

 uniform_bucket_level_access = true
}

# Upload a text file as an object
# to the storage bucket

resource "google_storage_bucket_object" "default" {
 name         = "sample_file.txt"
 source       = "./sample-file.txt"
 content_type = "text/plain"
 bucket       = google_storage_bucket.static.id
}
