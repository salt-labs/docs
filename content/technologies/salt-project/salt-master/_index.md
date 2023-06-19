---
title: Salt Master
date: 2016-04-14T00:00:00+00:00
icon: "fa-solid fa-user"
description: "Salt Master notes and resources."
type: "docs"
weight: 202
draft: false
---

## Overview

This section includes notes on configuring the Salt Master server for use with the SaltStack project.

## Example configuration

- Create all the required directories

```bash
SALT_HOME="/srv"
declare -a ENVIRONMENTS=(base production staging development)

for ENVIRONMENT in ${ENVIRONMENTS[@]};
do

  mkdir -p ${SALT_HOME}/{pillar,salt}/${ENVIRONMENT}
  mkdir ${SALT_HOME}/salt/${ENVIRONMENT}/formulas

done
```

- If required, symlink to `/srv/salt`

```bash
ln -s /home/salt/srv /srv/salt
```

The following examples can be placed in `/etc/salt/master.d/`

- Primary configuration

```bash
cat << __EOF__ > /etc/salt/master.d/primary.conf
#######################################
# Name: primary.conf
# Description: Salt Master Primary configuration
#######################################

# Network interface to bind to
interface: 0.0.0.0

# Disable or Enable IPv6
ipv6: False

# The network port for the publish interface
publish_port: 4505

# Master ID
# This is used for the minion to return the job to the requesting master
master_id: None

# Salt User
# The user under which the salt master will run.
# Salt will update all permissions to allow the user to run the master.
# The exception is job cache, which must be deleted if this user is changed.
# If the modified files cause conflicts, set verify_env to False.
user: salt

# Returning Port
# The port used by the return server.
# This is used by Salt to receive execution returns and command executions
ret_port: 4506

# Location of the PID file
pidfile: /var/run/salt/salt-master.pid

# Root directory
# The default root directory to operate from
# This directory is prepended to:
# pki_dir, cachedir, sock_dir, log_file, autosign_file, autoreject_file, pidfile
root_dir: /

# Configuration file
# The path to the Salt master configuration file
conf_file: /etc/salt/master

# PKI directory
# The directory to store all the pki authentication keys
pki_dir: /etc/salt/pki/master

# Modules directory
# The directory where Salt will look for modules types:
# runners, output, wheel, modules, states, engines, utils
extension_modules: /var/cache/salt/master/extmods

# Modules Whitelist
#extmod_whitelist:

# Modules Blacklist
#extmod_blacklist:

# Cache directory
cachedir: /var/cache/salt/master

# Verify Environment
# Enable to verify and set permissions on master startup
verify_env: True

# Keep Jobs
# The number of hours to keep old job information
keep_jobs: 24

# Gather Jobs timeout
# The number of seconds to wait when the client is requesting info about running jobs
gather_job_timeout: 30

# Timeout
# The time in seconds for the Salt command and API
timeout: 10

# Loop interval
# The time in seconds the master's maintenance process runs.
loop_interval: 60

# Output
# The default outputter used by the salt command
output: nested

# Show Timeout
# Tell the client to show minions that have reached the timeout
show_timeout: True

# Show Job ID
# Tell the client to show the Job ID when a job is published
show_jid: False

# Colour
# Use colour on the output
color: True

# Summary
# Enable to show a summary of the minions targeted and returned
cli_summary: True

# Socket directory
# The location for the Salt socket
sock_dir: /var/run/salt/master

# Enable GPU Grains
# Uses lspci/dmidecode during startup, so can slow master start
enable_gpu_grains: True

__EOF__
```

- Performance configuration

