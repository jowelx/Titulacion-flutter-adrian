import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future loginUser(String? username, String? password) async {
   try {
     var url = Uri.parse("https://backend-api-adrian-express.onrender.com/api/login");
     var queryParameters = {
       'email': username,
       'password': password,
     };
    var headers= {
       'Content-Type': 'application/x-www-form-urlencoded',   };
     var response = await http.post(url,body:queryParameters);

       var responseData = jsonDecode(response.body);
       return responseData;

   }catch(e){

     print(e);

   }
  }
  Future registerApplication (
    String? centroEstudios,
    String? carrera,
    String? jornada,
    String? nivelAcademico,
    String? paralelo,
    String? tipoMatricula,
    String? modalidad,
  ) async {
    try {
      var url = Uri.parse("https://backend-api-adrian-express.onrender.com/api/addEnrollment");
      var body = {
        'centroEstudios': centroEstudios,
        'carrera': carrera,
        'jornada': jornada,
        'nivelAcademico': nivelAcademico,
        'paralelo': paralelo,
        'tipoMatricula': tipoMatricula,
        'modalidad': modalidad,
      };
      var headers = {
        'Content-Type': 'application/json',
      };

      var response = await http.post(url, body: jsonEncode(body), headers: headers);

      var responseData = jsonDecode(response.body);
      return responseData;
    } catch (e) {
      print(e);
    }
  }
}