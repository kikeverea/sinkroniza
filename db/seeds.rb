users_then = User.count
subscriptions_then = User.count
companies_then = User.count

subscription = Subscription.find_or_create_by!(name: "Test subscription") do |subscription|
  subscription.quantity_users = rand(3..10)
end

Company.find_or_create_by!(name: "Test company") do |company|
  company.subscription = subscription
end

User.find_or_create_by!(email: "admin@admin.com", role: "admin") do |user|
  user.password = "12341234"
  user.name = "Admin"
  user.lastname = "Innobing"
end

users_now = User.count
subscriptions_now = User.count
companies_now = User.count

puts "Users in db: #{users_now} (#{users_now - users_then} users seeded)"
puts "Subscriptions in db: #{subscriptions_now} (#{subscriptions_now - subscriptions_then} subscriptions seeded)"
puts "Companies in db: #{companies_now} (#{companies_now - companies_then} companies seeded)"