```bash
cat << __EOF__ > /etc/salt/master.d/performance.conf
#######################################
# Name: performance.conf
# Description: Salt Master Performance configuration
#######################################

# Max open files
# By default this value will be the one of `ulimit -Hn`, ie, the hard limit for
# max open files.
# If you wish to set a different value than the default one, uncomment and
# configure this setting. Remember that this value CANNOT be higher than the
# hard limit. Raising the hard limit depends on your OS and/or distribution,
# a good way to find the limit is to search the internet.
max_open_files: 10000

# The number of worker threads to start. These threads are used to manage
# return calls made from minions to the master. If the master seems to be
# running slowly, increase the number of threads. This setting can not be
# set lower than 3.
worker_threads: 5

# Use Job Cache
# Can be an I/O burden for 5000+ minions
job_cache: True

# Minion Data Cache
# A cache of information about the minions connected to the master
minion_data_cache: True

# Cache sub-system
# Which sub-system to use for the Minion data cache
cache: localfs

# Memcache Expiry Time
# The amount of time before the memory cache of minion data is cleared
memcache_expire_seconds: 30

# Memcache Max Items
# The maximum number of items that are stored in the Memcache
memcache_max_items: 1024

# Memcache Full Cleanup
# If the max items is exceed, delete the entire Memcache
memcache_full_cleanup: False

# Memcache Debug
# Enable collecting Memcache logging at a Debug level
memcache_debug: False

# Default Minion Returner
# Used to specify a default returner for all minions.
# Example include, redis, consul, slack
# Enabling this also disables the job cache on the master
ext_job_cache: ''

# Event Returner
# Specify the returner(s) to use to log events.
#event_return:
#  - syslog
#  - elasticsearch
#  - slack
event_return: ''

# Event Return Queue
# On bust systems, enable event returns can cause high load
# Events can be queued on the master
event_return_queue: 0

# Event Return Whitelist
#event_return_whitelist:
#  - salt/master/tag
#  - salt/run/*/ret

# Event Return Blacklist
#event_return_blacklist:
#  - salt/master/not_this_tag
#  - salt/wheel/*/ret

# Maximum Event Size
# Parsing large events causes the minion to consume memory.
# Set the Max Size of a single event on the bus in bytes
# 1MB
max_event_size: 1000000

# Ping on Key Rotation
# By default, AES keys rotate every 24 hours
# Enable this to have the master ping after each rotation
# This can mitigate minions appearing to not respond after a rotation
# WARNING: This will cause a performance spike for a high number of minions (5000+)
ping_on_rotate: True

# Master Job Cache
# Specify the returner to be used by the Master for the job cache.
master_job_cache: local_cache

# Enforce Mine Cache
# When the minion_data_cache is disabled, so is the Mine cache.
# Enable this for override
enforce_minion_cache: False

# Maximum Minions
# The max number of Minions allowed to connect to the Master
max_minions: 0

# Connection Cache
# If max_minions is used, cache the connection Minion IDs
con_cache: True

# Presence Events
# Enable to have the Master periodically check for connected Minions.
presence_events: False

# Transport
# Changes the underlying transport layer
# Valid options are: zeromq, raet(experimental), tcp(experimental)
transport: zeromq

# Socket Pool Size
# Increase if using the Salt API, default is 1
sock_pool_size: 1

# IPC Mode
# The IPC strategy, sockets vs tcp
# Set to tcp on Windows, ipc on Linux
ipc_mode: ipc

# TCP Master Publisher Port
# The TCP port on which events should be published if ipc_mode is TCP
tcp_master_pub_port: 4512

# TCP Master Pull Port
# The TCP port on which events for the master should be pulled if ipc_mode is TCP.
tcp_master_pull_port: 4513

# TCP Master Publish Pull Port
# The TCP port on which events for the master should be pulled from
# and then republished onto the event bus on the master.
tcp_master_publish_pull: 4514

# TCP Master Workers
# The TCP port for mworkers to connect to on the Master.
tcp_master_workers: 4515

# ZeroMQ Backlog
# The listen queue size of the ZeroMQ backlog
zmq_backlog: 1000

__EOF__
```

- Salt-SSH configuration

