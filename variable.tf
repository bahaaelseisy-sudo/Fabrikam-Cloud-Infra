variable "location_hub" {
  description = "the main DC region"
  type = string
  default = "North Europe"
}
variable "location_spoke_paris" {
    description = "paris region"
    type = string
    default = "West Europe"
  
}
#address spaces 
variable "address_space_hub" {
    description = "hub address space"
    type = list(string)
    default = ["10.0.0.0/16"]
}
variable "vnet_spoke1_address_space" {
    type = list(string)
    default = [ "10.1.0.0/16" ]
  
}
variable "vnet_onprem_address_space" {
    type = list(string)
    default = [ "10.3.0.0/16" ]

  
}
variable "vnet_spoke2_address_space" {
  type = list(string)
  default = [ "10.2.0.0/16" ]
}
variable "project" {
    type = string
    default = "Fabricam-Project"
  
}
variable "IdentitySubnet" {
    type = list(string)
    default = [ "10.3.1.0/24" ]


  
}
variable "AzureFirewallSubnet" {
    type = list(string) 
    default = [ "10.0.1.0/26" ] 
  
}
variable "APP_Subnet" {
    type = list(string)
    default = [ "10.1.1.0/24" ]

  
}
variable "DB_Subnet" {
    type = list(string)
    default = [ "10.1.2.0/24" ]
  
}
variable "vnet_spoke2_app_subnet" {
  default = ["10.2.1.0/24"]
}

variable "vnet_spoke2_db_subnet" {
  default = ["10.2.2.0/24"]
}
variable "sql_admin" {
  description = "اسم مدير قاعدة البيانات"
  type        = string
  default     = "sqladminuser"
}

variable "sql_password" {
  description = "كلمة مرور قاعدة البيانات"
  type        = string
  sensitive   = true # دي بتخلي التيرافورم ميظهرش الباسورد في الـ Logs
  default     = "P@ssw0rd1234!" 
}
