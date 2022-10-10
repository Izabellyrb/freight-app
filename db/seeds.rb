
# Usuários
admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin) #admin
user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user) #regular

# Modalidades de Transporte
economic_transport = Transport.create!(name: 'Economico', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 1, status: :enabled)
regular_transport = Transport.create!(name: 'Comum', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 4, status: :enabled)
express_transport = Transport.create!(name: 'Expresso', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 10, status: :enabled)

# Gestão de Frota
v1 = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)
v2 = Vehicle.create!(plate: 'EGR8J41', make: 'Renault', model: 'Master' year: 2010, max_load_capacity: 1000, status: :operating)
v3 = Vehicle.create!(plate: 'PLA3S85', make: 'Scania', model: 'P410', year: 2004, max_load_capacity: 3000, status: :maintenance)
