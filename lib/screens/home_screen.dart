import 'package:flutter/material.dart';
import '../service/api_service.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String centroEstudios = '';
  String carrera = '';
  String jornada = '';
  String nivelAcademico = '';
  String paralelo = '';
  String tipoMatricula = '';
  String modalidad = '';

  void enviarFormulario()async {
    // Aquí puedes agregar la lógica para enviar los datos del formulario
    print('Enviando formulario...');
    var response=ApiService().registerApplication(centroEstudios,carrera,jornada,nivelAcademico,paralelo,tipoMatricula,modalidad);
  print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitud de Matriculacion'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child:SingleChildScrollView(
          child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('Centro de estudios'),
    TextFormField(
    onChanged: (value) {
    setState(() {
    centroEstudios = value;
    });
    },
    ),
    SizedBox(height: 16.0),
    Text('Carrera'),
    TextFormField(
    onChanged: (value) {
    setState(() {
    carrera = value;
    });
    },
    ),
    SizedBox(height: 16.0),
    Text('Jornada'),
    TextFormField(
    onChanged: (value) {
    setState(() {
    jornada = value;
    });
    },
    ),
    SizedBox(height: 16.0),
    Text('Nivel académico'),
    TextFormField(
    onChanged: (value) {
    setState(() {
    nivelAcademico = value;
    });
    },
    ),
    SizedBox(height: 16.0),
    Text('Paralelo'),
    TextFormField(
    onChanged: (value) {
    setState(() {
    paralelo = value;
    });
    },
    ),
    SizedBox(height: 16.0),
    Text('Tipo de matrícula'),
    TextFormField(
    onChanged: (value) {
    setState(() {
    tipoMatricula = value;
    });
    },
    ),
    SizedBox(height: 16.0),
    Text('Modalidad'),
    TextFormField(
    onChanged: (value) {
    setState(() {
    modalidad = value;
    });
    },
    ),
    SizedBox(height: 16.0),
    Center(
    child: ElevatedButton(
    onPressed: enviarFormulario,
    child: Text('Enviar'),
    ),
    ),
    ],
    ),
      ),
      ),
    );
  }
}
