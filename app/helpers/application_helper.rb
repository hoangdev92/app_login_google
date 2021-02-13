module ApplicationHelper
  def multiple_names_of_record(record)
    default_data = proc { { id: nil, content: nil } }

    Rails.configuration.available_languages.reduce({}) do |data, language|
      informations = record.names.find(default_data) { |name| name.language == language }
      data.update language => { id: informations[:id], content: informations[:content] }
    end
  end

  def changes_histories_of_record(histories, histories_pagy)
    {
      metadata: render('v1/shared/metadata', pagy: histories_pagy),
      records: histories.map { |history| history_attributes_data_of(history) }
    }
  end

  private

  def history_attributes_data_of(record)
    {
      kind: record.kind,
      content: record.content,
      fields: record.fields,
      modifier: {
        id: record.modifier_id,
        email: record.modifier_email,
        full_name: record.modifier_full_name
      }
    }
  end
end
