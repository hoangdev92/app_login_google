# frozen_string_literal: true

module V1
  module Public
    class AuthenticationsController < PublicController
      def create
        service = Auth::SignInService.new params
        service.verify_access!
        SetupUserAccountJob.perform_later(service.user) unless service.user.ready_for_drive?
        @tokens = service.verified_tokens
      end
    end
  end
end
