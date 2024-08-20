import 'package:covid19_tracking_app/Services/states_services.dart';
import 'package:covid19_tracking_app/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListsScreen extends StatefulWidget {
  const CountriesListsScreen({super.key});

  @override
  State<CountriesListsScreen> createState() => _CountriesListsScreenState();
}

class _CountriesListsScreenState extends State<CountriesListsScreen> 
{
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {

  StatesServices statesServices = StatesServices();

  return SafeArea(
  child: Scaffold(
  appBar: AppBar(
  elevation: 0,
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  ),


  body: Column(
  children: 
  [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
      onChanged: (value) 
      {
        setState(() {
           
        });  
      },
      controller: searchController,
      decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      ),
      hintText: 'Search with Country Name',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      ),
      ),
      ),
    ),

    Expanded(
    child: FutureBuilder(
    future: statesServices.countriesListApi(), 
    builder: (context, AsyncSnapshot<List<dynamic>> snapshot)
    {

      if(!snapshot.hasData)
      {
        return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index)
      {
        return Shimmer.fromColors( 
        baseColor: Colors.grey.shade700, 
        highlightColor: Colors.grey.shade100,
        child: Column(
        children: [
        
        ListTile(
        title: Container( 
        height: 10, 
        width: 90, 
        color: Colors.white,
        ),
        subtitle: Container( 
        height: 10, 
        width: 90, 
        color: Colors.white,
        ),
        leading: Container( 
        height: 50, 
        width: 50, 
        color: Colors.white,
        ),
        ),
        ],
        ),
        );
      }
      );

      }
      else
      {
        return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index)
        { 
          String name = snapshot.data![index]['country'];
          if(searchController.text.isEmpty)
          {
            return InkWell(
              onTap: () 
              {
                 Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => 
                DetailScreen(
                name: snapshot.data![index]['country'],
                image: snapshot.data![index]['countryInfo']['flag'],
                totalCases: snapshot.data![index]['cases'],
                todayRecovered: snapshot.data![index]['todayRecovered'],
                totalRecovered: snapshot.data![index]['recovered'],
                totalDeaths: snapshot.data![index]['deaths'],
                active: snapshot.data![index]['active'],
                critical: snapshot.data![index]['critical'],
                tests: snapshot.data![index]['tests'],
                ) 
                ),
                );
              },
              child: Column(
                      children: 
                      [
              ListTile(
              title: Text(snapshot.data![index]['country']),
              subtitle: Text(snapshot.data![index]['cases'].toString(),),
              leading: Image(
              height: 50,
              width: 50,
              image: NetworkImage(
              snapshot.data![index]['countryInfo']['flag'],
              ),
              ),
              ),
                      ],
                      ),
            );
          }
          else if(name.toLowerCase().contains(searchController.text.toLowerCase()))
          {
            return Column(
          children: 
          [
            InkWell(
              onTap: () 
              {
                 Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => 
                DetailScreen(
                name: snapshot.data![index]['country'],
                image: snapshot.data![index]['countryInfo']['flag'],
                totalCases: snapshot.data![index]['cases'],
                todayRecovered: snapshot.data![index]['todayRecovered'],
                totalRecovered: snapshot.data![index]['recovered'],
                totalDeaths: snapshot.data![index]['deaths'],
                active: snapshot.data![index]['active'],
                critical: snapshot.data![index]['critical'],
                tests: snapshot.data![index]['tests'],
                ) 
                ),
                );
              },
              child: ListTile(
              title: Text(snapshot.data![index]['country']),
              subtitle: Text(snapshot.data![index]['cases'].toString(),),
              leading: Image(
              height: 50,
              width: 50,
              image: NetworkImage(
              snapshot.data![index]['countryInfo']['flag'],
              ),
              ),
              ),
            ),
          ],
          );
          }
          else 
          {
            return Container();
          }



          // return Column(
          // children: 
          // [
          //   ListTile(
          //   title: Text(snapshot.data![index]['country']),
          //   subtitle: Text(snapshot.data![index]['cases'].toString(),),
          //   leading: Image(
          //   height: 50,
          //   width: 50,
          //   image: NetworkImage(
          //   snapshot.data![index]['countryInfo']['flag'],
          //   ),
          //   ),
          //   ),
          // ],
          // );
        }
        );
      }

      
    }
    ), 
    ),
  
  ],
  ),
  ),
  );
  }
}