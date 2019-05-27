class TractatesController  < ApplicationController

  get "/tractates" do
    @tractates = Tractate.all
    erb :'/tractates/index'
  end

  get "/tractates/:id" do
    @tractate = Tractate.find(params[:id])
    erb :'/tractates/show'
  end
end
