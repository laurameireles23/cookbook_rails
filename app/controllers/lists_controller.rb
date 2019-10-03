class ListsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :show] 
  
    def index
      @lists = List.all
    end
end