```bash
cat << __EOF__ > /etc/salt/master.d/salt-ssh.conf
#######################################
# Name: salt-ssh.conf
# Description: Salt Master Salt-SSH configuration
#######################################

# Roster File location
roster_file: /etc/salt/roster

# The SSH Password
ssh_passwd: ''

# The SSH Port
ssh_port: 22

# SSH Scan Ports
# Comma separated list of ports to scan for SSH servers
ssh_scan_ports: 22

# SSH Scan Timeout
ssh_scan_timeout: 0.05

# SSH Sudo
# Boolean to run ssh command via sudo
ssh_sudo: False

# SSH Timeout
# Number of seconds to wait for response when establishing SSH connection
ssh_timeout: 60

# SSH User
# Default user to login over SSH
ssh_user: root

# SSH Log File
ssh_log_file: /var/log/salt/ssh

# SSH Minion Options
# Pass in minion option overrides that will be inserted into the SHIM for salt-ssh calls
#ssh_minion_opts:
#  gpg_keydir: /root/gpg

# SSH Use Home Key
# Enable this to automatically use ~/.ssh/id_rsa for authentication with minions
ssh_use_home_key: False

# SSH Identities only
# Enable to have salt-ssh run with -o IdentitiesOnly=yes
ssh_identities_only: False

# SSH Nodegroups
# Define Nodegroups as a YAML list
#ssh_list_nodegroups:
#  - groupA:
#    - minion1
#    - minion2
#  - groupB:
#    - minion3
#    - minion4

__EOF__
```

- Security configuration

```bash
cat << __EOF__ > /etc/salt/master.d/security.conf
#######################################
# Name: security.conf
# Description: Salt Master Security configuration
#######################################

# Enable "open mode", this mode still maintains encryption, but turns off
# authentication, this is only intended for highly secure environments or for
# the situation where your keys end up in a bad state. If you run in open mode
# you do so at your own risk!
open_mode: True

# Enable auto_accept, this setting will automatically accept all incoming
# public keys from the minions. Note that this is insecure.
auto_accept: True

# The size of key that should be generated when creating new keys.
keysize: 4096

# Auto Sign Timeout
# The time in minutes that a matching keyid is automatically accepted.
# Expired keys are removed when the master checks the minion _autosign dir
autosign_timeout: 180

# Allow users on the master access to execute specific commands on minions.
# This setting should be treated with care since it opens up execution
# capabilities to non root users. By default this capability is completely
# disabled. Groups end with percent.
publisher_acl:
  # Salt Admins can do everything
  salt-admins%:
    - .*
  # Salt Users can use test,pkg module on everything
  salt-users%:
    - .*
      - test.*
      - pkg.*

# Sudo ACL
# Enforce the publisher_acl when users have access to sudo
sudo_acl: False

# External Authentication
# pam:
#  salt-users:
#    - test.*

# Token Expiry
# Time in seconds for a newly generated token to live
token_expire: 43200

# File Receive
# Allow Minions to be able to push files to the Master
file_recv: False

# File Receive Max Size
# Megabytes
file_revc_max_size: 100

# Master Sign Public Key
# Sign the auth-replies with the signature of the masters pub key
master_sign_pubkey: False

# Master Sign Key Name
# The customisable name of the signing-key-pair
master_sign_key_name: master_sign

# Master Public Key Signature
# The name of the file holding the master's public key
master_pubkey_signature: master_pubkey_signature

# Master Use Pub Key Signature
# Instead of computing a signature for each reply, use a pre-computed
master_use_pubkey_signature: False

# Rotate AES Keys
# Automatically rotate the AES key when a minion is deleted with salt-key
# If you disable, a deleted minion can listen to the zeromq messages
rotate_aes_key: True

# Publish Session
# The number of seconds between automatic AES key rotation
publish_session: 86400

# Allow Minion Key revocation
# The Master deletes the cache for a minion when a minion is removed
# Enable this to preserve the cache
preserve_minion_cache: False

# Rotate AES Key
# Controls whether a Minion can request its own key to be revoked
allow_minion_key_revoke: True

__EOF__
```

- State configuration

