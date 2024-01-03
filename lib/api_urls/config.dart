var baseUrl = 'https://lifeguardian.cyclic.app';

// sending data to server
var registerurl = '$baseUrl/api/agency/register';
var loginUrl = '$baseUrl/api/agency/login';
var logoutUserUrl = '$baseUrl/api/agency/logout';
var sendAlertUrl = '$baseUrl/api/alert/agency/sendalert';
var awarenessEventUrl = '$baseUrl/api/event/agency/add';
var rescueOperationUrl = '$baseUrl/api/rescueops/agency/start';
var cancelEventUrl = '$baseUrl/api/event/agency/cancel/';

// recieving data from server
var getAgencyHomeScreenUrl = '$baseUrl/api/agency/eventroperationcount';
var alertHistoryUrl = '$baseUrl/api/history/agency/alerts';
var eventHistoryUrl = '$baseUrl/api/history/agency/events';
var operationHistoryUrl = '$baseUrl/api/history/agency/operations';
var manageEventHistoryUrl = '$baseUrl/api/event/agency/list';
var eventRegisteredUsersList = '$baseUrl/api/event/agency/registrations/';

var googleMapsApiKey = 'AIzaSyCSpvganhtdZCMngmIVVuGFxr_tE533K4s';
