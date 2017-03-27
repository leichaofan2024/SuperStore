class WelcomeController < ApplicationController

  def index
    flash[:notice] = "Superlei say hello to you !"
  end
end
