import 'package:flutter/material.dart';
import 'package:piano_game/note.dart';
import 'package:piano_game/tile.dart';

class Line extends AnimatedWidget {
  final int lineNumber;
  final List<Note> currentNotes;
  final Function(Note) onTileTap;

  const Line(
      {Key key,
      this.currentNotes,
      this.onTileTap,
      this.lineNumber,
      Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    //for performing animation on tiles
    Animation<double> animation = super.listenable;
    double height = MediaQuery.of(context).size.height;
    double tileHeight = height / 4;
  //checking the notes index and putting it to the particular list
    List<Note> particularLine =
        currentNotes.where((note) => note.line == lineNumber).toList();
  //mapping the tiles x to y coordinate 
    List<Widget> tiles = particularLine.map((note) {
      //specify note distance from top
      int index = currentNotes.indexOf(note);
      double offset = (3 - index + animation.value) * tileHeight;

      return Transform.translate(
        offset: Offset(0, offset),
        child: Tile(
          height: tileHeight,
          state: note.state,
          onTap: () => onTileTap(note),
        ),
      );
    }).toList();

    return SizedBox.expand(
      child: Stack(
        children: tiles,
      ),
    );
  }
}
