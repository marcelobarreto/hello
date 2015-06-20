require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class Master::ImpersonationController < ApplicationController

    dont_kick :master, only: [:create]

    # POST /hello/master/impersonate credential_id: 1
    def create
      user = User.find(params[:user_id])
      impersonate(user)

      entity = ImpersonateEntity.new(user)
      flash[:notice] = entity.success_message
      redirect_to :back
    end

    # GET /hello/master/impersonate
    def destroy
      hello_back_to_myself

      entity = ImpersonateBackEntity.new
      flash[:notice] = entity.success_message
      redirect_to '/'
    end

  end
end