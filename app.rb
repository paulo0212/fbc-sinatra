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
  create(params)
  redirect '/memos'
end

get '/memos/:id' do
  @memo = find(params[:id])
  @title = "#{@memo['title']} | Memo App"
  erb :show
end

get '/memos/:id/edit' do
  @memo = find(params[:id])
  @title = "Edit - #{@memo['title']} | Memo App"
  erb :edit
end

patch '/memos/:id' do
  update(params[:id], params)
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

def find(id)
  conn.exec("SELECT * FROM memos WHERE id = #{id}").tuple(0)
end

def create(params)
  conn.exec('INSERT INTO memos (title, contents) VALUES ($1, $2)', [params['title'], params['contents']])
end

def update(id, params)
  conn.exec('UPDATE memos SET title = $2, contents = $3 WHERE id = $1', [id, params['title'], params['contents']])
end
