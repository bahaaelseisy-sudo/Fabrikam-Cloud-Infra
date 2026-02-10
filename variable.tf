variable "project" {
  type    = string
  default = "Fabricam-Project"
}

variable "location_hub" {
  type    = string
  default = "North Europe"
}

variable "location_spoke_paris" {
  type    = string
  default = "West Europe"
}

# --- باسوردات حساسة (القيم الحقيقية في الـ Library) ---
variable "sql_admin" {
  type    = string
  default = "sqladminuser"
}

variable "sql_password" {
  type      = string
  sensitive = true
  default   = "P@ssw0rd1234!" 
}

variable "cert_password" {
  type      = string
  sensitive = true
  # القيمة اللي إنت بعتها: Y0uMustFeelS@fe
}

# --- مساحات العناوين (Address Spaces) ---
variable "address_space_hub" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "vnet_spoke1_address_space" {
  type    = list(string)
  default = ["10.1.0.0/16"]
}

variable "vnet_spoke2_address_space" {
  type    = list(string)
  default = ["10.2.0.0/16"]
}

variable "vnet_onprem_address_space" {
  type    = list(string)
  default = ["10.3.0.0/16"]
}

# --- السابنتس (Subnets) ---
variable "AzureFirewallSubnet" {
  type    = list(string)
  default = ["10.0.1.0/26"]
}

variable "APP_Subnet" {
  type    = list(string)
  default = ["10.1.1.0/24"]
}

variable "DB_Subnet" {
  type    = list(string)
  default = ["10.1.2.0/24"]
}

# --- المتغيرات اللي كان فيها مشكلة في الساينتكس ---


variable "aad_client_id" {
  type      = string
}

variable "aad_client_secret" {
  type      = string
  sensitive = true
}

variable "aadb2c_client_id" {
  type      = string
}

variable "aadb2c_client_secret" {
  type      = string
  sensitive = true
}
variable "AppGW_Subnet_Prefix" {
  type    = list(string)
  default = ["10.0.2.0/24"] # مساحة جديدة في الـ Hub بعيد عن الـ Firewall
}