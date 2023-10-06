class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create,:update,:destroy,:edit]
  before_action :set_prototype, only: [:show,:edit,:update,:destroy]
  before_action :move_to_index, except: [:index, :show]


    def index
      @prototype = Prototype.all
    end   
    
    def new
        @prototype = Prototype.new  
    end

    def create
        @prototype = Prototype.new(room_params)
        if @prototype.save
          redirect_to root_path
        else
          render :new, status: :unprocessable_entity
        end
    end

    def show  
      @comment = Comment.new
      @comments = @prototype.comments. includes(:user)
    end  

    def edit
    end

    def update
      if @prototype.update(room_params)
        redirect_to prototype_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @prototype.destroy
      redirect_to root_path
    end


    private

    def room_params
        params.require(:prototype).permit(:image, :title,:catch_copy,:concept).merge(user_id: current_user.id)
    end

      def set_prototype
        @prototype = Prototype.find(params[:id])
      end

      def move_to_index
        unless user_signed_in? && current_user.id == prototype.user_id 
          redirect_to action: :index
        end 
      end
end