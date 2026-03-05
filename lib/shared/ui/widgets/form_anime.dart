import 'package:critijoy_note/shared/core/theme/app_theme.dart';
import 'package:critijoy_note/shared/ui/widgets/dropdowbutton.dart';
import 'package:critijoy_note/shared/ui/widgets/image_anime.dart';
import 'package:critijoy_note/shared/ui/widgets/input_form_field.dart';
import 'package:flutter/material.dart';

class FormAdd extends StatelessWidget {
  final void Function(bool option) onOptionSelected;

  const FormAdd({super.key, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            InputFormField(
              labelText: 'Titulo Anime/Serie:',
              maxLength: 25,
              keyboardType: TextInputType.text,
              labelfont: 20,
            ),
            SizedBox(height: 10),
            InputFormField(
              labelText: 'Sipnosis:',
              maxLength: 350,
              keyboardType: TextInputType.multiline,
              labelfont: 20,
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InputFormField(
                    labelText: 'Genero:',
                    maxLength: 10,
                    keyboardType: TextInputType.text,
                    labelfont: 15,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InputFormField(
                    labelText: 'Plataforma:',
                    maxLength: 12,
                    keyboardType: TextInputType.text,
                    labelfont: 15,
                    widht: 146,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InputFormField(
                    labelText: 'Total de Capitulos:',
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InputFormField(
                    labelText: 'Temporada/s:',
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InputFormField(
                    labelText: 'Personajes Favoritos:',
                    maxLength: 3,
                    keyboardType: TextInputType.text,
                    labelfont: 15,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: InputFormField(
                    labelText: 'Duración de Capitulos:',
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    labelfont: 15,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: DropDownButton(
                onOptionSelected: onOptionSelected,
                icon: Icons.menu,
              ),
            ),
            SizedBox(height: 15),
            ImageAnime(
              imagePath: 'assets/images/anime.png',
              borderRadius: 10,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(blue),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Agregar Imagen',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(lightgrey),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Quitar Imagen',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(darkBlue),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: Text('Agregar', style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
