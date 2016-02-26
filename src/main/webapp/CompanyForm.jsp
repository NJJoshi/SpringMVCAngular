<html>
<head>
    <title>Angular JS Forms</title>
    <script src = "js/angular/angular.min.js"></script>

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
                <td><input type="radio" id="radiobtn" ng-click="selectData.company = x"></td>
                <td><a href="#" ng-click="loadCompanyData()">Load Data</a></td>
            </tr>
        </table>
    </form>
</div>

<script>
    var mainApp = angular.module("mainApp", []);

    mainApp.controller('companyController', function($scope, $http, $window) {
        loadCompanyGrid($scope, $http);
        createCompany($scope, $http);
        loadCompanyData($scope, $http);
        updateCompanyDetail($scope, $http);
    });

    /* Load all company grid data */
    function loadCompanyGrid($scope, $http) {
        var getAllCompanyURL = 'getAllCompanies';
        $scope.detail = [];
        $http.get(getAllCompanyURL).success(function(response) {
            $scope.detail=response.companies;
        });
    }

    /* Load company data */
    function loadCompanyData($scope, $http) {
        var selectedCompanyId;
        var loadCompanyDataURL = "getCompany/";
        $scope.selectData = {}
        $scope.loadCompanyData = function() {
            $scope.selectedCompanyId = $scope.selectData.company.companyId;
            loadCompanyDataURL += $scope.selectedCompanyId;

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
            });
        }
    }

    /* Update company data */
    function updateCompanyDetail($scope, $http) {
        //var updateCompanyURL = "updateCompany";
        var updateCompanyURL = "updateCompanyDetail";
        $scope.updateCompanyData = function() {
            var dataString = 'name='+$scope.name + '&address=' + $scope.address + '&city=' + $scope.city + '&country=' + $scope.country + '&';
            if($scope.email != '')
                dataString += 'email='+$scope.email + '&';

            if($scope.contactNo != '')
                dataString += 'contactNo='+$scope.contactNo + '&';

            dataString += 'owners='+$scope.beneficiary + '&Id='+$scope.selectedCompanyId;
            $http({
                method: 'POST',
                url: updateCompanyURL,
                data: dataString,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            }).success(function() {
                var getAllCompanyURL = 'getAllCompanies';
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
    }

    /* Create company data */
    function createCompany($scope, $http){
        var createCompanyURL = "createCompany";
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
                var getAllCompanyURL = 'getAllCompanies';
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
    }
</script>

</body>
</html>