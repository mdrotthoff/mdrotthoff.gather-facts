#! /bin/bash

if [[ -f test.log ]] ; then
  rm -f test.log
fi

echo "Execute the playbooks (check mode)"
echo "Execute the playbooks (check mode)" >> test.log
for play in $(ls gather-facts*.yml) ; do
  echo "**** Executing playbook ${play}  ****"
  echo "" >> test.log
  echo "" >> test.log
  echo "**** Executing playbook ${play} (check mode) ****" >> test.log
  echo "" >> test.log
  ansible-playbook -i inventory --check "${play}" >> test.log
done

echo "Execute the playbooks (full mode)"
echo "" >> test.log
echo "" >> test.log
echo "Execute the playbooks (full mode)" >> test.log
for play in $(ls gather-facts*.yml) ; do
  echo "**** Executing playbook ${play} ****"
  rm -rf facts > /dev/null 2>&1
  echo "" >> test.log
  echo "" >> test.log
  echo "**** Executing playbook ${play} (full mode) ****" >> test.log
  echo "" >> test.log
  ansible-playbook -i inventory "${play}" >> test.log
  echo "" >> test.log
  echo "**** Resulting directory tree ****" >> test.log
  tree facts >> test.log
  echo "" >> test.log
  ls -laR facts >> test.log
done

