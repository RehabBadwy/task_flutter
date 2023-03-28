import 'package:e_commerce/home/details_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/api_manger.dart';
import '../model/product.dart';
import '../model/smart_phone_model.dart';

class SmartPhone extends StatelessWidget {
  static const String route_name= "smart";

  List<String> list= [
    "smartphones",
    "laptops",
    "fragrances",
    "skincare",
    "groceries",
    "home-decoration",
    "furniture",
    "tops",
    "womens-dresses",
    "womens-shoes",
    "mens-shirts",
    "mens-shoes",
    "mens-watches",
    "womens-watches",
    "womens-bags",
    "womens-jewellery",
    "sunglasses",
    "automotive",
    "motorcycle",
    "lighting"
  ];
  @override
  Widget build(BuildContext context) {
    List<Product> product = [];
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<SmartPhoneModel>(
          future: ApiManger.getCtaegoryModel(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasData){
              var data = snapshot.data;
              return  GridView.builder(

                  shrinkWrap: true,
                  //  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      mainAxisExtent: 280
                  ),
                  itemCount:
                  data!.products!.length,
                  // data!.products!.length,
                  itemBuilder: (context,index){
                    // final sortedItem = product.reversed.elementAt(index);
                    //   final item = sortedItem;
                    final sortedItem=  product.sort((a,b)=>a.products!.elementAt(index).rating!.compareTo(b.products!.elementAt(index).rating ));
                    final item1 = sortedItem;
                    product.forEach((item) {
                      item.products!.elementAt(index).rating;
                      print(item);
                    });
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  DetailsScreen(
                            //  data.products!.elementAt(index).id!
                             data.products!.elementAt(index).id!
                            //  item.id!,
                          )),
                        );

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF39A552),
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    topLeft: Radius.circular(16)
                                ),
                                child: Image.network(
                                  // "${data!.products!.elementAt(index).thumbnail}",
                                  "${data.products!.elementAt(index).thumbnail}",
                                  // "${item.thumbnail}",
                                  height: 170,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    //"${data!.products!.elementAt(index).title}"
                                    "${data.products!.elementAt(index).title}",
                                    //"${item.title}",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    //"${data!.products!.elementAt(index).price}"
                                    "Price : ${data.products!.elementAt(index).price}",
                                    // "${item!.pric}",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      // RatingBar.builder(
                                      //   initialRating: product!.elementAt(index).rating!,
                                      // //  minRating: 1,
                                      //   direction: Axis.horizontal,
                                      //   allowHalfRating: true,
                                      //   itemCount: 1,
                                      //  // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      //   itemBuilder: (context, _) => Icon(
                                      //     Icons.star,
                                      //     color: Colors.amber,
                                      //     size: 1,
                                      //   ),
                                      //   onRatingUpdate: (rating) {
                                      //     print(rating);
                                      //   },
                                      // ),
                                      Icon(Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      Icon(Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      Icon(Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      Icon(Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      Text("${data.products!.elementAt(index).rating}",
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  ),
                                  // RatingBar.builder(
                                  //   initialRating: 3,
                                  //   minRating: 1,
                                  //   direction: Axis.horizontal,
                                  //   allowHalfRating: true,
                                  //   itemCount: 3,
                                  //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  //   itemBuilder: (context, _) => Icon(
                                  //     Icons.star,
                                  //     color: Colors.amber,
                                  //     size: 15,
                                  //   ),
                                  //   onRatingUpdate: (rating) {
                                  //     print(rating);
                                  //   },
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Center(child: Text("${snapshot.error.toString()}"),);
          },
        ),
      ),
    );
  }

}
