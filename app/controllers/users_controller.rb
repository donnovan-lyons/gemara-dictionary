class UsersController < ApplicationController

  get '/users/:id' do
    if logged_in?
			erb :'/users/index'
		else
			redirect "/failure"
		end
  end

  get "/users/:id/tables/new" do
    if logged_in?
			erb :'tables/new'
		else
			redirect "/failure"
		end
  end

  post "/users/:id/tables" do
    if logged_in?
      words = Word.parse(params[:section])
      @table = Table.create(title: params[:title], tractate: Tractate.find_by(name: params[:tractate]), words: words, user_id: session[:user_id])
      erb :'tables/show'
    else
      redirect "/failure"
    end
  end

  get "/users/:id/tables" do
    if logged_in?
			erb :'users/tables'
		else
			redirect "/failure"
		end
  end

  get "/users/:id/tables/:slug" do
    if logged_in?
      @table = Table.find_by_slug(params[:slug])
			erb :"/tables/show"
		else
			redirect "/failure"
		end
  end

  post "/users/:id/tables/:slug" do
    if logged_in?
      words = Word.parse(params[:section])
      @table = Table.create(title: params[:title], tractate: Tractate.find_by(name: params[:tractate]), words: words, user_id: session[:user_id])
      erb :'/tables/show'
    else
      redirect "/failure"
    end
  end

  get '/users/:id/tables/:slug/edit' do
    if logged_in?
      @table = Table.find_by_slug(params[:slug])
			erb :"/tables/edit"
		else
			redirect "/failure"
		end
  end

  patch '/users/:id/tables/:slug' do
    if logged_in?
      @table = Table.find_by_slug(params[:slug])
      @table.words.each do |word|
        word.update(hebrew: params["hebrew_" + "#{word.id}"], translation_one: params["translation_one_" + "#{word.id}"], translation_two: params["translation_two_" + "#{word.id}"], translation_three: params["translation_three_" + "#{word.id}"])
      end
			erb :"/tables/show"
		else
			redirect "/failure"
		end
  end

  get "/users/:id/tractates" do
    if logged_in?
			erb :'users/tractates'
		else
			redirect "/failure"
		end
  end

end