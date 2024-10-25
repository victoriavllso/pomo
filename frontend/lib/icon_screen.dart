import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'user_model.dart';
import 'gradient_background.dart';
import 'time_screen.dart';

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

  void _handleContinue() {
    // Removemos a obrigatoriedade de selecionar uma imagem
    // Se nenhuma imagem for selecionada, podemos usar um ícone padrão ou simplesmente continuar
    if (_imageFile != null) {
      // Atualiza o ícone no UserModel
      Provider.of<UserModel>(context, listen: false)
          .setIconPath(_imageFile!.path);
    } else {
      // Define um caminho padrão ou deixa vazio
      Provider.of<UserModel>(context, listen: false).setIconPath('');
    }
    // Navega para a próxima tela
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudyHoursScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        title: "Agora, **adicione um ícone** para seu perfil!",
        step: 2,
        totalSteps: 4,
        buttonName: "Continuar",
        buttonAction: _handleContinue,
        child: Center(
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
                        width: 240,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 32, left: 12),
                      child: SvgPicture.asset(
                        'assets/images/tomato_in.svg',
                        width: 240,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Toque na imagem para selecionar um ícone',
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}