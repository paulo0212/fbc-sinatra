# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

FILE_PATH = './data/memos.json'

['/', '/memos'].each do |path|
  get path do
    @memos = read_memos(FILE_PATH)
    erb :index
  end
end

get '/memos/new' do
  erb :new
end

post '/memos/create' do
  memos = read_memos(FILE_PATH) || {}
  max_id = memos.keys.map(&:to_i).max || 0
  memos[max_id + 1] = params
  save_memos(FILE_PATH, memos)
  redirect '/memos'
end

get '/memos/:id' do
  memos = read_memos(FILE_PATH)
  @memo = memos[params[:id]]
  erb :show
end

def read_memos(file_path)
  return nil if File.zero?(file_path)

  File.open(file_path, 'r') { |f| JSON.parse(f.read) }
end

def save_memos(file_path, memos)
  File.open(file_path, 'w') { |f| JSON.dump(memos, f) }
end
