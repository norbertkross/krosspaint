import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:krosspaint/Painter/paintingWidget.dart';

class DrawingPaint extends StatefulWidget {
  @override
  _DrawingPaintState createState() => _DrawingPaintState();
}

class _DrawingPaintState extends State<DrawingPaint> {
  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var rmicons = false;
  var closeManually = false;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.up;

  List<Offset> _points = <Offset>[];

  List<List<Offset>> allPoints = [];

  List<Color> chosenColors = [];

  List<double> chosenThickness = [];

  Color selectedColor = Colors.grey;

  double selectedThickness = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: (DragStartDetails dragUpdateDetails) {},
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox object = context.findRenderObject()! as RenderBox;
            Offset _localPosition =
                object.globalToLocal(details.globalPosition);
            _points.add(_localPosition);
            // allPoints.insert(allPoints.length, _points);
          });
        },
        onPanEnd: (DragEndDetails details) {
          setState(() {
            chosenColors.insert(allPoints.length, selectedColor);
            chosenThickness.insert(allPoints.length, selectedThickness);
            allPoints.add(_points);
            _points = List.from(_points)..clear();
          });
        },
        child: CustomPaint(
          isComplex: true,
          painter: Signature(points: allPoints, colr: chosenColors),
          size: Size.infinite,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.color_lens),
      //   // child: Icon(Icons.clear),
      //   onPressed: () {
      //     setState(() {
      //       selectedColor = Colors.pink;
      //       // allPoints.clear();
      //       // chosenColors.insert(allPoints.length - 1, Colors.pink);
      //     });
      //   },
      // ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        buttonSize: 56,
        label:
            extend ? const Text("Open") : null, // The label of the main button.
        /// The active label of the main button, Defaults to label if not specified.
        activeLabel: extend ? const Text("Close") : null,
        childrenButtonSize: 56.0,
        visible: visible,
        direction: speedDialDirection,
        switchLabelPosition: switchLabelPosition,

        /// If true user is forced to close dial manually
        closeManually: closeManually,

        /// If false, backgroundOverlay will not be rendered.
        renderOverlay: renderOverlay,
        // overlayColor: Colors.black,
        // overlayOpacity: 0.5,
        onOpen: () => debugPrint('OPENING DIAL'),
        onClose: () => debugPrint('DIAL CLOSED'),
        tooltip: 'Open',
        heroTag: 'speed-dial-hero-tag',
        elevation: 8.0,
        isOpenOnStart: false,
        animationSpeed: 300,
        children: [
          SpeedDialChild(
              child: !rmicons ? const Icon(Icons.color_lens_outlined) : null,
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              visible: true,
              onTap: () {
                setState(() {
                  selectedColor = Colors.pink;
                  chosenColors.insert(allPoints.length - 1, Colors.pink);
                });
              }),
          SpeedDialChild(
            child: !rmicons ? const Icon(Icons.brush) : null,
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            onTap: () {},
          ),
          SpeedDialChild(
            child: !rmicons ? const Icon(Icons.delete) : null,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            onTap: () {
              setState(() {
                allPoints.clear();
              });
            },
            visible: true,
          ),
          SpeedDialChild(
            child: !rmicons ? const Icon(Icons.undo) : null,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            onTap: () {
              setState(() {
                allPoints.removeLast();
              });
            },
          ),
        ],
      ),
    );
  }
}
