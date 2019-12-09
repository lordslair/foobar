# Copy the config entry below in your rclone configuration file.
# Use 'rclone config file' to find which configuration file rclone uses.
# You can also use 'rclone --config <file>' directly.
[OVH]
type = swift
env_auth = false
auth_version = 3
auth = https://auth.cloud.ovh.net/v3/
endpoint_type = public
tenant_domain = default
tenant = <tenant_id>
domain = default
user = <user>
key = <key>
region = <region>
storage_policy = pca
