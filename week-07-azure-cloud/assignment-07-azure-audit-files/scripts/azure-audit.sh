#!/bin/bash

set -u

full_name="Christian Aryee"
resource_group="Book-Review-RG"
vm_name="Book-Review-Web-VM"
storage_account="bookreviewaudit18"
mysql_server="book-review-mysql"

base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
report_dir="$base_dir/reports"
report_file="$report_dir/azure-security-report.txt"

checks=(
  check_nsg_ssh_rdp
  check_storage_public_access
  check_disk_encryption
  check_mysql_public_access
)

pass_count=0
warning_count=0
failure_count=0

mkdir -p "$report_dir"
: > "$report_file"

write_line() {
  echo "$1" | tee -a "$report_file"
}

mark_pass() {
  write_line "[PASS] $1"
  pass_count=$((pass_count + 1))
}

mark_warning() {
  write_line "[WARN] $1"
  warning_count=$((warning_count + 1))
}

mark_failure() {
  write_line "[FAIL] $1"
  failure_count=$((failure_count + 1))
}

print_header() {
  write_line "========================================"
  write_line "Azure Security Posture Audit Report"
  write_line "========================================"
  write_line "Full Name: $full_name"
  write_line "Timestamp: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  write_line "Resource Group: $resource_group"
  write_line "VM: $vm_name"
  write_line "Storage Account: $storage_account"
  write_line "MySQL Server: $mysql_server"
  write_line ""
}

check_nsg_ssh_rdp() {
  local open_rules

  open_rules=$(az network nsg list \
    --resource-group "$resource_group" \
    --output json 2>/dev/null |
    jq -r '
      .[].securityRules[]?
      | select(.direction == "Inbound" and .access == "Allow")
      | select(
          .sourceAddressPrefix == "*"
          or .sourceAddressPrefix == "Internet"
          or .sourceAddressPrefix == "0.0.0.0/0"
          or ((.sourceAddressPrefixes // []) | index("*") != null)
          or ((.sourceAddressPrefixes // []) | index("Internet") != null)
          or ((.sourceAddressPrefixes // []) | index("0.0.0.0/0") != null)
        )
      | select(
          .destinationPortRange == "22"
          or .destinationPortRange == "3389"
          or .destinationPortRange == "*"
          or ((.destinationPortRanges // []) | index("22") != null)
          or ((.destinationPortRanges // []) | index("3389") != null)
          or ((.destinationPortRanges // []) | index("*") != null)
        )
      | .name
    ' 2>/dev/null || true)

  if [ -n "$open_rules" ]
  then
    mark_failure "NSG rule(s) allow unrestricted inbound SSH/RDP access: $open_rules"
  else
    mark_pass "No NSG rule allows unrestricted inbound SSH or RDP access"
  fi
}

check_storage_public_access() {
  local public_access

  public_access=$(az storage account show \
    --resource-group "$resource_group" \
    --name "$storage_account" \
    --query "allowBlobPublicAccess" \
    --output tsv 2>/dev/null || true)

  if [ "$public_access" = "true" ]
  then
    mark_failure "Storage Account allows blob public access"

  elif [ "$public_access" = "false" ]
  then
    mark_pass "Storage Account blob public access is disabled"

  else
    mark_warning "Could not determine Storage Account public blob access setting"
  fi
}

check_disk_encryption() {
  local os_disk_name
  local encryption_type

  os_disk_name=$(az vm show \
    --resource-group "$resource_group" \
    --name "$vm_name" \
    --query "storageProfile.osDisk.name" \
    --output tsv 2>/dev/null || true)

  if [ -z "$os_disk_name" ]
  then
    mark_warning "Could not determine the VM OS disk name"
    return
  fi

  encryption_type=$(az disk show \
    --resource-group "$resource_group" \
    --name "$os_disk_name" \
    --query "encryption.type" \
    --output tsv 2>/dev/null || true)

  if [[ "$encryption_type" == EncryptionAtRest* ]]
  then
    mark_pass "VM OS managed disk is encrypted at rest ($encryption_type)"
  else
    mark_warning "Could not confirm the VM OS managed disk encryption type"
  fi
}

check_mysql_public_access() {
  local public_access

  public_access=$(az mysql flexible-server show \
    --resource-group "$resource_group" \
    --name "$mysql_server" \
    --query "network.publicNetworkAccess" \
    --output tsv 2>/dev/null || true)

  if [ "$public_access" = "Enabled" ]
  then
    mark_failure "Azure Database for MySQL has public network access enabled"

  elif [ "$public_access" = "Disabled" ]
  then
    mark_pass "Azure Database for MySQL public network access is disabled"

  else
    mark_warning "Could not determine MySQL Flexible Server public network access"
  fi
}

print_summary() {
  local overall_status
  local script_exit_code

  if [ "$failure_count" -gt 0 ]
  then
    overall_status="FAIL"
    script_exit_code=2

  elif [ "$warning_count" -gt 0 ]
  then
    overall_status="WARN"
    script_exit_code=1

  else
    overall_status="HEALTHY"
    script_exit_code=0
  fi

  write_line ""
  write_line "Summary:"
  write_line "PASS: $pass_count"
  write_line "WARN: $warning_count"
  write_line "FAIL: $failure_count"
  write_line "Overall Status: $overall_status"
  write_line "Script Exit Code: $script_exit_code"
  write_line "Report File: $report_file"

  return "$script_exit_code"
}

print_header

for check_function in "${checks[@]}"
do
  "$check_function"
done

print_summary

exit $?
