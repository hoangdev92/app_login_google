# frozen_string_literal: true

module Errors
  module Authentication
    class Unauthorized < StandardError; end
    class NotAuthorized < StandardError; end
    class NotAvailableEmail < StandardError; end
    class GoogleAuthenticationFailed < StandardError; end
    class DeactivedAccount < StandardError; end
    class PermissionDenied < StandardError; end

    class RefreshGoogleCredentialsFail < StandardError; end
  end

  module Record
    class AlreadyDestroyed < StandardError; end
    class AlreadyRestored < StandardError; end
  end
end
