Role Name
=========

This Ansible role generates YAML fact files for an Ansible managed host.  The type of fact files that can be generated are:

1. The host's Ansible facts
2. The Ansible variables present for the host
3. The SSH key data associated with the host
4. The host's environment variables
5. The groups present during the Ansible run

Using the established defaults, the role will output five YAML files for each host in a directory tree that looks like the following:

    facts
    ├── <domain name #1>
    │   ├── ansible-facts
    │   │   └── <fully qualified host name #1>.ansible-facts.yaml
    │   ├── environment-facts
    │   │   └── <fully qualified host name #1>.environment.yaml
    │   ├── group-facts
    │   │   └── <fully qualified host name #1>.groups.yaml
    │   ├── host-facts
    │   │   └── <fully qualified host name #1>.host-vars.yaml
    │   └── ssh-keys
    │       └── <fully qualified host name #1>.ssh-keys.yaml
    └── <domain name #2>
        ├── ansible-facts
        │   ├── <fully qualified host name #2>.ansible-facts.yaml
        │   └── <fully qualified host name #3>.ansible-facts.yaml
        ├── environment-facts
        │   ├── <fully qualified host name #2>.environment.yaml
        │   └── <fully qualified host name #3>.environment.yaml
        ├── group-facts
        │   ├── <fully qualified host name #2>.groups.yaml
        │   └── <fully qualified host name #3>.groups.yaml
        ├── host-facts
        │   ├── <fully qualified host name #2>.host-vars.yaml
        │   └── <fully qualified host name #3>.host-vars.yaml
        └── ssh-keys
            ├── <fully qualified host name #2>.ssh-keys.yaml
            └── <fully qualified host name #3>.ssh-keys.yaml

Various defaults may be over-ridden which can be used to alter the directory structure used for the output.

**Notes:**
* The SSH key facts being output look for a predefined host variable named ssh\_key\_data structured in the format being output by this role.  If it is found, any sub-variables within the definition are retained as a part of the generated output.  This allows the various parts to be over-ridden at a host level as desired.  This does **NOT** apply to the SSH key types and finger prints being output.  Those are always output based on the results of the ssh-keyscan results!

* The base output directory is calculated when the first output file is generated.  Subsequent output files will continue to use the same base output directory for the execution of the current play.

Requirements
------------

This role depends on the ssh-keyscan utility being available on the Ansible controller server.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

The following default variables are defined in defaults/main.yml.  All can be over-ridden at the user's option:

* gather\_facts\_destination

  Base output directory where the output fact files should be written.
  Default: 'facts'

* gather\_facts\_directory\_domain

  True / false value as to whether or not the output fact files should be broken up into sub-directories based on the host domain name.
  Default: true

* gather\_facts\_directory\_facts\_type

  True / false value as to whether or not the the various output files should be placed in sub-directories based on the type of fact being output.
  Default: true

* gather\_facts\_ansible\_vars\_facts

  True / false value as to whether or not the Ansible facts should be output.
  Default: true

* gather\_facts\_ssh_keys\_facts

  True / false value as to whether or not the Ansible facts should be output.
  Default: true

* gather\_facts\_host\_vars\_facts

  True / false value as to whether or not the Ansible host variables should be output.
  Default: true

* gather\_facts\_environment\_facts

  True / false value as to whether or not the host environment variables should be output.
  Default: true

* gather\_facts\_group\_facts

  True / false value as to whether or not the group informations should be output.
  Default: true

Dependencies
------------

None.

Example Playbook
----------------

At it's most basic, the role can be used with the following pattern:

    - hosts:               localhost
      become:              false
      gather_facts:        true
      roles:
      - mdrotthoff.gather-facts

Additional examples of how the role can be used can be found within the tests folders of the role source.


License
-------

BSD
