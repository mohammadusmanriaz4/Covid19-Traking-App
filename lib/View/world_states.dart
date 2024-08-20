import 'package:covid19_tracking_app/Model/world_states_model.dart';
import 'package:covid19_tracking_app/Services/states_services.dart';
import 'package:covid19_tracking_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';


class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin
{ 
  late final AnimationController _controller = AnimationController(
  duration: const Duration(seconds: 3),
  vsync: this)..repeat();


  @override
  void dispose ()
  {
    super.initState();
    _controller.dispose();
  }


  final colorList = <Color>
  [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),

  ];


  @override
  Widget build(BuildContext context) {
  
  StatesServices  statesServices = StatesServices();

  return SafeArea(
  child: Scaffold(
  
  body: Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
    children: [

    // SizedBox(
    // height: MediaQuery.of(context).size.height * 0.02,
    // ),

    FutureBuilder(
    future: statesServices.fecthWorldStatesRecords(), 
    builder: (context, AsyncSnapshot<WorldStatesModel> snapshot)
    {
      if(!snapshot.hasData)
      {
        return Expanded(
        flex: 1,
        child: SpinKitFadingCircle(
        color: Colors.white,
        size: 50,
        controller: _controller,
        ),
        );
      }
      else
      {
        return Column(
        children: [
        
    PieChart(
    dataMap:  
    {
    "Total":      double.parse(snapshot.data!.cases!.toString(),),
    "Recovered":  double.parse(snapshot.data!.recovered!.toString(),),
    "Deaths":     double.parse(snapshot.data!.deaths!.toString(),),
    },
    chartValuesOptions: const ChartValuesOptions(
    showChartValuesInPercentage: true,
    ),
    animationDuration: const Duration(
    microseconds: 1200,
    ),
    chartType: ChartType.ring,
    //chartType: ChartType.disc,
    colorList: 
    const [
     Color(0xff4285F4),
     Color(0xff1aa260),
     Color(0xffde5246),
    ],
    chartRadius: MediaQuery.of(context).size.width / 2.4,
    legendOptions: const  LegendOptions(
    legendPosition: LegendPosition.left,
    legendShape: BoxShape.circle,
    ),
    ),
    

    SizedBox(
    height: MediaQuery.of(context).size.height * 0.01,
    ),


    Padding(
      padding:  EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.height * 0.00,
      ),
      child: Card(
      child: Column(
      children: 
      [
        ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
        ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
        ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
        ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
        ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
        ReuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
        ReuseableRow(title: 'Today Recovered', value: snapshot.data!.recovered.toString()),
      ],
      ),
      ),
    ),

    SizedBox(
    height: MediaQuery.of(context).size.height * 0.01,
    ),

    GestureDetector(
      onTap: ()
      {
        Navigator.push(
        context, 
        MaterialPageRoute(
        builder: (context) => CountriesListsScreen(),
        )
        );
      },
      child: Container(
      height: 50,
      width: 150,
      decoration:  BoxDecoration(
      color: const Color(0xff1aa260),
      borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
      child: Text(
      'Track Countries',
      ),
      ),
      ),
    ),


        ],
        );
      }
    }
    ),

    
    ],
    ),
  ),
  ),
  );
  }
}



// ignore: must_be_immutable
class ReuseableRow extends StatelessWidget {
  String title, value;

  ReuseableRow
  ({
  super.key,
  required this.title,
  required this.value,
  });

  @override
  Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
    left:    10,
    right:   10,
    top:     10,
    bottom:   5,
    ),

    child: Column(
    children: [
    
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
  
      Text(title),
  
      Text(value),
    ],
    ),

    // const SizedBox(
    // height: 2,
    // ),
    Divider(),
  
  
    ],
    ),
  );


  }
}