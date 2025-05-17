import 'package:covid_app/View/countrieslist.dart';
import 'package:covid_app/model/worldstate.dart';
import 'package:covid_app/services/statesservices.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Worldstat extends StatefulWidget {
  const Worldstat({super.key});

  @override
  State<Worldstat> createState() => _WorldstatState();
}

class _WorldstatState extends State<Worldstat> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    
  }

  final colorlist=<Color>[
     Color(0xff4285F4),
      Color(0xff1aa260),
      Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    Statesservices statesservices=Statesservices();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),

            FutureBuilder(future: statesservices.fetchworldstates(), 
            builder: (context,AsyncSnapshot<worldstates>snapshot){
              if (!snapshot.hasData) {
                return Expanded(
                  flex: 1,
                  child:SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50,
                    controller: _controller,
                  ) 
                );
              }else{
                return Column(
                  children: [
                    PieChart(dataMap: {
              "Total":double.parse(snapshot.data!.cases!.toString()),
              "Recoverd":double.parse(snapshot.data!.recovered!.toString()),
              "Remaining":double.parse(snapshot.data!.deaths!.toString()),
              
            },
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
            chartRadius: MediaQuery.of(context).size.width/3.2,
            legendOptions: LegendOptions(
              legendPosition: LegendPosition.left,
            ),
            animationDuration: Duration(milliseconds: 1200),
            chartType: ChartType.ring,
            colorList:colorlist,
            ),
           
            Padding(
              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
              child: Card(
                child: Column(
                  children: [
                    Reusablerow(title: 'Total cases', value: snapshot.data!.cases!.toString()),
                    Reusablerow(title: 'Total deaths', value: snapshot.data!.deaths!.toString()),
                    Reusablerow(title: 'Total recovered', value: snapshot.data!.recovered!.toString()),
                    Reusablerow(title: 'Total active', value: snapshot.data!.active!.toString()),
                    Reusablerow(title: 'Total critical', value: snapshot.data!.critical!.toString()),
                    Reusablerow(title: 'Total todayDeaths', value: snapshot.data!.todayDeaths!.toString()),
                    Reusablerow(title: 'Total todayRecovered', value: snapshot.data!.todayRecovered!.toString()),
                  ],
                ),
              ),
              
            ),
            
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Countrieslist()));
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Color(0xff1aa260),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Track Countries')),
              ),
            )
                  ],
                );
              }
            }
            ),


            
          ],
        )
      ),
    );
  }
}


// ignore: must_be_immutable
class Reusablerow extends StatelessWidget {
  String title,value;
  Reusablerow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
      
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}