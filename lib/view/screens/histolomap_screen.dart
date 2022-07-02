import 'package:flutter/material.dart';
import 'package:nandorocha_histologia/view/widgets/appbar_widget.dart';
import 'package:nandorocha_histologia/view/widgets/gridview_widget.dart';
import 'package:nandorocha_histologia/view/widgets/raw_gesture_detector_widget.dart';

class HistoloMapScreen extends StatelessWidget {
  const HistoloMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          color: Colors.white,
          child: Center(
            child: RawGestureDetectorWidget(
              child: GridViewWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
