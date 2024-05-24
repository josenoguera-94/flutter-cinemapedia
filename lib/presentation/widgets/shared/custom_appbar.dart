import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea( // SafeArea es un widget que se encarga de que el contenido no se superponga con el notch o la barra de estado
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10 ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon( Icons.movie_outlined, color: colors.primary ),
              const SizedBox( width: 5 ),
              Text('Cinemapedia', style: titleStyle ),
      
              const Spacer(), // Spacer es un widget que se encarga de ocupar todo el espacio posible
      
              IconButton(onPressed: (){
      
              }, 
              icon: const Icon(Icons.search)
              )
            ],
          ),
        ),
      )
    );
  }
}