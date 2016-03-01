Company APIs
===============================================
There is a RESTFul API to create company, update company, update other company related informations.

1) To Register a company<br/>
   Make a call to URL : http://localhost:8080/SpringMVCAngular/company/create of Request type POST<br/>
   With below mentioned parameters and its valid values:<br/>
   1) name as String value<br/>
   2) address as String value<br/>
   3) city as string value<br/>
   4) country as string value<br/>
   5) email as a string value (optional parameter)<br/>
   6) contactNo as a string value (optional paramter)<br/>
   7) owners as a string value (Coma separated value incase of multiple owners)<br/>
<br/>
   e.x.<br/>
   http://localhost:8080/SpringMVCAngular/company/create<br/>
   Request body parameters : name=NJ&address=abc&city=NY&country=US&owners=ABC,BCD
<br/><br/>
2) Get all registered company
   Make a call to URL : http://localhost:8080/SpringMVCAngular/company/all
<br/><br/>
3) Get a detail about specific company
   Make a call to URL : http://localhost:8080/SpringMVCAngular/company/{id}
   e.x.
   If NJ PVT LTD company's registered id is 1234 then http://localhost:8080/SpringMVCAngular/company/1234
<br/><br/>
4) Update company detail
   Make a call to URL : http://localhost:8080/SpringMVCAngular/company/update of Request type POST
   with below mentioned mandatory parameters: <br/>
   1) name as String value <br/>
   2) address as String value <br/>
   3) city as string value <br/>
   4) country as string value <br/>
   5) email as a string value (optional parameter) <br/>
   6) contactNo as a string value (optional paramter) <br/>
   7) owners as a string value (Coma separated value incase of multiple owners) <br/>
   e.x. <br/>
   http://localhost:8080/SpringMVCAngular/company/update <br/>
   Request body parameters : name=NJ&address=abc&city=NY&country=US&owners=ABC,BCD