import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:pomo/gradient_background.dart';

class IconScreen extends StatefulWidget {
  const IconScreen({super.key});

  @override
  IconScreenState createState() => IconScreenState();
}

class IconScreenState extends State<IconScreen> {
  File? _imageFile; // Para armazenar a imagem selecionada
  final ImagePicker _picker = ImagePicker();

  // Função para pegar a imagem da galeria
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
          onTap: _pickImage,
          child: Column(
            children: [
              const SizedBox(height: 330),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/tomato_out.svg',
                    width: 280,
                  ),
                  // Verifica se uma imagem foi escolhida
                  _imageFile != null
                      ? ClipOval(
                          child: Image.file(
                            _imageFile!,
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 32, left: 12),
                          child: SvgPicture.asset(
                            'assets/images/tomato_in.svg',
                            width: 300,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
