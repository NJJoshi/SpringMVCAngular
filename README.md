Company APIs
===============================================
There is a RESTFul API to create company, update company, update other company related informations.

1) To Register a company
   Make a call to URL : http://localhost:8080/SpringMVCAngular/createCompany of Request type POST
   With below mentioned parameters and its valid values.
   1) name as String value
   2) address as String value
   3) city as string value
   4) country as string value
   5) email as a string value (optional parameter)
   6) contactNo as a string value (optional paramter)
   7) owners as a string value (Coma separated value incase of multiple owners)

   e.x.
   http://localhost:8080/SpringMVCAngular/createCompany
   Request body parameters : name=NJ&address=abc&city=NY&country=US&owners=ABC,BCD

2) Get all registered company
   Make a call to URL : http://localhost:8080/SpringMVCAngular/getAllCompanies

3) Get a detail about specific company
   Make a call to URL : http://localhost:8080/SpringMVCAngular/getCompany/{company-id}
   e.x.
   If NJ PVT LTD company's registered id is 1234 then http://localhost:8080/SpringMVCAngular/getCompany/1234

4) Update company detail
   Make a call to URL : http://localhost:8080/SpringMVCAngular/updateCompany of Request type POST
   with below mentioned mandatory parameters
   1) name as String value
   2) address as String value
   3) city as string value
   4) country as string value
   5) email as a string value (optional parameter)
   6) contactNo as a string value (optional paramter)
   7) owners as a string value (Coma separated value incase of multiple owners)
   e.x.
   http://localhost:8080/SpringMVCAngular/updateCompany
   Request body parameters : name=NJ&address=abc&city=NY&country=US&owners=ABC,BCD