FROM ruby:2.6.3

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /ramen_master
WORKDIR /ramen_master

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /ramen_master/Gemfile
ADD Gemfile.lock /ramen_master/Gemfile.lock

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /ramen_master

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets