users_then = User.count
subscriptions_then = User.count
companies_then = User.count
webs_then = Web.count
groups_then = Group.count
tags_then = Tag.count

super_admin = User.find_or_create_by!(email: "super@admin.com", role: "super_admin") do |user|
  user.password = "12341234"
  user.name = "Super"
  user.lastname = "Admin"
end

Current.user = super_admin

subscription = Subscription.find_or_create_by!(name: "Test subscription") do |subscription|
  subscription.max_users = rand(3..10)
end

company = Company.find_or_create_by!(name: "Test company") do |company|
  company.subscription = subscription
  company.creator = super_admin
end

Current.company = company

admin = User.find_or_create_by!(email: "admin@admin.com", role: "company_admin") do |user|
  user.password = "12341234"
  user.name = "Admin"
  user.lastname = "Test"
  user.company = company
end

web_company = WebCompany.find_or_create_by!(name: "Innobing", web_company_type: :other)
web = Web.find_or_create_by!(name: "Test web", access_url: "https://www.innobing.com/en/") { |web| web.web_company = web_company }

5.times do |i|
  user = User.find_or_create_by!(email: "user#{i + 1}@user.com", role: "user") do |user|
    user.password = "12341234"
    user.name = "User"
    user.lastname = "Test #{i + 1}"
    user.company_id = company.id
  end
  Credential.create!(
    name: "Test credential #{i}",
    web: web,
    credential_type: :regular,
    group: user.personal_group,
    company: company
  )
end

Tag.find_or_create_by!(name: "Test tag", color: "#41C29E")
Group.find_or_create_by!(name: "Test group", company: company, creator: admin)

users_now = User.count
subscriptions_now = User.count
companies_now = User.count
webs_now = Web.count
groups_now = Group.count
tags_now = Tag.count

puts "Users in db: #{users_now} (#{users_now - users_then} users seeded)"
puts "Subscriptions in db: #{subscriptions_now} (#{subscriptions_now - subscriptions_then} subscriptions seeded)"
puts "Companies in db: #{companies_now} (#{companies_now - companies_then} companies seeded)"
puts "Webs in db: #{webs_now} (#{webs_now - webs_then} webs seeded)"
puts "Groups in db: #{groups_now} (#{groups_now - groups_then} groups seeded)"
puts "Tags in db: #{tags_now} (#{tags_now - tags_then} tags seeded)"