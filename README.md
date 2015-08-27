# project-repo

オレオレプロジェクトレポジトリ


## 導入


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
	$ knife solo cook xeen-nhs

## ホストで必要なアプリとかプラグインとか

- vagrant 
	- sahara plugin
- chef
	- knife solo plugin

### インストール

	# vagrant install
	# vagrant sandbox plugin install
	# chef install
	# knife solo install


