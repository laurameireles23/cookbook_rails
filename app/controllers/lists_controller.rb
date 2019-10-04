class ListsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :show, :create] 
    before_action :set_list, only: [:show]
  
    def index
      @lists = List.all
    end

    def new
        @list = List.new
    end

    def create
        @list = current_user.lists.new(list_params)
        if @list.save 
          redirect_to @list
        else 
          render :new
        end
    end

    def show; end

    private

    def set_list
      @list = List.find(params[:id])
    end
  
    def list_params
      params.require(:list).permit(:name)
    end
end