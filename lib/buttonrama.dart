import 'package:flutter/material.dart';

class ButtonRama extends StatelessWidget {
  final String tulisan;
  final VoidCallback onPencet;
  const ButtonRama(
    {super.key, required this.tulisan, required this.onPencet}
  );

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            onPencet();
          },
          child: Text("Test $tulisan"),
        )
      ],
    );
  }
}