```bash
cat << __EOF__ > /etc/salt/master.d/state.conf
#######################################
# Name: state.conf
# Description: Salt Master State configuration
#######################################

# State Top
# The name the minions will look for the top file
state_top: top.sls

# State Top Salt Environment
# This option has no default
# Set it to ensure that ONLY the top file from this environment is considered
state_top_saltenv: base

# Fail Hard
# Enabling this causes all states to stop running the moment a single state fails
failhard: True

# State Verbose
# Enable this to see output from all states during a run
# Disable to only see changes and failed states
state_verbose: False

# State Output
# Changes the output from a state run. Options are
# Full: Full details from every state
# Terse:  Single line from every state
# Mixed: Single line unless state failed, otherwise full
# Changes: Output will be full is there was changes
state_output: changes

# State Output Diff
# Whether or not output from successful states is returned
# Set to True to ignore  successful output
state_output_diff: False

# State Aggregate
# Automatically aggregate all states that have support for mod_aggregate.
# Alternatively, pass a list of state modules to only aggregate those types.
state_aggregate: True

# Runner Returns
# Enable if you want runner jobs saved to the cache
runner_returns: False

__EOF__
```

- Fileserver configuration

```bash
cat << __EOF__ > /etc/salt/master.d/fileserver.conf
#######################################
# Name: fileserver.conf
# Description: Salt Master FileServer configuration
#######################################

# File Server Backends
#
# Multiple backends can be configured and will be searched for the requested file
# in the order in which they are defined here.
# The default setting only enables the standard backend
# * "roots" uses the "file_roots" option
# * "git" uses the "GitFS" option
fileserver_backend:
- roots
- git

# Fileserver Follow Symlinks
fileserver_followsymlinks: True

# Fileserver Ignore Symlinks
# Disable to have symlinks treated as the file they are pointing too
fileserver_ignoresymlinks: False

# Fileserver Limit Traversal
# Enable to only traverse directories with SLS and special Salt directories
fileserver_limit_traversal: False

# Fileserver List Cache Time
# The time in seconds that Salt will cache a list of files for
fileserver_list_cache_time: 30

# Fileserver Verify Configuration
# Salt Master will verify configuration on start and abort if error
fileserver_verify_config: True

# Hash Type
# The hash type to use on tole
hash_type: sha256

# File Buffer Size (bytes)
file_buffer_size: 1048576

# File Ignore Regex
# A regular expression (or a list of expressions) that will be matched
# against the file path before syncing the modules and states to the minions.
# This includes files affected by the file.recurse state.
file_ignore_regex:
- '/\.svn($|/)'
- '/\.git($|/)'
- '/\.pyc($|/)'

# File Ignore Glob
# A file glob (or list of file globs) that will be matched against the file
# path before syncing the modules and states to the minions. This is similar
# to file_ignore_regex above, but works on globs instead of regex. By default
# nothing is ignored.
file_ignore_glob:
- '\*.pyc'
- '\*.bak'
- '\*.swp'

# For each environment:
#   * apply the top.sls
#   * if top.sls doesn't exist, apply the "default_top" top.sls
# On a Minion, "default_top" defaults to "base"
top_file_merging_strategy: same

# Default Minion renderer
renderer: yaml_jinja

# Master Root
# A master only copy of the file_roots, used by the state compiler
master_roots: /srv/salt/salt-master

# The file server works on environments passed to the master, each environment
# can have multiple root directories, the subdirectories in the multiple file
# roots cannot match, otherwise the downloaded files will not be able to be
# reliably ensured. A base environment is required to house the top file.
# Each Environment will:
#   * Check the associated environment directory first
#   * If a file is not found, DO NOT default to the base
file_roots:

# Base Environment
base:
  - /srv/salt/base

# Development Environment
development:
  - /srv/salt/development

# Staging Environment
staging:
  - /srv/salt/staging

# Production Environment
production:
  - /srv/salt/production

__EOF__
```

- GitFS configuration

