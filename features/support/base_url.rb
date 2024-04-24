module Employee 
    include HTTParty
    base_uri 'https://reqres.in/api/users'
    format :json
    headers 'Content-Type': 'application/json'
end
