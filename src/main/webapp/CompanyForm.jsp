<html>
<head>
    <title>Angular JS Forms</title>
    <script src = "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>

    <style>
        table, th , td {
            border: 1px solid grey;
            border-collapse: collapse;
            padding: 5px;
        }

        table tr:nth-child(odd) {
            background-color: #f2f2f2;
        }

        table tr:nth-child(even) {
            background-color: #ffffff;
        }
    </style>

</head>
<body>

<h2 align="center">Company Application</h2>
<div ng-app = "mainApp" ng-controller = "companyController">

    <form name = "companyForm" novalidate>
        <table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td>Enter Company name:</td>
                <td><input name = "name" type = "text" ng-model = "name" required>
                     <span style = "color:red" ng-show = "companyForm.name.$dirty && companyForm.name.$invalid">
                        <span ng-show = "companyForm.name.$error.required">Company Name is required.</span>
                     </span>
                </td>
            </tr>

            <tr>
                <td>Enter Address: </td>
                <td><input name = "address"  type = "text" ng-model = "address" required>
                     <span style = "color:red" ng-show = "companyForm.address.$dirty && companyForm.address.$invalid">
                        <span ng-show = "companyForm.address.$error.required">Address is required.</span>
                     </span>
                </td>
            </tr>

            <tr>
                <td>Enter City: </td>
                <td><input name = "city"  type = "text" ng-model = "city" required>
                     <span style = "color:red" ng-show = "companyForm.city.$dirty && companyForm.city.$invalid">
                        <span ng-show = "companyForm.city.$error.required">City is required.</span>
                     </span>
                </td>
            </tr>

            <tr>
                <td>Enter Country: </td>
                <td><input name = "country"  type = "text" ng-model = "country" required>
                     <span style = "color:red" ng-show = "companyForm.country.$dirty && companyForm.country.$invalid">
                        <span ng-show = "companyForm.country.$error.required">City is required.</span>
                     </span>
                </td>
            </tr>


            <tr>
                <td>Email: </td><td><input name = "email" type = "email" ng-model = "email" length = "100">
                </td>
            </tr>

            <tr>
                <td>Phone Number: </td><td><input name = "contactNo" type = "text" ng-model = "contactNo" length = "12">
            </td>
            </tr>

            <tr>
                <td>Beneficiary: </td><td><input name = "beneficiary" type = "text" ng-model = "beneficiary" length = "100" required>
                    <span style = "color:red" ng-show = "companyForm.beneficiary.$dirty && companyForm.beneficiary.$invalid">
                        <span ng-show = "companyForm.beneficiary.$error.required">Beneficiary is required.</span>
                     </span>
            </td>
            </tr>

            <tr>
                <td>
                    <button ng-disabled = "companyForm.name.$dirty &&
                        companyForm.name.$invalid || companyForm.address.$dirty &&
                        companyForm.address.$invalid || companyForm.city.$dirty &&
                        companyForm.city.$invalid || companyForm.country.$dirty &&
                        companyForm.country.$invalid || companyForm.beneficiary.$dirty &&
                        companyForm.beneficiary.$invalid" ng-click = "createNewCompany()">Create Company</button>
                </td>
                <td>
                    <button ng-click = "updateCompanyData()">Update Company</button>
                </td>
            </tr>

        </table>
        <br/>
        <br/>
        <br/>
        <table align="center">
            <tr>
                <th>CompanyId</th>
                <th>Name</th>
                <th>Address</th>
                <th>City</th>
                <th>Country</th>
                <th>Email</th>
                <th>Contact No</th>
                <th>Owners</th>
                <th>&nbsp;</th>
                <th>&nbsp;</th>
            </tr>
            <tr ng-repeat="x in detail">
                <td>{{x.companyId}}</td>
                <td>{{x.name}}</td>
                <td>{{x.address}}</td>
                <td>{{x.city}}</td>
                <td>{{x.country}}</td>
                <td>{{x.email}}</td>
                <td>{{x.contactNo}}</td>
                <td>{{x.beneficiary}}</td>
                <td><input type="radio" ng-click="selectData.company = x"></td>
                <td><a href="#" ng-click="loadCompanyData()">Load Data</a></td>
            </tr>
        </table>
    </form>
</div>

