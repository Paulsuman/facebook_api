class Api::V1::UsersController < ApplicationController
	expose(:user)
	expose(:users){User.all}
  # GET /users
  # GET /users.json
  def index
    render json: users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: user
  end

  # POST /users
  # POST /users.json
  def create
    if user.save
        
        if user.save
          render json: {id: user.id,email: user.email,name:user.name}, status: :created
        else
          render json: errors, status: :unprocessable_entity
        end
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if user.update(user_params)
      head :no_content
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user.destroy

    head :no_content
  end
  
  private
    
    def user_params
      params.require(:user).permit(:email,:password,:name,)
    end


end
