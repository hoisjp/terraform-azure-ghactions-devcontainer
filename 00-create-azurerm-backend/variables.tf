variable "location" {
  type        = string
  description = "Azure location of terraform server environment"
  default     = "japaneast"
}

variable "backend_storage_account_name" {
  type        = string
  description = "Storage account name for terraform backend"
  # default     = "tfstatehoisjp" # replace by yours
}