
# Usuários
user = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin) #admin
user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user) #regular

# Modalidades de Transporte
economic_transport = Transport.create!(name: 'Economico', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 1, status: :enabled)
regular_transport = Transport.create!(name: 'Comum', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 4, status: :enabled)
express_transport = Transport.create!(name: 'Expresso', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 10, status: :enabled)