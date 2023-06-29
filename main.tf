resource "aws_sagemaker_domain" "example" {
  domain_name = var.domain_name
  auth_mode   = var.auth_mode
  vpc_id      = var.vpc_id
  subnet_ids  = [aws_subnet.main.id]

  default_user_settings {
    execution_role = aws_iam_role.role21.arn
  }
}
resource "aws_iam_role" "role21" {
  name = var.iam_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_sagemaker_app" "example" {
  domain_id         = aws_sagemaker_domain.example.id
  user_profile_name = aws_sagemaker_user_profile.example.user_profile_name
  app_name          = var.app_name
  app_type          = var.app_type
}
resource "aws_sagemaker_user_profile" "example" {
  domain_id         = aws_sagemaker_domain.example.id
  user_profile_name = var.user_profile_name
}
resource "aws_sagemaker_app_image_config" "test" {
  app_image_config_name = var.app_image_config_name

  kernel_gateway_image_config {
    kernel_spec {
      name = var.kernel_name
    }
  }
}
resource "aws_sagemaker_studio_lifecycle_config" "example" {
  studio_lifecycle_config_name     = var.studio_lifecycle_config_name
  studio_lifecycle_config_app_type = var.studio_lifecycle_config_app_type
  studio_lifecycle_config_content  = var.studio_lifecycle_config_content
}
resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "lc" {
  name      = var.notebook_instane_name
  on_create = var.on_create
  on_start  = var.on_start
}

resource "aws_sagemaker_code_repository" "example" {
  code_repository_name = var.code_repository_name

  git_config {
    repository_url = var.repository_url
  }
}
resource "aws_sagemaker_notebook_instance" "ni" {
  name                    = var.name
  role_arn                = aws_iam_role.role21.arn
  instance_type           = var.instance_type
  default_code_repository = aws_sagemaker_code_repository.example.code_repository_name

  tags = {
    Name = "demo"
  }
  depends_on = [
    aws_iam_role.role21
  ]
}

resource "aws_sagemaker_model" "example" {
  name               = var.model_name
  execution_role_arn = aws_iam_role.role21.arn

  primary_container {
    image = data.aws_sagemaker_prebuilt_ecr_image.test.registry_path
  }
  depends_on = [
    aws_iam_role.role21
  ]
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

data "aws_sagemaker_prebuilt_ecr_image" "test" {
  repository_name = var.repository_name
}

resource "aws_sagemaker_model_package_group" "example" {
  model_package_group_name = var.model_package_group_name
}

resource "aws_sagemaker_endpoint_configuration" "endpoint_configuration" {
  name = var.endpoint_config_name

  production_variants {
    variant_name           = var.variant_name
    model_name             = aws_sagemaker_model.example.name
    initial_instance_count = 1
    instance_type          = var.instance_type
  }

  tags = {
    Name = "demo"
  }
}

resource "aws_sagemaker_endpoint" "endpoint" {
  name                 = var.endpoint_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.endpoint_configuration.name

  tags = {
    Name = "demo"
  }
}

resource "aws_sagemaker_device" "example" {
  device_fleet_name = aws_sagemaker_device_fleet.example.device_fleet_name

  device {
    device_name = var.device_name
  }
}

resource "aws_sagemaker_device_fleet" "example" {
  device_fleet_name = var.device_fleet_name
  role_arn          = aws_iam_role.role21.arn
  output_config {
    s3_output_location = "s3://${aws_s3_bucket.b.bucket}/prefix/"
  }
}


resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block

  tags = {
    Name = "subnet"
  }
}

resource "aws_s3_bucket" "b" {
  bucket = var.bucket

  tags = {
    Name = "sagemaker_bucket"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.b.id

  rule {
    id     = "rule-1"
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status = "Enabled"
  }
}
 