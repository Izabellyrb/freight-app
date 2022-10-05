# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Usuários
admin_user = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456')
regular_user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011')
