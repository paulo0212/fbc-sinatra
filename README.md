<div id="top"></div>

# Memo App

メモを作成・編集できるシンプルなアプリです。

## 目次

- [Memo App](#memo-app)
  - [目次](#目次)
  - [環境](#環境)
  - [ディレクトリ構成](#ディレクトリ構成)
  - [アプリケーション実行手順](#アプリケーション実行手順)
    - [Gemのインストール](#gemのインストール)
    - [Sinatraアプリケーションを起動](#sinatraアプリケーションを起動)
  - [動作確認](#動作確認)

## 環境

| 言語・フレームワーク     | バージョン   |
| --------------------- | ---------- |
| Ruby                  | 3.3.0      |
| Sinatra               | 4.0.0      |

使用しているGemについては Gemfile を参照してください。

<p align="right">(<a href="#top">トップへ</a>)</p>

## ディレクトリ構成

```bash
❯ tree -a -I ".git"
.
├── .erb-lint.yml
├── .rubocop.yml
├── Gemfile
├── Gemfile.lock
├── README.md
├── app.rb
├── data
│   └── memos.json
├── public
│   └── style.css
└── views
    ├── edit.erb
    ├── index.erb
    ├── layout.erb
    ├── new.erb
    └── show.erb
```

<p align="right">(<a href="#top">トップへ</a>)</p>

## アプリケーション実行手順

### Gemのインストール

```bash
bundle install
```

### Sinatraアプリケーションを起動

```bash
bundle exec ruby app.rb
```

<p align="right">(<a href="#top">トップへ</a>)</p>

## 動作確認

- アプリケーションを起動後にブラウザで `http://localhost:4567` にアクセスしてメモ一覧画面が表示されればOKです