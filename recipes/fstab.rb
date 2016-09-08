#
# Cookbook Name::       volumes
# Description::         Adds mounted volumes listed in node[:volumes] to fstab
# Recipe::              fstab
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

volumes(node).each do |vol_name, vol|
  next unless vol.mountable?

  mount(vol['mount_point']) do
    device      vol.device
    fstype      vol.fstype
    options     vol.mount_options if vol.mount_options
    dump        vol.mount_dump    if vol.mount_dump
    fsck        vol.mount_fsck    if vol.mount_fsck
    device_type vol.device_type   if vol.device_type
    action      :enable
  end

end
