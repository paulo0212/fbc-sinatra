# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pg'

FILE_PATH = './data/memos.json'

get '/' do
  redirect to('/memos')
end

get '/memos' do
  @memos = fetch_all
  @title = 'Memo App'
  erb :index
end

get '/memos/new' do
  @title = 'New Memo | Memo App'
  erb :new
end

post '/memos' do
  memos = read_memos(FILE_PATH)
  max_id = memos.keys.map(&:to_i).max || 0
  memos[max_id + 1] = params
  save_memos(FILE_PATH, memos)
  redirect '/memos'
end

get '/memos/:id' do
  memos = read_memos(FILE_PATH)
  @id = params[:id]
  @memo = memos[params[:id]]
  @title = "#{@memo['title']} | Memo App"
  erb :show
end

get '/memos/:id/edit' do
  memos = read_memos(FILE_PATH)
  @id = params[:id]
  @memo = memos[params[:id]]
  @title = "Edit - #{@memo['title']} | Memo App"
  erb :edit
end

patch '/memos/:id' do
  memos = read_memos(FILE_PATH)
  memos[params[:id]] = params.slice(:title, :contents)
  save_memos(FILE_PATH, memos)
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  memos = read_memos(FILE_PATH)
  memos.delete(params[:id])
  save_memos(FILE_PATH, memos)
  redirect '/memos'
end

not_found do
  erb :not_found
end

configure do
  conn.exec('CREATE TABLE IF NOT EXISTS memos (id serial PRIMARY KEY, title varchar(255), contents text)')
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def conn
  @conn ||= PG.connect(dbname: 'memo_app')
end

def fetch_all
  conn.exec('SELECT * FROM memos')
end
