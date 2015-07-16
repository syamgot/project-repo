#!/bin/bash

log () {
  echo [`date +"%Y/%m/%d %I:%M:%S"`] $1 
}





BOX='ubuntu/trusty64'
PROJECT_NAME='syamgot-hoge'
IP='10.0.1.110'




# base config
BASE_DIR=`pwd`
VAGRANT_PATH="$BASE_DIR/server/vagrant"
VAGRANTFILE_PATH="$VAGRANT_PATH/Vagrantfile"
CHEF_PATH="$BASE_DIR/server/chef-repo"



log 'init submodules'
# ----------------------------------------
git submodule update --init $CHEF_PATH



log 'edit vagrantfile'
# ----------------------------------------
grep -l '%BOX%' $VAGRANTFILE_PATH | xargs sed -i '' -e "s/%BOX%/$BOX/g"
grep -l '%PROJECT_NAME%' $VAGRANTFILE_PATH | xargs sed -i '' -e "s/%PROJECT_NAME%/$PROJECT_NAME/g"
grep -l '%IP%' $VAGRANTFILE_PATH | xargs sed -i '' -e "s/%IP%/$IP/g"



log 'vagrant up'
# ----------------------------------------
cd $VAGRANT_PATH
vagrant up --provider=virtualbox
vagrant ssh-config --host $PROJECT_NAME >> ~/.ssh/config



log 'chef solo prepare'
log "create node file and edit it. (${CHEF_PATH}/nodes/${PROJECT_NAME}.json)"
# ----------------------------------------
cd $CHEF_PATH
knife solo prepare $PROJECT_NAME



# remove files
# cd $BASE_DIR
# rm -f LICENSE README.md
# mv .git .git.bk


