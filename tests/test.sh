#! /bin/bash

for play in $(ls gather-facts*.yml) ; do
  ansible-playbook -i inventory "${play}"
done

