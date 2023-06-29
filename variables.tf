variable "domain_name" {
  type        = string
  description = "Name of sagemaker domain"
}
variable "auth_mode" {
  type        = string
  description = "The mode of authentication that members use to access the domain."
}
variable "vpc_id" {
  type        = string
  description = "The ID of the Amazon Virtual Private Cloud (VPC) that Studio uses for communication."
}
variable "iam_name" {
  type        = string
  description = "Iam role name"
}
variable "app_name" {
  type        = string
  description = "The name of the app."
}
variable "app_type" {
  type        = string
  description = "The type of app."
}
variable "user_profile_name" {
  type        = string
  description = "The user profile name."
}
variable "app_image_config_name" {
  type        = string
  description = "The name of the App Image Config."
}
variable "kernel_name" {
  type        = string
  description = "The name of the kernel."
}
variable "studio_lifecycle_config_name" {
  type        = string
  description = "The name of the Studio Lifecycle Configuration to create."
}
variable "studio_lifecycle_config_app_type" {
  type        = string
  description = "The App type that the Lifecycle Configuration is attached to."
}
variable "studio_lifecycle_config_content" {
  type        = string
  description = "The content of your Studio Lifecycle Configuration script."
}
variable "notebook_instane_name" {
  type        = string
  description = "The name of the notebook instance."
}
variable "on_create" {
  type        = string
  description = "A shell script (base64-encoded) that runs only once when the SageMaker Notebook Instance is created."
}
variable "on_start" {
  type        = string
  description = " A shell script (base64-encoded) that runs every time the SageMaker Notebook Instance is started including the time it's created."
}
variable "code_repository_name" {
  type        = string
  description = "The name of the Code Repository."
}
variable "repository_url" {
  type        = string
  description = "The URL where the Git repository is located."
}
variable "name" {
  type        = string
  description = "The name of the notebook instance."
}
variable "instance_type" {
  type        = string
  description = "The name of ML compute instance type."
}
variable "model_name" {
  type        = string
  description = " The name of the model."
}
variable "repository_name" {
  type        = string
  description = " Name of the repository, which is generally the algorithm or library."
}
variable "model_package_group_name" {
  type        = string
  description = " The name of the model group."
}
variable "endpoint_config_name" {
  type        = string
  description = "The name of the endpoint configuration. "
}
variable "variant_name" {
  type        = string
  description = "The name of the variant. "
}
variable "endpoint_name" {
  type        = string
  description = "The name of the endpoint."
}
variable "device_name" {
  type        = string
  description = "The name of the device."
}
variable "device_fleet_name" {
  type        = string
  description = "The name of the Device Fleet."
}
variable "cidr_block" {
  type        = string
  description = "cidr block"
}
variable "bucket" {
  type        = string
  description = "bucket name"
}
variable "region" {
  type        = string
  description = "region"
}
variable "kms_key_id" {
    type = string
    description = " The AWS Key Management Service."
}