```bash
cat << __EOF__ > /etc/salt/master.d/gitfs.conf
#######################################
# Name: gitfs.conf
# Description: Salt Master GitFS configuration
#######################################

# NOTE: A good way of testing what is being served from repos on salt
# salt '*' cp.list_master
# salt '*' cp.list_master_dirs

# GitFS Provider
# If unset, both pygit2 and gitpython will be tried in that order.
#gitfs_provider: gitpython

# GitFS SSL Verify
# Specifies whether to verify SSL certificates
gitfs_ssl_verify: True

# GitFS Global Lock
# When set to true, salt will flag a warning when an update lock present
# When set to false, salt will clear the lock and a new lock obtained
gitfs_global_lock: True

/ # The branch/tag to be used for base environment
gitfs_base: base

# The default mountpoint for repositories
gitfs_mountpoint: ''

# The relative path to a subdirectory in a git repository for salt to serve files
gitfs_root: ''

# GitFS defaults for environments
# These can be overridden per repo
gitfs_saltenv:

# Base Environment
- base:
  - ref: base

# Production Environment
- production:
  - ref: production

# Staging Environment
- staging:
  - ref: staging

# Development Environment
- development:
  - ref: development

# Repository specific settings
gitfs_remotes:

# Repo used by all environments
- https://gitlab.com/SaltWorks/Salt:
  - name: salt_top
  - root: salt
  - mountpoint: salt://

# Example of the same repo with the base env re-mapped.
- https://gitlab.com/SaltWorks/Salt:
  - name: salt_grains
  - base: development
  - root: salt
  - mountpoint: salt://

# HAProxy Formula:
- https://gitlab.com/SaltWorks/Salt-Formulas/HAProxy-Formula.git:
  - root: haproxy
  - mountpoint: salt://formulas/haproxy

__EOF__
```

- Pillar configuration

```bash
cat << __EOF__ > /etc/salt/master.d/pillar.conf
#######################################
# Name: pillar.conf
# Description: Salt Master Pillar configuration
#######################################

# Salt Pillars allow for the building of global data that can be made selectively
# available to different minions based on minion grain filtering. The Salt
# Pillar is laid out in the same fashion as the file server, with environments,
# a top file and sls files. However, pillar data does not need to be in the
# highstate format, and is generally just key/value pairs.
# NOTE: Pillar root must not be in a subdirectory of the state tree
pillar_roots:

  # Base Environment
  base:
    - /srv/pillar/base

  # Development Environment
  development:
    - /srv/pillar/development

  # Staging Environment
  staging:
    - /srv/pillar/staging

  # Production Environment
  production:
    - /srv/pillar/production

# The pillar_opts option adds the master configuration file data to a dict in
# the pillar called "master". This is used to set simple configurations in the
# master config file that can then be used on minions.
pillar_opts: False

# Enable to prevent pillar errors from being pushed to minions. These errors
# could allow a minion to ger information it shouldn't have, e.g a password.
pillar_safe_render_error: True

# External Pillar First
# Enable to have the external pillars processed before pillar_roots
ext_pillar_first: False

# Pillar Environment from Salt Environment
# Enable this to have the Pillar environment assume the the Salt Environment
# when running states.
pillar_env_from_saltenv: True

# Pillar raise on missing
# Enable to raise a KeyError when an attempt to retrieve a named value from a pillar fails.
# Disable to return an empty string on error
pillar_raise_on_missing: False

# Git Pillar Provider (pygit2, gitpython)
git_pillar_provider: pygit2

# Git Pillar Ref
# The branch/tag to be used for base environment
git_pillar_base: base

# Git Pillar Root
# Default location of the repositories for the top.sls
git_pillar_root: pillar

# Git Pillar Branch
# If the branch is omitted, default to this
git_pillar_branch: master

# Git Pillar SSL Verify
# Whether to ignore SSL certificate errors when connecting to the repo
git_pillar_ssl_verify: True

# Git Pillar Global Lock
# When set to true, salt will flag a warning when an update lock present
# When set to false, salt will clear the lock and a new lock obtained
git_pillar_global_lock: True

# Git Pillar Includes
# Enable to allow one Git pillar to access files for another pillar
# in the same environment.
git_pillar_includes: True

# Git Pillar Verify Config
# Verify the Git Pillar configuration on master start
# Salt master will abort on error
git_pillar_verify_config: True

# Pillar Source Merging Strategy
# None: only parse the pillar from the environment, or base if no environment specified
# Recurse: Recursively merge pillar data
# Smart: Guess the best strategy based on the renderer
pillar_source_merging_strategy: none

# Pillar Cache
# A master can cache pillars locally bypassing the expense of having to render the pillar
pillar_cache: false

# Pillar Cache TTL
# The amount of time before the cache is considered invalid and a fresh pillar is recompiled
pillar_cache_ttl: 3600

# Pillar Cache Backend
# Disk: Store the pillars unncrypted in the master cache
# Memory: Experimental backend that stores the pillar cache unencrypted in memory
pillar_cache_backend: disk

# NOTE: Each environment needs it's own top.sls. This is different to the pillar_roots

ext_pillar:
  - git:
    - __env__ https://gitlab.com/SaltWorks/Pillar.git:
      - root: pillar

__EOF__
```

