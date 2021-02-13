# frozen_string_literal: true

require 'google/apis/drive_v3'

module Google
  class FoldersService
    FOLDER_MIME_TYPE = 'application/vnd.google-apps.folder'

    def initialize(user)
      @service = Google::Apis::DriveV3::DriveService.new
      @service.authorization = Google::CredentialsService.instance.authorization_of(user)
    end

    def create_folder(name, **data)
      folder = Google::Apis::DriveV3::File.new mime_type: FOLDER_MIME_TYPE, name: name, **data
      @service.create_file folder
    end
  end
end
