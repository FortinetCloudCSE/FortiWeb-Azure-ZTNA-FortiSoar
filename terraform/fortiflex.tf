### Register FAZ new VM
resource "fortiflexvm_vms_create" "register_faz"{
  config_id = 2859
  description = "Create through Terraform"
  folder_path = "My Assets/cse-ybr"
  end_date = timeadd(timestamp(), "240h")
  vm_count = 1
}
### Get next free token for FortiAnalyzer
data "fortiflexvm_groups_nexttoken" "faz_free_token" {
    config_id = fortiflexvm_vms_create.register_faz.config_id
    folder_path = fortiflexvm_vms_create.register_faz.folder_path
}