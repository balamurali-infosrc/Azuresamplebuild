variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}
variable "prefix"      { default = "demo-aks" }
variable "node_count"  { default = 2 }
variable "node_size"   { default = "Standard_D2s_v3" }
variable "ssh_pub_key" { default = "CUsersBalamuraliRamakrishn.sshid_rsa.pub" }
