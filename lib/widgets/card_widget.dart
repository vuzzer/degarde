import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final int index;
  const CardWidget({Key? key, this.index = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 8,
      child: Container(
          width: media.size.width * 0.6,
          height: 70,
          decoration: const BoxDecoration(color: CupertinoColors.activeGreen),
          child: Row(
            children: [
              Flexible(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CupertinoColors.activeBlue.withOpacity(0.4)),
              )),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: Column(
                    children:  const [
                      Text('Pharmacie rue 12'),
                    ],
                  ))
            ],
          )),
    );
  }
}
