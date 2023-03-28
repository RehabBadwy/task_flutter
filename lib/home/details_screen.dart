import 'package:e_commerce/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/api_manger.dart';
import '../model/product_details.dart';

class DetailsScreen extends StatelessWidget {
 // static const String route_name="details";
  int id;
  DetailsScreen(this.id);
  @override
  Widget build(BuildContext context) {
   // var args = ModalRoute.of(context)!.settings.arguments as Products;
    return Scaffold(
      appBar: AppBar(
        title: Text("details"),
      ),
      body: FutureBuilder<ProductDetails>(
        future: ApiManger.getDetailsModel(id),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasData){
            var data = snapshot.data;
            return  Container(
              decoration: BoxDecoration(
                //  color: Colors.redAccent.shade100,
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16)
                        ),
                        child: Image.network("${data!.thumbnail}",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF39A552),
                          borderRadius:
                          BorderRadius.circular(12),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    'Decreiption :',
                                    style: TextStyle(
                                      color:  Colors.black,
                                      fontSize:  22,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '${data.description}',
                                    style: TextStyle(
                                      color:  Colors.white,
                                     //fontSize: width / 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    'Name :',
                                    style: TextStyle(
                                      color:  Colors.black,
                                       fontSize:  22,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '${data.title}',
                                    style: TextStyle(
                                      color:  Colors.white,
                                      //fontSize: width / 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    'Price :',
                                    style: TextStyle(
                                      color:  Colors.black,
                                       fontSize: 22,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '${data.price}',
                                    style: TextStyle(
                                      color:  Colors.white,
                                      fontSize:  22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    'Brand :',
                                    style: TextStyle(
                                      color:  Colors.black,
                                       fontSize:  22,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '${data.brand}',
                                    style: TextStyle(
                                      color:  Colors.white,
                                      //fontSize: width / 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    'Stock :',
                                    style: TextStyle(
                                      color:  Colors.black,
                                       fontSize:  22,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '${data.stock}',
                                    style: TextStyle(
                                      color:  Colors.white,
                                      //fontSize: width / 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),
                              RatingBar.builder(
                                initialRating: data!.rating!,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 15,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Something wont Wrong , Please Try Again Or Choose another Product",
            style: TextStyle(
              color: Colors.red
            ),
            ),),
          );
        },
      )
    );
  }
}
