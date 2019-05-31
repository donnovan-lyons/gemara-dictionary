class TablesController < ApplicationController

  get "/tables/new" do
    if logged_in?
      erb :'tables/new'
    else
      redirect "/failure"
    end
  end

  get "/tables/:slug" do
    if logged_in?
      @table = Table.find_by_slug(params[:slug])
      erb :"/tables/show"
    else
      redirect "/failure"
    end
  end

  patch "/tables/:id" do
    if logged_in?
      @table = Table.find(params[:id])
      @table.words.each do |word|
        word.update(hebrew: params["hebrew_" + "#{word.id}"], translation_one: params["translation_one_" + "#{word.id}"], translation_two: params["translation_two_" + "#{word.id}"], translation_three: params["translation_three_" + "#{word.id}"])
      end
      redirect "/tables/:id"
    else
      redirect "/failure"
    end
  end

  get "/tables/:slug/edit" do
    if logged_in?
      @table = Table.find(params[:id])
      erb :"tables/edit"
    else
      redirect "/failure"
    end
  end

  delete "/tables/:slug" do
    table = Table.find_by_slug(params[:slug])
    table.delete_words
    table.delete
    redirect "/users/:id/tables"
  end




end
