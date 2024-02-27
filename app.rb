# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

['/', '/memos'].each do |path|
  get path do
    # データを取得する処理を追加
    erb :index
  end
end

get '/memos/new' do
  erb :new
end

post '/memos/create' do
  # データを保存する処理を追加
  redirect '/memos'
end
