total_processes = 5
availabilities = %i[available unavailable].freeze
user_statuses = %i[inactive active].freeze

puts '====== BEGIN: GENERATE DUMMY DATA ======'

# BEGIN: Users
puts "→ START 1/#{total_processes}: Generate users"
users_data = 30.times.map do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  {
    email: Faker::Internet.safe_email,
    full_name: "#{first_name} #{last_name}",
    first_name: first_name,
    last_name: last_name,
    avatar: Faker::Avatar.image,
    role: User.roles.keys.sample,
    google_id: Faker::IDNumber.valid,
    status: user_statuses.sample
  }
end

users = User.create users_data
puts "✓ DONE 1/#{total_processes}: Generate users"
# END: Users

# BEGIN: Legal Entities
puts "→ START 2/#{total_processes}: Generate legal entities"
entities_data = 30.times.map do
  {
    code: Faker::Company.buzzword,
    sync_code: Faker::Company.buzzword,
    names_attributes: Rails.configuration.available_languages.map do |language|
      { language: language, content: Faker::Company.name }
    end,
    changes_histories_attributes: [
      {
        kind: :create,
        modifier_id: users.sample.id,
        content: I18n.t('changes_histories.create')
      }
    ],
    availability: availabilities.sample
  }
end

LegalEntity.create entities_data
puts "✓ DONE 2/#{total_processes}: Generate legal entities"
# END: Legal Entities

# BEGIN: Categories
puts "→ START 3/#{total_processes}: Generate categories"
30.times do
  category_data = {
    parent_id: [0, *Category.ids].sample,
    names_attributes: Rails.configuration.available_languages.map do |language|
      { language: language, content: Faker::Beer.name }
    end,
    changes_histories_attributes: [
      {
        kind: :create,
        modifier_id: users.sample.id,
        content: I18n.t('changes_histories.create')
      }
    ],
    availability: availabilities.sample
  }

  Category.create category_data
end
puts "✓ DONE 3/#{total_processes}: Generate categories"
# END: Categories

# BEGIN: Products
puts "→ START 4/#{total_processes}: Generate products"
products_data = 30.times.map do
  {
    code: Faker::Internet.slug,
    names_attributes: Rails.configuration.available_languages.map do |language|
      { language: language, content: Faker::Beer.name }
    end,
    changes_histories_attributes: [
      {
        kind: :create,
        modifier_id: users.sample.id,
        content: I18n.t('changes_histories.create')
      }
    ],
    availability: availabilities.sample
  }
end

Product.create products_data
puts "✓ DONE 4/#{total_processes}: Generate products"
# END: Products

# BEGIN: Funds
puts "→ START 5/#{total_processes}: Generate funds"
funds_data = 30.times.map do
  {
    code: Faker::Internet.slug,
    owner_id: User.ids.sample,
    changes_histories_attributes: [
      {
        kind: :create,
        modifier_id: users.sample.id,
        content: I18n.t('changes_histories.create')
      }
    ],
    availability: availabilities.sample
  }
end

Fund.create funds_data
puts "✓ DONE 5/#{total_processes}: Generate funds"
# END: Funds

puts '======= END: GENERATE DUMMY DATA ======='
