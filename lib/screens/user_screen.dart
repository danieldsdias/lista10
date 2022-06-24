// ignore_for_file: avoid_print

import 'dart:io';

import 'package:lista10_package/lista10_package.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  static const routeName = '/user';

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  File? image;

  void _signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    const double imageSize = 160;

    return Scaffold(
      appBar: AppBar(title: const Text('Usuário')),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            //Spacer(),
            ClipOval(
              child: image != null
                  ? ImageWidget(
                      image: image!,
                      onClicked: (source) => pickImage(source),
                      size: imageSize)
                  : const FlutterLogo(size: imageSize),
            ),
            const SizedBox(height: 24),
            image == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget.buildButton(
                          title: 'Galeria',
                          icon: Icons.image_outlined,
                          onClicked: () => pickImage(ImageSource.gallery)),
                      const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20)),
                      ImageWidget.buildButton(
                          title: 'Camera',
                          icon: Icons.camera_alt_outlined,
                          onClicked: () => pickImage(ImageSource.camera)),
                    ],
                  )
                : const SizedBox(height: 24),
            const Text(
              'Conectado como',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              user.email!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(
                Icons.arrow_back,
                size: 32,
              ),
              label: const Text('Sair'),
              onPressed: () => _signOut(context),
            )
          ],
        ),
      ),
    );
  }
}
