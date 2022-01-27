import 'package:dipswitch_plus/rgb_color_picker.dart';
import 'package:dipswitch_plus/components/address_row.dart';
import 'package:dipswitch_plus/constants.dart';
import 'package:dipswitch_plus/components/dipswitch_row.dart';
import 'package:dipswitch_plus/components/section_card.dart';
import 'package:flutter/material.dart';


class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);
  @override
  _InputPageState createState() => _InputPageState();
}


class _InputPageState extends State<InputPage> {
  // color picker stuff START
  Color currentColor = Colors.deepPurple;
  List<Color> currentColors = [Colors.green, Colors.pink];
  List<Color> colorHistory = [];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);
  // color picker stuff END

  // address stuff START
  int address = 672;

  int getHundreds(int number){
    return ((address-address%100)/100).toInt();
  }

  int getTens(int number){
    return ((address-(address-address%100)-((address-(address-address%100))%10))/10).toInt();
  }
  int getOnes(int number){
    return (address-(address-address%100))%10.toInt();
  }

  void addressMinus100(){
    if(address>100){
      address=address-100;
    }else{
      address = address+500;
      if(address%100>11){
        address=(address-address%100)+11;
      }
    }
  }
  void addressPlus100(){
    if(address<411){
      address=address+100;
    }else if(address>500){
      address = address-500;
    }
    else{
      address=511;
    }
  }
  void addressMinus10(){
    if(getTens(address)>0){
      address = address-10;
    }else{
      if(getHundreds(address)>0){
        address = address-10;
      }else{
        addressMinus100();
      }
    }
  }
  void addressPlus10(){
    if(address<502){
      address = address + 10;
    }else if(address<510){
      address=510;
    }else{
      address = 1;
    }
  }
  void addressMinus1(){
    if(address>1){
      address--;
    }else{
      address=511;
    }
  }
  void addressPlus1(){
    if(address<511){
      address++;
    }else{
      address=1;
    }
  }
  // address stuff END


  // connection stuff START

  int colorToAddress(Color color){
    return 0;
  }

  // connection stuff END

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'DipSwitch Plus'
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Expanded(
            child: SectionCard(
              backgroundColor: kSectionCardBackgroundColor,
              cardChild: DipswitchRow(),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SectionCard(
                    backgroundColor: kSectionCardBackgroundColor,
                    //TODO 4: create a sound toggle option and icon
    
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SectionCard(
                    backgroundColor: kSectionCardBackgroundColor,
                    // cardChild: Text(test),
                    cardChild: AddressRow(
                      hundredsDigit: getHundreds(address),
                      tensDigit: getTens(address),
                      onesDigit: getOnes(address),
                      onPressMinusHundreds: (){
                        setState(() {
                          addressMinus100();
                        });
                      },
                      onPressPlusHundreds: (){
                        setState(() {
                          addressPlus100();
                        });
                      },
                      onPressMinusTens: (){
                        setState(() {
                          addressMinus10();
                        });
                      },
                      onPressPlusTens: (){
                        setState(() {
                          addressPlus10();
                        });
                      },
                      onPressMinusOnes: (){
                        setState(() {
                          addressMinus1();
                        });
                      },
                      onPressPlusOnes: (){
                        setState(() {
                          addressPlus1();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SectionCard(
              backgroundColor: currentColor.withAlpha(155),
              cardChild: RGBColorPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
