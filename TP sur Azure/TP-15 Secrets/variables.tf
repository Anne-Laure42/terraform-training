locals {
  resource_name = "test"
  required_tags = "${var.project}"
}

variable "location" {
    type = string
    default = "france central"
    description = "(optional) describe your variable"
}

variable "project" {
    type = map(string)
    description = "(optional) describe your variable"
    default = {
        environement = "test"
        project_name = "azure"
    }
}

variable "admin_username" {
    type = string
    description = "(optional) describe your variable"
    sensitive = true
}

variable "admin_password" {
    type = string
    description = "(optional) describe your variable"
    sensitive = true
}

variable "sql_db_name" {
    type = string
    description = "(optional) describe your variable"
    sensitive = true
}


#export TF_VAR_admin_password=""

#export TF_VAR_admin_username=""

#export TF_VAR_sql_db_name=""
