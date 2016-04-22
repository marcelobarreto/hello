module Hello
  module Railsy
    module Controller
      module KickingConcern
        extend ActiveSupport::Concern

        # OBSERVATION: Kicking cares about the request format, not so much about state

        module ClassMethods
          def kick(*args)
            options, roles = _restrict_split(args)
            before_action(options) { kick(*roles) }
          end

          def dont_kick(*args)
            options, roles = _restrict_split(args)
            before_action(options) { dont_kick(*roles) }
          end

          def dont_kick_people
            # :)
          end

          def _restrict_split(args)
            options = args.pop if args.last.is_a? Hash
            [(options || {}), args]
          end
        end

        def kick(*roles)
          hello_ai.to_homepage_if_should_kick(roles)
        end

        def dont_kick(*roles)
          hello_ai.to_home_page_unless_should_not_kick(roles)
        end

        private

        def hello_ai
          @hello_ai ||= Hello::Authentication::AuthorizationInteractor.new(current_user, self)
        end

      end
    end
  end
end
