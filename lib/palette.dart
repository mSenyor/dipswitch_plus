import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'rgb_binary.dart';

class Palette extends StatefulWidget {
  Palette({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    // this.colorModel = ColorModel.rgb,
    this.enableAlpha = true,
    this.sliderSize = const Size(260, 40),
    this.showSliderText = true,
    @Deprecated('Use Theme.of(context).textTheme.bodyText1 & 2 to alter text style.')
    this.sliderTextStyle,
    this.showParams = true,
    @Deprecated('Use empty list in [labelTypes] to disable label.')
    this.showLabel = true,
    // this.labelTypes = const [],
    @Deprecated('Use Theme.of(context).textTheme.bodyText1 & 2 to alter text style.')
    this.labelTextStyle,
    this.showIndicator = true,
    this.indicatorSize = const Size(280, 50),
    this.indicatorAlignmentBegin = const Alignment(-1.0, -3.0),
    this.indicatorAlignmentEnd = const Alignment(1.0, 3.0),
    this.displayThumbColor = true,
    this.indicatorBorderRadius = const BorderRadius.all(Radius.zero),
  }) : super(key: key);

  Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  // final ColorModel colorModel;
  final bool enableAlpha;
  final Size sliderSize;
  final bool showSliderText;
  final TextStyle? sliderTextStyle;
  final bool showLabel;
  final bool showParams;
  // final List<ColorLabelType> labelTypes;
  final TextStyle? labelTextStyle;
  final bool showIndicator;
  final Size indicatorSize;
  final AlignmentGeometry indicatorAlignmentBegin;
  final AlignmentGeometry indicatorAlignmentEnd;
  final bool displayThumbColor;
  final BorderRadius indicatorBorderRadius;

  @override
  State<StatefulWidget> createState() => _PaletteState();
}

class _PaletteState extends State<Palette> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);

  @override
  void initState() {
    super.initState();
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  @override
  void didUpdateWidget(Palette oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  // Widget colorPickerSlider(TrackType trackType) {
  //   return ColorPickerSlider(
  //     trackType,
  //     currentHsvColor,
  //         (HSVColor color) {
  //       setState(() => currentHsvColor = color);
  //       widget.onColorChanged(currentHsvColor.toColor());
  //     },
  //     displayThumbColor: widget.displayThumbColor,
  //     fullThumbColor: true,
  //   );
  // }

  Widget indicator() {
    return ClipRRect(
      borderRadius: widget.indicatorBorderRadius,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GestureDetector(
        onTap: () {
          setState(
                  () => currentHsvColor = HSVColor.fromColor(widget.pickerColor));
          widget.onColorChanged(currentHsvColor.toColor());
        },
        child: Container(
          width: widget.indicatorSize.width,
          height: widget.indicatorSize.height,
          margin: const EdgeInsets.only(bottom: 15.0),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.pickerColor,
                widget.pickerColor,
                currentHsvColor.toColor(),
                currentHsvColor.toColor(),
              ],
              begin: widget.indicatorAlignmentBegin,
              end: widget.indicatorAlignmentEnd,
              stops: const [0.0, 0.5, 0.5, 1.0],
            ),
          ),
          // child: const CustomPaint(painter: CheckerPainter()),
        ),
      ),
    );
  }

  List<Widget> makePalette(){
    List<Widget> palette = [indicator(), SizedBox(height: 20.0,),];
    List<Widget> options = [];
    //   if (widget.showIndicator) indicator(),
    //   if (!widget.showIndicator) const SizedBox(height: 20),
    //   // ...sliders,
    //   const SizedBox(height: 20.0),
    // ],
    //   Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: getPicker(),
    // ),
    // ];
    List<List> rgbSteps = getRGBsteps();
    for(int i = 64; i>0; i--){
      Color currentColor = getColorFromRGB(rgbSteps.removeLast());
      options.insert(
        0,
        ElevatedButton(
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
      );
    }
    // palette.add(Text('test'),);
    // palette.add(options.removeAt(0));
    // palette.add(options.removeAt(0));
    // palette.add(options.removeAt(0)
    palette = getColorOptions(options, 4, 16);

    
    

    return palette;
  }

  Row getOptionRow(List options, int columns){
    List items = [];
    for(int i = columns; i >0; i--){
      items.add(options.removeAt(0));
    }
    return Row(
      children: <Widget>[
        ...items,
      ],
    );
  }
  
  List<Row> getColorOptions(List options, int columns, int rows){
    List<Row> readyRows = [];
    for(int i = rows; i > 0; i--){
      readyRows.add(getOptionRow(options, columns));
    }
    return readyRows;
  }



  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ...makePalette(),
        // if(widget.showIndicator) indicator(),
        // ...[
        //   Text('1'),
        //   Text('2'),
        //   Text('3'),
        //   ...getOptionRow(options, 4),
        // ],
      ],
    );

    // return ListView(
    //   children: makePalette(),
    // );
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: makePalette(),
      // <Widget>[
      //   if (widget.showIndicator) indicator(),
      //   if (!widget.showIndicator) const SizedBox(height: 20),
      //   // ...sliders,
      //   const SizedBox(height: 20.0),
      // ],
    // );
  }
}
