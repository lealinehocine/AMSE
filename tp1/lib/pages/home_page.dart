import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,  
      appBar: AppBar(
        title: Text('Accueil'),
        backgroundColor: Theme.of(context).colorScheme.primary,  
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue dans la Médiathèque',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Découvrez vos films et séries préférés',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),  
            Image.asset(
              '../../assets/images/image_accueil.png',  
              width: 200,  
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
