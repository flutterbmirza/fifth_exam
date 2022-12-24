import 'package:fifth_exam/ui/pages/firebae_related_page/firebase_page.dart';
import 'package:flutter/material.dart';
import 'animated_page.dart';
import 'dio_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam 5'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 90.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (_) => StudentsPage()));
              }, child: Text('Firebase', style: TextStyle(color: Colors.orange),)),

              ElevatedButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (_) => UsersPage()));
              }, child: Text('Dio', style: TextStyle(color: Colors.lime),)),

              ElevatedButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (_) => AnimationPage()));
              }, child: Text('Animations', style: TextStyle(color: Colors.white70),)),
            ],
          ),
        ),
      ),
    );
  }
}