class Employee_Requests

    def find_employee
        Employee.get('?page=1')
    end


    def create_employee(id, email, first_name, last_name)
        response = Employee.post('?page=2/create', body: {
            "id": id,
            "email": email,
            "first_name": first_name,
            "last_name": last_name,
            "avatar": "https://reqres.in/img/faces/7-image.jpg"
        }.to_json)
        if response.code == 201
            response.merge("code" => response.code, "msg" => "Created")
          else
            response.merge("code" => response.code, "msg" => "msg")
          end
    end

    def update_employee(id, email, first_name, last_name)
        Employee.put('/updade/' + id.to_s, body: {
            "id": id,
            "email": email,
            "first_name": first_name,
            "last_name": last_name,
            "avatar": "https://reqres.in/img/faces/1-image.jpg"
      }.to_json)
    end


    def delete_employee(id)
        Employee.delete('/delete/' + id.to_s)
    end
end