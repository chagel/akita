class SessionsController < Devise::SessionsController
	skip_before_filter :verify_code
	layout 'simple'
end
