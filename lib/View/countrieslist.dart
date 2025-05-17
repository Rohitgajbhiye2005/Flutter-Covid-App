import 'package:covid_app/View/detailscreen.dart';
import 'package:covid_app/services/statesservices.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countrieslist extends StatefulWidget {
  const Countrieslist({super.key});

  @override
  State<Countrieslist> createState() => _CountrieslistState();
}

class _CountrieslistState extends State<Countrieslist> {
  Statesservices statesservices = Statesservices();
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchcontroller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with Country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesservices.fetchcountrylist(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
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
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        var countryData = snapshot.data![index];

                        if (searchcontroller.text.isEmpty ||
                            name.toLowerCase().contains(
                                searchcontroller.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Detailscreen(
                                        image: countryData['countryInfo']
                                            ['flag'],
                                        name: countryData['country'],
                                        totalCases: countryData['cases'],
                                        todayRecovered:
                                            countryData['todayRecovered'],
                                        totalDeaths: countryData['deaths'],
                                        active: countryData['active'],
                                        test: countryData['tests'],
                                        totalRecovered:
                                            countryData['recovered'],
                                        critical: countryData['critical'],
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(countryData['country']),
                                  subtitle:
                                      Text(countryData['cases'].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                        countryData['countryInfo']['flag']),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
