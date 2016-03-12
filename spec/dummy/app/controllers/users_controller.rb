class UsersController < ApplicationController
  #
  #
  #
  # any role
  #

  before_action :find_user, only: [:show, :impersonate]

  # GET /users
  def index
    @users = User.order(:id)
  end

  # GET /users/username
  # GET /users/id -> redirects to /users/username
  def show
  end

  #
  #
  #
  # webmaster role
  #

  dont_kick :webmaster, only: [:list, :new, :create, :impersonate]
  sudo_mode only: [:list, :new, :create, :impersonate]
  before_action :init_user, only: [:new, :create]

  # GET /users/list
  def list
    @users = User.order(:id)
    @count = User.count
  end

  # GET /users/new
  def new
    @starting_role = 'onboarding'
  end

  # POST /users
  def create
    if @user.register(params.require(:user))
      @user.user.update!(role: params[:role])
      redirect_to new_user_path, notice: t('hello.entities.classic_sign_up.success')
    else
      @starting_role = params[:role]
      render action: :new
    end
  end

  # POST /users/1/impersonate
  def impersonate
    sign_in!(@user, 60.minutes.from_now, 60.minutes.from_now)

    redirect_to root_path, notice: t('hello.entities.classic_sign_in.success')
  end

  private

  def find_user
    @user = User.find_by_username!(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to User.find_by_id!(params[:id]) # forces redirect to path with username if used id on URL
  end

  def init_user
    @user = Hello::ClassicSignUpEntity.new
  end
end
