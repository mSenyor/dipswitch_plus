import 'package:dipswitch_plus/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'rgb_binary.dart';


class RGBColorPicker extends StatefulWidget {

  Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colorHistory;
  final ValueChanged<List<Color>>? onHistoryChanged;
  final List<Color>? paletteColors;


  RGBColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorHistory,
    this.onHistoryChanged,
    this.paletteColors,
  }) : super(key: key);

  @override
  _RGBColorPickerState createState() => _RGBColorPickerState();
}

class _RGBColorPickerState extends State<RGBColorPicker> {

  ColorModel _colorModel = ColorModel.rgb;
  bool _enableAlpha3 = false;
  bool _displayThumbColor3 = true;
  bool _showParams = true;
  bool _showIndicator = true;

  List makePaletteColors(){
    List colors = [];
    for(int i = 63; i>0; i--){
      colors.insert(
        0,
        Color(i),
      );
    }
    return colors;
  }

  Color integerToColor(int integer){
    Color color = Color(0xFFff00ff);

    return color;
  }

  List<Widget> makePalette(){
    List<Widget> palette = [];
    //   Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: getPicker(),
    // ),
    // ];
    List<List> rgbSteps = getRGBsteps();
    for(int i = 64; i>0; i--){
      Color currentColor = getColorFromRGB(rgbSteps.removeLast());
      palette.insert(
        0,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: (){
              setState(() {
                widget.pickerColor = currentColor;
              });
            },
            child: Container(),
            style: ElevatedButton.styleFrom(
              primary: currentColor,
              shadowColor: currentColor.withOpacity(1),
              elevation: 10,
            ),
          ),
        ),
      );
    }
    return palette;
  }

  ElevatedButton getPalette(){
    return ElevatedButton(
      onPressed: (){
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              titlePadding: const EdgeInsets.all(0),
              contentPadding: const EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25),),
              ),
              content: SingleChildScrollView(
                child: Palette(
                  pickerColor: widget.pickerColor,
                  onColorChanged: widget.onColorChanged,
                  // colorModel: _colorModel,
                  // enableAlpha: _enableAlpha3,
                  displayThumbColor: _displayThumbColor3,
                  // showParams: _showParams,
                  showIndicator: _showIndicator,
                  indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25),),

                ),
              ),
            );
          }
        );
      },
      child: Text(
        'Fixed Colors Palette'
      ),
    );
  }

  ElevatedButton test(){
    return ElevatedButton(
      onPressed: (){
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              titlePadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              content: Palette(
                pickerColor: widget.pickerColor,
                onColorChanged: widget.onColorChanged,
                displayThumbColor: _displayThumbColor3,
                showIndicator: _showIndicator,
              ),
            );
          }
        );
      },
      child: Text('test'),
    );
  }

  ElevatedButton getPicker(){
   return ElevatedButton(
     onPressed: (){
       showDialog(
         context: context,
         builder: (BuildContext context) {
           return AlertDialog(
             titlePadding: const EdgeInsets.all(0),
             contentPadding: const EdgeInsets.all(0),
             shape: const RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(25),),
             ),
             content: SingleChildScrollView(
               child: SlidePicker(
                 pickerColor: widget.pickerColor,
                 onColorChanged: widget.onColorChanged,
                 colorModel: _colorModel,
                 enableAlpha: _enableAlpha3,
                 displayThumbColor: _displayThumbColor3,
                 showParams: _showParams,
                 showIndicator: _showIndicator,
                 indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25),),
               ),
             ),
           );
         },
       );
     },

     child: Text(
       'RGB Color Picker',
       style: TextStyle(
         color: useWhiteForeground(widget.pickerColor)?Colors.white:Colors.black,
       ),
     ),
     style: ElevatedButton.styleFrom(
       primary: widget.pickerColor,
       shadowColor: widget.pickerColor.withOpacity(1),
       elevation: 10,
     ),
   );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getPicker(),
        test(),
      ],
    );

    // return getPicker();
    // return getPalette();
  }
}
// Expanded(
// child: GridView.count(
// crossAxisCount: 8,
// children: List.generate(
// 100, (index){
// return Center(
// child: Text(
// 'Item $index',
// style: Theme.of(context).textTheme.headline5,
// ),
// );
// },
// ),
// ),
// ),