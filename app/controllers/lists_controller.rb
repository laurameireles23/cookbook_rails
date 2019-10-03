class ListsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :show] 
    before_action :set_list, only: [:show]
  
    def index
      @lists = List.all
    end

    def new
        @list = List.new
    end

    def create
        @list = List.create(list_params)
        @lists = List.all
        redirect_to lists_path
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