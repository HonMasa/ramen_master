# Ramen-Master
就職活動用のポートフォリオとして制作した自作アプリです。
自分の食べたラーメンを他のユーザーと共有出来ます。開発環境にDocker、インフラにAWSを使用しています。
![ramen-master work_top_index](https://user-images.githubusercontent.com/54571432/91547121-680b7380-e95e-11ea-8b7e-95e46fd695ab.png)

# URL
https://ramen-master.work

# 使用技術
* Ruby 2.6.3
* Rails 6.0.3.1
* JavaScript (jQuery)
* Bootstrap
* AWS (EC2, RDS, S3, VPC, Route53, ALB, ACM)
* Docker/docker-compose
* Capistrano
* CircleCI (CI/CD)
* Nginx, Puma
* Rubocop
* RSpec
* Git, GitHub

# AWS構成図
![Untitled Diagram](https://user-images.githubusercontent.com/54571432/90956012-b2ec3d80-e4bd-11ea-8174-1a615795ab1c.jpg)

# 機能一覧
* ユーザー登録・ログイン機能（devise）
* 投稿機能(投稿詳細表示、投稿編集、投稿削除、投稿一覧表示)
* 投稿へのコメント機能
* 画像アップロード(carrierwave)
* 検索機能(ransack)
* いいね機能（Ajax）
* フォロー・フォロワー機能
* • ページネーション機能（Kaminari）
* プロフィール表示機能
* 投稿詳細画面にmapを表示