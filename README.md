# project-repo

オレオレプロジェクトレポジトリ


## 導入

``````
# ひな形をpull
$ git clone http://github.com/syamgot/project-repo project-name
$ cd project-name

# 設定を変更
$ vim setup.sh
----------------------------------------
BOX='ubuntu/trusty64'              # vagrantボックス名
PROJECT_NAME='syamgot-hoge'        # プロジェクト名
IP='10.0.1.110'                    # IP

# セットアップスクリプト実行
$ sh setup.sh

# 必要なレシピを指定してcook
$ cd chef-repo
$ vim nodes/project-name.json
$ knife solo cook project-name
``````


## ホストで必要なアプリとかプラグインとか

- vagrant 
	- sahara plugin
- chef
	- knife solo plugin

### vagrant

``````
$ vagrant install
$ vagrant plugin install sahara
$ chef install
$ knife solo install
``````

### chef

[Chef SDK](https://downloads.chef.io/chef-dk/)

``````
$ sudo chef gem install knife-solo
``````

### プロジェクトを閉じる

``````	
# ボックスを作ってVMを削除する
$ cd path/to/project-name/server/vagrant
$ vagrant halt
$ vagrant package
$ vagrant destory
``````

### プロジェクトを再開する

``````
# ボックスを追加する
$ cd path/to/project-name/server/vagrant
$ vagrant box add project-name package.box

# Vagrantfileのconfig.vm.boxを編集する
vi Vagrantfile
----------------------------------------
	config.vm.box = "project-name"

# 起動する
$ vagrant up --provider=virtualbox
``````


#### エラーが出たら

``````
The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

ARPCHECK=no /sbin/ifup eth1 2> /dev/null

Stdout from the command:

Device eth1 does not seem to be present, delaying initialization.


Stderr from the command:
``````

起動中に以下のエラーが出たら以下のようにする

``````
$ vagrant ssh

$ sudo ln -s -f /dev/null /etc/udev/rules.d/70-persistent-net.rules
$ exit

$ vagrant reload
``````

##### 参考

- [package化したboxを使うときによく出るエラー -- blog.10rane.com](http://blog.10rane.com/2015/08/28/errors-out-when-using-to-package-the-box/)

