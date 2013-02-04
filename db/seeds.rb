
user = User.create :username => 'admin', :password_hash => 'pleaseLetmein!',
  :creator => 1, :voided => 0 

UserRoles.create :user_id => user.id, :role => 'admin'
puts "Your new user is: admin, password: pleaseLetmein!"


