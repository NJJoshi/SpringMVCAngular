/**
 * Created by Nirav on 28-02-2016.
 */
var mainApp = angular.module("mainApp", []);

mainApp.controller('companyController', function($scope, $http) {
    loadCompanyGrid($scope, $http);
    createCompany($scope, $http);
    loadCompanyData($scope, $http);
    updateCompanyDetail($scope, $http);
});

/* Load all company grid data */
function loadCompanyGrid($scope, $http) {
    var getAllCompanyURL = 'company/all';
    $scope.detail = [];
    $http.get(getAllCompanyURL).success(function(response) {
        $scope.detail=response.companies;
    });
}

/* Load company data */
function loadCompanyData($scope, $http) {
    var selectedCompanyId;
    var loadCompanyDataURL = "company/";
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
    var updateCompanyURL = "company/detail/update";
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
            var getAllCompanyURL = 'company/all';
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
    var createCompanyURL = "company";
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
            var getAllCompanyURL = 'company/all';
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