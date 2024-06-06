BOOTSTRAP_WORKSPACE_PATH="/tmp/orchestration_architect/0.8.0/bootstrap_workspace"
if [ -d $BOOTSTRAP_WORKSPACE_PATH ]; then
  echo "Removing $BOOTSTRAP_WORKSPACE_PATH..."
  rm -rf $BOOTSTRAP_WORKSPACE_PATH
fi
ls /tmp/orchestration_architect/0.8.0/bootstrap_workspace
(cd /root/orchestration_architect/fixtures/0.8.0/ && ansible-playbook playbooks/Meta/Setup_Environment.yml && ansible-playbook playbooks/Meta/Trigger_Bootstrap.yml -i localhost) && (cd $BOOTSTRAP_WORKSPACE_PATH && git checkout --detach && git add -A && git commit -m 'temp commit for patch diff' && git remote add diff-target /srv/git/orchestration_architect.git && git fetch diff-target && git diff 'diff-target/0.8.0-pristine' HEAD > patch.diff)

