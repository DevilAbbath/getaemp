# Descarga la imagen y luego adjúntala al usuario
puts "a ver si funcionas seed de mierda ..."
admin_user = User.create!(
  name: 'Usuario 1',
  email: 'user@mail.com',
  password: '123123',
  role: 'user'
)

puts "ahi funciono"