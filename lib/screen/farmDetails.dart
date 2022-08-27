import 'package:farmhouse_app/loader.dart';
import 'package:farmhouse_app/screen/availability.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farmhouse_app/authenticate/auth.dart';
import 'package:flutter/rendering.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:farmhouse_app/services/database.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class FarmDetails extends StatefulWidget {
  final Farm farm;
  const FarmDetails({Key key, this.farm}) : super(key: key);

  @override
  _FarmDetailsState createState() => _FarmDetailsState();
}

class _FarmDetailsState extends State<FarmDetails> {


  bool loader = false;

  int _index = 0;
  final controller = PageController(viewportFraction: 1);


  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    print('Maximum scrolling distance for scrolling component:${metrics.maxScrollExtent}');
    print('Current Scroll Position:${metrics.pixels}');
    return true;
  }


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    void _showAddCoursePanel(){
      showDialog(context: context, builder: (BuildContext context) {
        return Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
          //child: Enquiry(),
        );
      });
    }

    return StreamBuilder<List<FarmPics>>(
      stream: DatabaseService(category: widget.farm.category,title: widget.farm.title).farmPicsData,
      builder: (context,snapshot){
        if(snapshot.hasData){

          List<FarmPics> farmPics2 = snapshot.data;
          var farmPics =  farmPics2.where((p) => ('${p.pic}').toLowerCase().contains('https'.toLowerCase())).toList();


          return Container(
            height: h,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: h*0.35,
                    child: PageView.builder(
                      itemCount: farmPics.length,
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      onPageChanged: (int index) => setState(() => _index = index),
                      itemBuilder: (context,index){
                        return Transform.scale(
                          scale: index == _index ? 1 : 1,
                          child: Container(
                            height: h*0.35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Image.network(farmPics[index].pic,fit: BoxFit.cover),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 1),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: farmPics.length,
                        axisDirection: Axis.horizontal,
                        onDotClicked: (i) {
                          controller.animateToPage(
                            i,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        effect: SwapEffect(
                          //expansionFactor: 2,
                          spacing: 8,
                          radius: 10,
                          dotWidth: 10,
                          dotHeight: 10,
                          dotColor: Colors.black26,
                          activeDotColor: Colors.blue,
                          paintStyle: PaintingStyle.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                    child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(height: 0.5,),
                            SizedBox(height: h*0.02,),
                            Text(widget.farm.title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: h*0.03),),
                            SizedBox(height: h*0.015,),
                            Text(widget.farm.area,style: TextStyle(color: Colors.black54,fontSize: h*0.015),),
                            SizedBox(height: h*0.01,),
                            Text('RS: ${widget.farm.price}/head',style: TextStyle(color: Colors.green,fontSize: h*0.018),),
                            SizedBox(height: h*0.01,),
                            Text('Guest Capacity: ${widget.farm.guest}',style: TextStyle(color: Colors.black,fontSize: h*0.018),),
                            SizedBox(height: h*0.01,),
                            Text('Starting from: Rs.${widget.farm.starting}/-',style: TextStyle(color: Colors.black,fontSize: h*0.018),),
                            SizedBox(height: h*0.02,),
                            Divider(height: 0.5,),
                            SizedBox(height: h*0.02,),
                            Text('Contact Details',style: TextStyle(color: Colors.green[800],fontWeight: FontWeight.bold,fontSize: h*0.02),),
                            SizedBox(height: h*0.010,),
                            Text('${widget.farm.contact}',style: TextStyle(color: Colors.black,fontSize: h*0.018),),
                            SizedBox(height: h*0.02,),
                            Text('Amenities',style: TextStyle(color: Colors.black,fontSize: h*0.020,fontWeight: FontWeight.bold),),
                            SizedBox(height: h*0.010,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                widget.farm.wifi ?
                                Column(
                                  children: [
                                    Icon(Icons.wifi),
                                    SizedBox(height: h*0.005,),
                                    Text('Free Wi-fi'),
                                  ],
                                ) : Container(),
                                widget.farm.ac ?
                                Column(
                                  children: [
                                    Icon(Icons.ac_unit),
                                    SizedBox(height: h*0.005,),
                                    Text('AC'),
                                  ],
                                ) : Container(),
                                widget.farm.gym ?
                                Column(
                                  children: [
                                    Icon(Icons.fitness_center),
                                    SizedBox(height: h*0.005,),
                                    Text('Gym'),
                                  ],
                                ) : Container(),
                                widget.farm.pool ?
                                Column(
                                  children: [
                                    Icon(Icons.pool),
                                    SizedBox(height: h*0.005,),
                                    Text('Pool'),
                                  ],
                                ) : Container(width: 0),
                                widget.farm.bar ?
                                Column(
                                  children: [
                                    Icon(Icons.local_drink),
                                    SizedBox(height: h*0.005,),
                                    Text('Bar'),
                                  ],
                                ) : Container(width: 0),
                              ],
                            ),
                            SizedBox(height: h*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                widget.farm.tv ?
                                Column(
                                  children: [
                                    Icon(Icons.tv),
                                    SizedBox(height: h*0.005,),
                                    Text('TV'),
                                  ],
                                ) : Container(width: 0),
                                widget.farm.parking ?
                                Column(
                                  children: [
                                    Icon(Icons.car_repair),
                                    SizedBox(height: h*0.005,),
                                    Text('Parking'),
                                  ],
                                ) : Container(width: 0,),
                                widget.farm.dj ?
                                Column(
                                  children: [
                                    Icon(Icons.music_note),
                                    SizedBox(height: h*0.005,),
                                    Text('DJ Music'),
                                  ],
                                ) : Container(),
                                widget.farm.light ?
                                Column(
                                  children: [
                                    Icon(Icons.light),
                                    SizedBox(height: h*0.005,),
                                    Text('Lightning \n& Smoke'),
                                  ],
                                ) : Container(),
                                widget.farm.drones ?
                                Column(
                                  children: [
                                    Icon(Icons.airplanemode_active),
                                    SizedBox(height: h*0.005,),
                                    Text('Drones'),
                                  ],
                                ) : Container(),
                              ],
                            ),
                            SizedBox(height: h*0.03,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.farm.rating == '0' ?
                                Row(
                                  children: [
                                    Icon(Icons.star_border,size: h*0.025,),
                                    Icon(Icons.star_border,size: h*0.025,),
                                    Icon(Icons.star_border,size: h*0.025,),
                                    Icon(Icons.star_border,size: h*0.025,),
                                    Icon(Icons.star_border,size: h*0.025,),
                                  ],
                                ) : Container(),
                                widget.farm.rating == '1' ?
                                Row(
                                  children: [
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star_border,size: h*0.025,),
                                    Icon(Icons.star_border,size: h*0.025,),
                                    Icon(Icons.star_border,size: h*0.025,),
                                    Icon(Icons.star_border,size: h*0.025,),
                                  ],
                                ) : Container(),
                                widget.farm.rating == '2' ?
                                Row(
                                  children: [
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star_border,size: h*0.025,),
                                    Icon(Icons.star_border,size: h*0.025,),
                                    Icon(Icons.star_border,size: h*0.025,),
                                  ],
                                ) : Container(),
                                widget.farm.rating == '3' ?
                                Row(
                                  children: [
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star_border,size: h*0.025,),
                                    Icon(Icons.star_border,size: h*0.025,),
                                  ],
                                ) : Container(),
                                widget.farm.rating == '4' ?
                                Row(
                                  children: [
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star_border,size: h*0.025,),
                                  ],
                                ) : Container(),
                                widget.farm.rating == '5' ?
                                Row(
                                  children: [
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                    Icon(Icons.star,size: h*0.025,color: Colors.yellow[700],),
                                  ],
                                ) : Container(),
                              ],
                            )
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: h*0.01,),
                  ButtonTheme(
                    minWidth: w*0.9,
                    height: h*0.05,
                    child: RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
                      child: Text('CHECK AVAILABILITY',style: TextStyle(color: Colors.white,fontSize: h*0.02),),
                      onPressed: (){
                        // Navigator.pop(context);
                        Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: Availability(farmName: widget.farm.title,pic: widget.farm.pic1,user: user,)));
                      },
                    ),
                  ),
                  SizedBox(height: h*0.010,),
                ],
              ),
            ),

          );
        }else{
          return Loader();
        }
      },
    );
  }
}

