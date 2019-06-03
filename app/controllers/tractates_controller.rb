class TractatesController  < ApplicationController

  get "/tractates" do
    @tractates = Tractate.all.sort_by {|tractate| tractate.name}
    erb :'/tractates/index'
  end

  get "/tractates/:slug" do
    @tractate = Tractate.find_by_slug(params[:slug])
    erb :'/tractates/show'
  end
end
