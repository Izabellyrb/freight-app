
# Usuários
admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin) #admin
user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user) #regular

# Modalidades de Transporte
light_transport = Transport.create!(name: 'Leve', min_distance: 0, max_distance: 50, min_weight: 0, max_weight: 80, fee: 1, status: :enabled)
regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
heavy_transport = Transport.create!(name: 'Pesado', min_distance: 101, max_distance: 200, min_weight: 201, max_weight: 1000, fee: 10, status: :enabled)

# Gestão de Frota
v1 = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 100, status: :available)
v2 = Vehicle.create!(plate: 'EGR8J41', make: 'Renault', model: 'Master', year: 2010, max_load_capacity: 300, status: :operating)
v3 = Vehicle.create!(plate: 'PLA3S85', make: 'Fiat', model: 'Cargo', year: 2011, max_load_capacity: 400, status: :maintenance)
v4 = Vehicle.create!(plate: 'AOS1Q96', make: 'Scania', model: 'P410', year: 2004, max_load_capacity: 3000, status: :available)
v4 = Vehicle.create!(plate: 'OLQ5S74', make: 'Volkswagen', model: 'Fox', year: 2003, max_load_capacity: 100, status: :available)

# Preços por peso
weight_price1 = WeightPrice.create!(min_weight: 0, max_weight: 30, value_km: 0.20, transport: light_transport)
weight_price2 = WeightPrice.create!(min_weight: 31, max_weight: 60, value_km: 0.50, transport: light_transport)
weight_price3 = WeightPrice.create!(min_weight: 81, max_weight: 100, value_km: 0.60, transport: regular_transport)
weight_price4 = WeightPrice.create!(min_weight: 101, max_weight: 200, value_km: 0.90, transport: regular_transport)
weight_price5 = WeightPrice.create!(min_weight: 201, max_weight: 500, value_km: 1.20, transport: heavy_transport)
weight_price5 = WeightPrice.create!(min_weight: 501, max_weight: 700, value_km: 1.50, transport: heavy_transport)
weight_price5 = WeightPrice.create!(min_weight: 701, max_weight: 1000, value_km: 1.90, transport: heavy_transport)



