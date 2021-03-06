require 'spec_helper'

module Hello
  describe Management::CancelAccountController do
    describe 'routing' do
      routes { Hello::Engine.routes }

      it 'routes to #index' do
        expect(get('/cancel_account')).to route_to('hello/management/cancel_account#index')
      end

      it 'routes to #cancel' do
        expect(post('/cancel_account')).to route_to('hello/management/cancel_account#cancel')
      end
    end
  end
end