<script>
    var mainApp = angular.module("mainApp", []);

    mainApp.controller('companyController', function($scope, $http, $window) {

        var companyId;
        /* Load all company grid data */
        var getAllCompanyURL = 'http://localhost:8080/SpringMVCAngular/getAllCompanies';
        $scope.detail = [];
        $http.get(getAllCompanyURL).success(function(response) {
            $scope.detail=response.companies;
        });

        /* Create company data */
        var createCompanyURL = "http://localhost:8080/SpringMVCAngular/createCompany";
        $scope.createNewCompany = function() {
            var dataString = 'name='+$scope.name + '&address=' + $scope.address + '&city=' + $scope.city + '&country=' + $scope.country + '&';
            if($scope.email != '')
                dataString += 'email='+$scope.email + '&';

            if($scope.contactNo != '')
                dataString += 'contactNo='+$scope.contactNo + '&';

            dataString += 'owners='+$scope.beneficiary;
            $http({
                method: 'POST',
                url: createCompanyURL,
                data: dataString,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            }).success(function() {
                var getAllCompanyURL = 'http://localhost:8080/SpringMVCAngular/getAllCompanies';
                $scope.name='';
                $scope.address='';
                $scope.city='';
                $scope.country='';
                $scope.email='';
                $scope.contactNo='';
                $scope.beneficiary='';
                $scope.detail = [];
                $http.get(getAllCompanyURL).success(function(response) {
                    $scope.detail=response.companies;
                });
            });
        }

        /* Load company data */
        var loadCompanyDataURL = "http://localhost:8080/SpringMVCAngular/getCompany/";
        $scope.selectData = {}
        $scope.loadCompanyData = function() {
            var id = $scope.selectData.company.companyId;
            companyId = id;
            loadCompanyDataURL += id;
            $window.alert("company id:" + id);
            $http.get(loadCompanyDataURL).success(function(response) {
                var jsonResp = response;
                var companyName = jsonResp.companies.name;
                var address = jsonResp.companies.address;
                var city = jsonResp.companies.city;
                var country = jsonResp.companies.country;
                var email = jsonResp.companies.email;
                var contactNo = jsonResp.companies.contactNo;
                var beneficiary = jsonResp.companies.beneficiary;

                $scope.name=companyName;
                $scope.address=address;
                $scope.city=city;
                $scope.country=country;
                $scope.email=email;
                $scope.contactNo=contactNo;
                $scope.beneficiary=beneficiary;

                $window.alert("company id:" + id + ",companyName=" + companyName + ",address="+address+",city="+city+",country="+country+",email="+email+",contactNo="+contactNo+",beneficiary="+beneficiary);
            });

        }

        /* Update company data */
        var updateCompanyURL = "http://localhost:8080/SpringMVCAngular/updateCompany";
        $scope.updateCompanyData = function() {
            var dataString = 'name='+$scope.name + '&address=' + $scope.address + '&city=' + $scope.city + '&country=' + $scope.country + '&';
            if($scope.email != '')
                dataString += 'email='+$scope.email + '&';

            if($scope.contactNo != '')
                dataString += 'contactNo='+$scope.contactNo + '&';

            dataString += 'owners='+$scope.beneficiary + '&Id='+companyId;
            $http({
                method: 'POST',
                url: updateCompanyURL,
                data: dataString,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            }).success(function() {
                var getAllCompanyURL = 'http://localhost:8080/SpringMVCAngular/getAllCompanies';
                $scope.name='';
                $scope.address='';
                $scope.city='';
                $scope.country='';
                $scope.email='';
                $scope.contactNo='';
                $scope.beneficiary='';
                $scope.detail = [];
                $http.get(getAllCompanyURL).success(function(response) {
                    $scope.detail=response.companies;
                });
            });
        }

        /*$scope.submit = function() {
            var URL = 'http://localhost:8080/SpringMVCAngular/getAllCompanies';
            $http.get(URL).success(function(response) {
                var jsonResp = response;
                var companyName = jsonResp.companies[0].name;
                var companyId = jsonResp.companies[0].companyId;
                $window.alert("Company Name :" + companyName + ", Company Id: " + companyId + ",Entered first name:" + $scope.firstName);

            });
        }*/
    });

</script>

</body>
</html>