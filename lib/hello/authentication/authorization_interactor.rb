module Hello::Authentication
  class AuthorizationInteractor

    attr_reader :user

    def initialize(user, context)
      @user = user || ::User.new(role: 'guest')
      @context = context
    end

    def to_homepage_if_should_kick(roles)
      to_home_page if should_kick?(roles)
    end

    def to_home_page_unless_should_not_kick(roles)
      to_home_page unless should_not_kick?(roles)
    end

    private

    def should_kick?(roles)
      roles.map { |r| user.role_is? r }.inject(:|)
    end

    def should_not_kick?(roles)
      roles.map { |r| user.role_is? r }.inject(:|)
    end

    def to_home_page
      if user.guest?
        to_sign_in
      elsif user.onboarding?
        to_onboarding
      else
        to_root
      end
    end

    def method_missing(method, *args, &block)
      if @context.respond_to?(method)
        @context.send(method, *args, &block)
      else
        super
      end
    end

    def to_root
      respond_to do |format|
        format.html { redirect_to '/' }
        format.json do
          data   = { 'message' => 'Access Denied.' }
          status = :forbidden # 403
          render json: data, status: status
        end
      end
    end

    def to_sign_in
      respond_to do |format|
        format.html do
          hello_keep_current_url_on_session!
          redirect_to hello.sign_in_path
        end
        format.json do
          data   = { 'message' => 'An active access token must be used to query information about the current user.' }
          status = :unauthorized # 401
          render json: data, status: status
        end
      end
    end

    def to_onboarding
      respond_to do |format|
        format.html { redirect_to '/onboarding' }
        format.json do
          data   = { 'message' => 'Access Denied, visit /onboarding and complete your registration.' }
          status = :forbidden # 403
          render json: data, status: status
        end
      end
    end



  end
end