- Reactor configuration

```bash
cat << __EOF__ > /etc/salt/master.d/reactor.conf

#######################################
# Name: reactor.conf
# Description: Salt Master Reactor configuration
#######################################

reactor:

# React when the Minion starts
- 'salt/minion/*/start':
  - salt://reactor/minion_start.sls
  - salt://reactor/sync_grains.sls

# React when a Cloud is destroyed
- 'salt/cloud/*/destroyed':
  - salt://reactor/cloud_destroyed.sls

# React to a Custom event
- 'custom/event/tag':
  - salt://reactor/custom_event.sls

# Reactor Refresh Interval
reactor_refresh_interval: 60

# Reactor Worker Threads
reactor_worker_threads: 10

# Reactor Worked HWM
# The Queue size for the workers in the reactor
reactor_worker_hwm: 10000

__EOF__
```

- Syncdic configuration

```bash
cat << __EOF > /etc/salt/master.d/syncdic.conf
########################################
# Name: syncdic.conf
# Description: Salt Master Syncdic configuration
#######################################

# Order Masters
# If this is a master that will have syncdic slaves, set True
order_masters: False

__EOF__
```

- Logging configuration

```bash
cat << __EOF > /etc/salt/master.d/logging.conf

#######################################
# Name: logging.conf
# Description: Salt Master Logging configuration
#######################################

# The location of the master log file
# The master log can be sent to a regular file, local path name, or network
# location. Remote logging works best when configured to use rsyslogd(8) (e.g.:
# ``file:///dev/log``), with rsyslogd(8) configured for network logging. The URI
# format is: <file|udp|tcp>://<host|socketpath>:<port-if-required>/<log-facility>
#log_file: /var/log/salt/master
#log_file: file:///dev/log
#log_file: udp://loghost:10514

log_file: /var/log/salt/master
key_logfile: /var/log/salt/key

# The level of messages to send to the console.
# One of 'garbage', 'trace', 'debug', info', 'warning', 'error', 'critical'.
#
# The following log levels are considered INSECURE and may log sensitive data:
# ['garbage', 'trace', 'debug']
#
log_level: warning

# The level of messages to send to the log file.
# One of 'garbage', 'trace', 'debug', info', 'warning', 'error', 'critical'.
# If using 'log_granular_levels' this must be set to the highest desired level.
log_level_logfile: warning

__EOF__
```

- Salt-Cloud configuration

```bash

cat << __EOF__ > /etc/salt/master.d/salt-cloud.conf
#######################################
# Name: salt-cloud.conf
# Description: Salt Master Salt-Cloud configuration
#######################################

# User Data Template
# The rendered to use for templating userdata in salt-cloud
userdata_template: jinja

__EOF__
```
