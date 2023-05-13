import 'package:eurovision_app/core/constants.dart';
import 'package:eurovision_app/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LyricsPage extends StatefulWidget {
  final Country country;
  const LyricsPage({
    super.key,
    required this.country,
  });

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  bool loaded = false;
  String lyrics = "";
  void loadAsset(String code) async {
    await rootBundle
        .loadString('assets/lyrics/${code.toUpperCase()}_EN.txt')
        .then((value) {
      loaded = true;
      lyrics = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    loadAsset(widget.country.code!);
    return Scaffold(
      body: loaded
          ? Stack(
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Text(lyrics),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: euroBlue,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: euroPink,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
