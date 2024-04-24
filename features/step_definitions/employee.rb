Dado('que o usuario consulte informacoes de funcionarios') do
    @getlist = Employee_Requests.new
  end
  
  Quando('ele realizar a pesquisa') do
    @list_employee = @getlist.find_employee
  end
  
  Entao('uma lista de funcionarios deve retornar') do
    expect(@list_employee.code).to eql 200
    expect(@list_employee.message).to eql 'OK'
  end
  
  Dado('que o usuario cadastre um novo funcionario') do
    @create = Employee_Requests.new
  end
  
  Quando('ele enviar as informacoes do funcionario') do
    @create_employee = @create.create_employee(
      [DATABASE[:id][:id1]],
      [DATABASE[:email][:email1]],
      [DATABASE[:first_name][:first_name1]],
      [DATABASE[:last_name][:last_name1]]
    )
    puts @create_employee
  end
  
  Entao('esse funcionario sera cadastrado') do
    expect(@create_employee["code"]).to eql(201)
    expect(@create_employee["msg"]).to eql "Created"
    expect(@create_employee["first_name"]).to eql [DATABASE[:first_name][:first_name1]]
    expect(@create_employee["email"]).to eql [DATABASE[:email][:email1]]
    expect(@create_employee["id"]).to eql [DATABASE[:id][:id1]]
  end

  Dado('que o usuario altere informacao de funcionario') do
    @request = Employee_Requests.new
  end
  
  Quando('ele enviar as novas informacoes') do
    employee_id = @request.find_employee['data'][0]['id']
    @update_employee = @request.update_employee(DATABASE[:id][:id2], DATABASE[:email][:email2], DATABASE[:first_name][:first_name2], DATABASE[:last_name][:last_name2])
    puts @update_employee
  end
  
  Entao('as informacoes serao alteradas') do
    expect(@update_employee.code).to eq(200)
    expect(@update_employee.message).to eq('OK')
    expect(@update_employee['first_name']).to eq DATABASE[:first_name][:first_name2]
    puts "Alteração feita com sucesso no cadastro da funcionária #{DATABASE[:first_name][:first_name2]}!"
  end

  Dado('que o usuario queira deletar um funcionario') do
    @request = Employee_Requests.new
  end
  
  Quando('ele enviar a identificacao unica') do
    @delete_employee = @request.delete_employee(@request.find_employee['data'][0]['id'])
  end
  
  Entao('esse funcionario sera deletado do sistema') do
    expect(@delete_employee.code).to eq(204)
    expect(@delete_employee.message).to eq('No Content')
    if @delete_employee.code == 204
      puts "O funcionário com foi excluído com sucesso!"
  end
end