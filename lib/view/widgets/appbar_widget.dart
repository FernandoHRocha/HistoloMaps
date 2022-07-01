import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nandorocha_histologia/view/shared/global.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Global.pink,
      bottom: PreferredSize(
        preferredSize: Size.zero,
        child: Column(
          children: const <Widget>[
            Text(
              'Lamina de Teste',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
