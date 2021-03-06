# SimpleDotNetPaaS
#
# Copyright (C) 2014  Matt Mills
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see [http://www.gnu.org/licenses/].


param(
	[Parameter(Mandatory=$true)][string]$SiteName,
	[Parameter(Mandatory=$true)][string]$ServerName,
	[Parameter(Mandatory=$true)][string]$ServerAddr
)

$SiteName = $SiteName.ToLower()
$ServerName = $ServerName.ToLower()
$ServerAddr = $ServerAddr.ToLower()

. ".\Config-SSH.ps1"

$output = & "$plink_path" "$lb_addr" -i "$private_key" "/etc/haproxy/provision_server.sh '$SiteName' '$ServerName' '$ServerAddr'"
if(Select-String -InputObject $output -Pattern "PASS"){
	return $True
}else{
	return $False
}