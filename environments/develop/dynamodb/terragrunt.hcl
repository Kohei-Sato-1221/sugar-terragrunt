include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/${path_relative_to_include()}"
}

dependency "s3" {
  config_path = "../s3"
}

inputs = {
  s3_bucket_name = dependency.s3.outputs.s3_bucket_name
}