resource "aws_s3_bucket" "web_bucket" {
  bucket = "tictactoe-web-store"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "obj_owner" {
  bucket = aws_s3_bucket.web_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "pub_access" {
  bucket = aws_s3_bucket.web_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "web_files" {
  for_each = fileset("tic_tac_toe", "**/*.html")  # Upload all files in the directory

  bucket = aws_s3_bucket.web_bucket.id
  key    = each.value
  source = "tic_tac_toe/${each.value}"
  #etag   = filemd5("path/to/local/files/${each.value}")  # Optional: ETag for versioning
  content_type = "text/html"
}

resource "aws_s3_object" "css_files" {
  for_each = fileset("tic_tac_toe", "**/*.css")  # Upload all files in the directory

  bucket = aws_s3_bucket.web_bucket.id
  key    = each.value
  source = "tic_tac_toe/${each.value}"
  #etag   = filemd5("path/to/local/files/${each.value}")  # Optional: ETag for versioning
  content_type = "text/css"
}

resource "aws_s3_object" "js_files" {
  for_each = fileset("tic_tac_toe", "**/*.js")  # Upload all files in the directory

  bucket = aws_s3_bucket.web_bucket.id
  key    = each.value
  source = "tic_tac_toe/${each.value}"
  #etag   = filemd5("path/to/local/files/${each.value}")  # Optional: ETag for versioning
  content_type = "application/javascript"
}


