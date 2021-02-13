# Require for empty records
require 'pagy/extras/overflow'

class ApplicationController < ActionController::API
  include ErrorHandler
  include RequestHandler
  include ResponseHandler
  include Pagy::Backend
end
