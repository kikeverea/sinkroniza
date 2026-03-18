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


## Subscriptions
Subscription.find_or_create_by!(name: "Starter") do |subscription|
  subscription.max_users = 3
  subscription.price = 30
end

Subscription.find_or_create_by!(name: "Professional") do |subscription|
  subscription.max_users = 10
  subscription.price = 80
end

Subscription.find_or_create_by!(name: "Enterprise") do |subscription|
  subscription.max_users = 30
  subscription.price = 100
end


## Zurich
WebCompany.find_or_create_by!(name: "Zurich", web_company_type: :insurance)
Web.find_or_create_by!(
  name: "Zurich",
  access_url: "https://login.zurich.es/auth/realms/emp-inter/protocol/openid-connect/auth?client_id=ZonaZurichThunder&redirect_uri=https%3A%2F%2Fzonazurich.zurich.es%2Fsec%2Fdo-login&state=7d1f04f7-6bd3-4b7f-8547-1bca02b32e6e&response_mode=fragment&response_type=code&scope=openid&nonce=6d64f0f1-da90-4445-bd36-f42cf216dacc",
  web_company: WebCompany.last
)

## Reale Seguros
WebCompany.find_or_create_by!(name: "Reale Seguros", web_company_type: :insurance)
Web.find_or_create_by!(
  name: "Reale Seguros",
  access_url: "https://login.microsoftonline.com/75584e34-72c0-4772-b459-a9fe78fec27c/wsfed?wtrealm=https%3a%2f%2fmediadores.reale.es&wctx=WsFedOwinState%3dZdBt_l89PNDHIesSJZlp6-r3MRg17lmW6A_lJ8Z-2VURxDtat53ax9_Ys0h6J2sCtTGVCiRG7H230O6e3h9SJm7zMLXI2QZOS3Q7Cgzdpw2n99C5h-bS-2WPiaPIT734MwLWImufAKT_pq74ZSruEa4dELQ&wa=wsignin1.0&sso_reload=true",
  web_company: WebCompany.last
)

## Allianz
WebCompany.find_or_create_by!(name: "Allianz", web_company_type: :insurance)
Web.find_or_create_by!(
  name: "Allianz",
  web_company: WebCompany.last,
  access_url: "https://www.e-pacallianz.com/ngx-azs-epac/public/home?1="
)
Web.find_or_create_by!(
  name: "Allianz Life",
  access_url: "https://www.allianzlife.com/Login",
  web_company: WebCompany.last
)
Web.find_or_create_by!(
  name: "Allianz Travel Insurance",
  access_url: "https://www.allianztravelinsurance.com/login",
  web_company: WebCompany.last
)

Company.find_or_create_by!(name: "Asmeval") do |company|
  company.subscription = Subscription.all.sample
  company.creator = super_admin
end
User.find_or_create_by!(email: "admin@admin.com", role: "company_admin") do |user|
  user.password = "12341234"
  user.name = "Lucía"
  user.lastname = "Martínez García"
  user.company = Company.last
end

Company.find_or_create_by!(name: "Bima") do |company|
  company.subscription = Subscription.all.sample
  company.creator = super_admin
end
User.find_or_create_by!(email: "admin@bima.com", role: "company_admin") do |user|
  user.password = "12341234"
  user.name = "Álvaro"
  user.lastname = "Sánchez Romero"
  user.company = Company.last
end

[%w[Trabajo #3796F0], %w[Personal #4DAE54], %w[Bancario #F69405], %w[Seguros #9B26B0]].each do |(tag, color)|
  Tag.find_or_create_by!(name: tag, color: color)
end

Current.company = Company.first

[ "María López Fernández",
  "Carlos Gómez Navarro",
  "Elena Ruiz Morales",
  "Javier Castro Ortega",
  "Paula Herrera Molina"
].each do |full_name|
  name_parts = full_name.split(" ")
  User.find_or_create_by!(email: "#{name_parts.first}@user.com", role: "user") do |user|
    user.password = "12341234"
    user.name = name_parts.first
    user.lastname = "#{name_parts.second} #{name_parts.third}"
    user.company_id = Company.first.id
  end
end

Group.find_or_create_by!(name: "Test group", company: Company.first, creator: Company.first.manager)

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