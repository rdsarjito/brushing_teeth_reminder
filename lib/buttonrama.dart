import 'package:flutter/material.dart';

typedef OnPencet = void Function (String); 


class ButtonRama extends StatelessWidget {
  
  final String tulisan;
  final OnPencet onPencet;
  const ButtonRama(
    {super.key, required this.tulisan, required this.onPencet}
  );

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        // ElevatedButton(
        //   onPressed: () {
        //     onPencet("Rama");
        //   },
        //   child: Text("Test $tulisan"),
        // )
      ],
    );
  }
}