module Hello
  module Registration
    class ClassicSignUpController < ApplicationController
      include Hello::Concerns::ClassicSignUpOnSuccess
      include Hello::Concerns::ClassicSignUpOnFailure

      dont_kick_people

      before_action do
        @entity = @sign_up = ClassicSignUpEntity.new
      end

      # GET /hello/sign_up
      def index
        render_classic_sign_up
      end

      # GET /hello/sign_up/widget
      def widget
        render 'hello/registration/classic_sign_up/widget', layout: false
      end

      # POST /hello/sign_up
      def create
        if classic_sign_up_disabled
          @sign_up.errors[:base] << "Email Registration is temporarily disabled"
          on_failure
        else
          if @sign_up.register(params.require(:sign_up))
            flash[:notice] = @sign_up.success_message
            on_success
          else
            on_failure
          end
        end
      end

      # GET /hello/sign_up/disabled
      def disabled
        render_classic_sign_up
      end

      protected

      def render_classic_sign_up
        render 'hello/registration/classic_sign_up/index'
      end
    end
  end
end
