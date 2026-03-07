users_then = User.count
subscriptions_then = User.count
companies_then = User.count
webs_then = Web.count
groups_then = Group.count
folders_then = Folder.count

user = User.find_or_create_by!(email: "admin@admin.com", role: "admin") do |user|
  user.password = "12341234"
  user.name = "Admin"
  user.lastname = "Innobing"
end

subscription = Subscription.find_or_create_by!(name: "Test subscription") do |subscription|
  subscription.quantity_users = rand(3..10)
end

company = Company.find_or_create_by!(name: "Test company") do |company|
  company.subscription = subscription
end

web_company = WebCompany.find_or_create_by!(name: "Test web", web_company_type: WebCompany.web_company_types.to_a.sample.first)

Web.find_or_create_by!(name: "Test web") { |web| web.web_company = web_company }
Group.find_or_create_by!(name: "Test group", company: company, created_by_user_id: user.id)
Folder.find_or_create_by!(name: "Test folder")

users_now = User.count
subscriptions_now = User.count
companies_now = User.count
webs_now = Web.count
groups_now = Group.count
folders_now = Folder.count

puts "Users in db: #{users_now} (#{users_now - users_then} users seeded)"
puts "Subscriptions in db: #{subscriptions_now} (#{subscriptions_now - subscriptions_then} subscriptions seeded)"
puts "Companies in db: #{companies_now} (#{companies_now - companies_then} companies seeded)"
puts "Webs in db: #{webs_now} (#{webs_now - webs_then} webs seeded)"
puts "Groups in db: #{groups_now} (#{groups_now - groups_then} groups seeded)"
puts "Folders in db: #{folders_now} (#{folders_now - folders_then} folders seeded)"