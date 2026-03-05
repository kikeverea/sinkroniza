User.find_or_create_by!(email: "admin@admin.com", role: "admin") do |user|
  user.password = "12341234"
  user.name = "Admin"
  user.lastname = "Innobing"
end