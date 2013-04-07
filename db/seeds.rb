
user = User.create :username => 'admin', :password_hash => 'pleaseLetmein!',
  :creator => 1, :voided => 0 

DocumentCategory.create :name => 'African Business Women (ABW) Connected' , :description => "nformative resources on 'ABW Connected'. For more information, please visit ABW Connected Official Website (to be launched shortly!!)"

UserRoles.create :user_id => user.id, :role => 'admin'
puts "Your new user is: admin, password: pleaseLetmein!"


