# inserir usuário administrador do sistema
puts 'criando usuário administrador...'
User.create(name: 'Admin', email: 'admin@email.com', admin: true, password: 'admin', password_confirmation: 'admin')
puts '--------------------------------'
puts 'email: admin@email.com'
puts 'senha: admin'
puts ''

User.create(name: 'Guilherme Feitoza', email: 'guilherme@email.com', admin: false, password: 'guilherme', password_confirmation: 'guilherme')
User.create(name: 'Natan Negreiros', email: 'natan@email.com', admin: false, password: 'natan', password_confirmation: 'natan')
User.create(name: 'Rodrigo Vially', email: 'rodrigo@email.com', admin: false, password: 'rodrigo', password_confirmation: 'rodrigo')

puts ''
puts 'finalizado!'