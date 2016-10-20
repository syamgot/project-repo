#!/bin/bash





BOX='ubuntu/xenial64'
PROJECT_NAME='syamgot-hoge'
IP='10.0.1.110'
MEMORY='1024'








# functions
# ----------------------------------------
log () {
	echo [`date +"%Y/%m/%d %I:%M:%S"`][$1] $2 
}



# base config
# ----------------------------------------
BASE_DIR=`pwd`
VAGRANT_PATH="$BASE_DIR/server/vagrant"
VAGRANTFILE_PATH="$VAGRANT_PATH/Vagrantfile"
CHEF_PATH="$BASE_DIR/server/chef-repo"




log 'LOG' 'init submodules'
# ----------------------------------------
git submodule update --init $CHEF_PATH



log 'LOG' 'edit vagrantfile'
# ----------------------------------------
BOX=`echo $BOX | sed -e 's/\//\\\\\//g'`
grep -l '%BOX%' $VAGRANTFILE_PATH | xargs sed -i '' -e "s/%BOX%/$BOX/g"
grep -l '%PROJECT_NAME%' $VAGRANTFILE_PATH | xargs sed -i '' -e "s/%PROJECT_NAME%/$PROJECT_NAME/g"
grep -l '%IP%' $VAGRANTFILE_PATH | xargs sed -i '' -e "s/%IP%/$IP/g"
grep -l '%MEMORY%' $VAGRANTFILE_PATH | xargs sed -i '' -e "s/%MEMORY%/$MEMORY/g"


log 'LOG' 'vagrant up'
# ----------------------------------------
cd $VAGRANT_PATH
vagrant up --provider=virtualbox
wait
status=`vagrant status`
IFS=' '
set -- $status
if [ $4 != 'running' ]; then
	log 'ERR' 'vagrant is not running'
	exit 1
fi	
vagrant ssh-config --host $PROJECT_NAME >> ~/.ssh/config
wait
vagrant sandbox on
wait



log 'LOG' 'chef solo prepare'
# ----------------------------------------
cd $CHEF_PATH
knife solo prepare $PROJECT_NAME
wait
knife solo cook $PROJECT_NAME
wait
log 'LOG' "create node file and edit it. (${CHEF_PATH}/nodes/${PROJECT_NAME}.json)"




# remove files
# cd $BASE_DIR
# rm -f LICENSE README.md
# mv .git .git.bk



log 'LOG' 'done.'
exit 0
