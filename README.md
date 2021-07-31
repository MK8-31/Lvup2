# Lvup App
 
Lvup Appは習慣化を簡単にするために制作した習慣化サポートアプリです。  
小説を読んでいて、人生もRPGゲームのように成長が目に見えてわかりやすければもっとやる気が出るのでは？と思い作成しました。
レスポンシブ対応しているのでスマホからもご確認いただけます。  
  
<img width="1263" alt="スクリーンショット 2021-07-31 9 52 00" src="https://user-images.githubusercontent.com/68171652/127723675-5c59c87c-70d2-4b30-9c87-ba57ad10bf91.png">
<img width="313" alt="スクリーンショット 2021-07-31 9 53 29" src="https://user-images.githubusercontent.com/68171652/127723692-80cd78ef-3cf3-4e69-b5b1-a8852f1de201.png">



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
