# frozen_string_literal: true

class SetupUserAccountJob < ApplicationJob
  queue_as :task

  def perform(user)
    return if user.ready_for_drive?

    create_template_folder_of user
  end

  private

  def create_permissions_for_owners(folder_id, creator)
    permissions = Rails.configuration.owner_emails.map do |email|
      { email_address: email, role: 'writer', type: 'user' }
    end

    service = Google::PermissionsService.new(creator)
    service.create_permissions [folder_id], permissions, { send_notification_email: false }
  end

  def create_template_folder_of(user)
    service = Google::FoldersService.new user
    folder_template_name = Rails.configuration.settings.names[:template_folder]

    template_folder = service.create_folder folder_template_name
    user.update templates_folder_id: template_folder.id
    create_permissions_for_owners(template_folder.id, user)
  end
end
