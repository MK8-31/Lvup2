# Lvup App
 
Lvup Appは習慣化を簡単にするために制作した習慣化サポートアプリです。  
小説を読んでいて、人生もRPGゲームのように成長が目に見えてわかりやすければもっとやる気が出るのでは？と思い作成しました。
レスポンシブ対応しているのでスマホからもご確認いただけます。  
  
<img width="1265" alt="スクリーンショット 2021-03-18 9 35 53" src="https://user-images.githubusercontent.com/68171652/111556252-71124400-87cd-11eb-82a8-90fb5fc6187f.png">
<img width="242" alt="スクリーンショット 2021-03-18 9 38 54" src="https://user-images.githubusercontent.com/68171652/111556444-f85fb780-87cd-11eb-82f0-291fdb65a619.png">


# URL
 
https://agile-taiga-97826.herokuapp.com
  
  
# 使用技術
 
 
* Ruby 2.6.6
* ruby on rails 6.1.3
* Nginx
* Puma
* Docker/Docker-compose
* RSpec
* jquery
* bootstrap

 
# 機能一覧
  
()内はapp/viewsにあるフォルダ名です。
* ユーザー登録、ログイン機能（users,sessions）
  * Action Mailer
  * Session機能
* 投稿(microposts)
* フォロー(relationships)
* 職業と転職(professions)
* レベルと経験値(lvpros)
  * chartkick <- グラフ機能
 
# テスト
 
* RSpec
  * 単体テスト(controllers,models,requests)
  * 統合テスト(system)

 
# 機能について

記録した時間１分を1exｐ（経験値）として100expで1レベル上がります。
