import 'package:flutter/material.dart';

class AcercaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
             Navigator.pushReplacementNamed(context, 'perfil');
          },
        ),
        title: Text(
          'Acerca de...', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20), //Separacion entre el titulo y lo demas
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              
              constraints: BoxConstraints(
                maxHeight: 600, //valor del contenedor donde esta el texto
              ),
              child: SingleChildScrollView(
                child: Text(
                  '"VitalityConnect" se trata de una aplicacion creada por.....\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Integer dapibus sem ut mi dictum aliquet. In pellentesque nisi eget lorem sollicitudin, vel viverra justo vehicula. Phasellus cursus, ligula quis pljusto sagittis, et gravida libero vehicula. Integer et lorem dolor. Vestibulum eget eros vitae risus interdum dictum a sit amet justo. Proin eget pulvinar turpis.\n\n Ut sodales erat erat, ut pretium orci eleifend id. Aenean rutrum nibh at augue congue sollicitudin. Maecenas dapibus ullamcorper convallis. Vivamus eu lorem non purus porta fringilla. Phasellus neque ante, mattis vel sollicitudin ut, eleifend id sem. Aenean lacinia ligula eu quam tempus, vel gravida quam pretium. Suspendisse consequat quam in ornare tincidunt. Maecenas efficitur nec nunc quis porttitor. Sed eget erat eget urna efficitur efficitur. Morbi in dui nunc. Cras maximus sagittis tincidunt. Nunc nec felis mattis, sagittis ex eget, imperdiet urna. Suspendisse justo nulla, scelerisque eu porttitor et, scelerisque eget odio. Quisque id augue lorem. Praesent vel sem mollis, eleifend nulla et, volutpat turpis.', 
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20), // Espacio de 45 píxeles en la parte inferior
          ],
        ),
      ),
    );
  }
}
