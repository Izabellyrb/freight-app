# freight-app
Aplicação que gerencia a frota de entrega para um e-commerce com alcance nacional (projeto proposto pela Campus Code - TreinaDev9).
<br><br>

## ⚙ Configurações necessárias
- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) 3.0.2 
- [Rails](https://guides.rubyonrails.org/getting_started.html) 7.0.4 
<br><br>


### 💎 Gems necessárias
- rspec-rails 5.1.2
- capybara 3.37.1
- devise 4.8.1
- bootstrap 5.2.1
- importmap-rails
<br><br>

## 🚀 Como rodar a aplicação
No seu terminal, clone o projeto:
```sh
git@github.com:TreinaDev/freight-app.git
```

Instale as dependencias:
```sh
bin/setup
```

Popule a app com o banco de dados:
```sh
rails db:seed
```

Visualize a app no browser:
```sh
rails server
```
acessando http://localhost:3000/
<br><br>


## 👩‍💻 Fazendo login na app
##  # Login admin 
- email: camila.souza@sistemadefrete.com.br
- senha: 123456 <br>
  
### Login usuário regular
- email: fernando.barros@sistemadefrete.com.br
- senha: 7891011
<br><br>

## ✔️ Tarefas do projeto e próximos passos
Board com as tasks: https://github.com/users/Izabellyrb/projects/1
<br>


### Itens pendentes de melhoria:
- [ ]  Ao finalizar OS, veículo alocado deve ser atualizado automaticamente para o status "disponível" (atualmente a atualização de status é manual)
- [ ] Ao iniciar OS, tabela com todas modalidades aptas a atender e os prazos/valores. (Só indica no select as modalidades disponíveis, tabela no menu 'Modalidades de transporte')
- [ ] Horario de finalização não 'traduzido' para -03:00.


<h4 align="center">
:construction: Em processo...
</h4>
