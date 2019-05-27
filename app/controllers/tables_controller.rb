class TablesController < ApplicationController
  get "/tables/new" do
    erb :'tables/new'
  end

  post "/tables" do
    words = Word.parse(params[:section])
    @table = Table.create(title: params[:title], tractate: Tractate.find_by(name: params[:tractate]), words: words)
    erb :'tables/show'
  end


end
