# frozen_string_literal: true

require 'google/apis/drive_v3'

module Google
  class PermissionsService
    def initialize(user)
      @service = Google::Apis::DriveV3::DriveService.new
      @service.authorization = Google::CredentialsService.instance.authorization_of(user)
    end

    def create_permissions(file_ids, permissions = [], options = {}, callback = proc {})
      return if file_ids.blank? || permissions.blank?

      @service.batch do |drive|
        file_ids.each do |file_id|
          permissions.each do |permission|
            drive.create_permission(file_id, Google::Apis::DriveV3::Permission.new(permission), options, &callback)
          end
        end
      end
    end
  end
end
