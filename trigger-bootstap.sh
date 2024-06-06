BOOTSTRAP_WORKSPACE_PATH="/tmp/orchestration_architect/0.8.0/bootstrap_workspace"
if [ -d $BOOTSTRAP_WORKSPACE_PATH ]; then
  rm -rf $BOOTSTRAP_WORKSPACE_PATH
fi

(cd /root/orchestration_architect/fixtures/0.8.0/ && ansible-playbook playbooks/Meta/Setup_Environment.yml && ansible-playbook playbooks/Meta/Trigger_Bootstrap.yml -i localhost) && (cd $BOOTSTRAP_WORKSPACE_PATH && git remote add read /srv/git/orchestration_architect.git && git fetch && git checkout --detach && git add . && git commit -m 'temp commit for patch diff' && git diff read/0.8.0-pristine HEAD > patch.diff)

