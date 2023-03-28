import 'package:e_commerce/data/api_manger.dart';
import 'package:e_commerce/home/details_screen.dart';
import 'package:e_commerce/home/smart_phone.dart';
import 'package:e_commerce/model/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:number_paginator/number_paginator.dart';
import '../model/product.dart';




class Home extends StatefulWidget {
  static const String route_name = "home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
int numberPage=10;
int currentPage =0;
int limit = 30;
late ScrollController scrollController;
bool shouldLoadNextPage = false;
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
String? select ="smartphones";

List<Product> product = [];
Function? onCategory;
@override
  void initState() {
    // TODO: implement initState
  scrollController = ScrollController();
    scrollController.addListener(() {
      if(scrollController.position.atEdge){
       bool isTop = scrollController.position.pixels==0;
        if(isTop){

        }else{
        //  print(limit);
          shouldLoadNextPage = true;
          setState(() {

          });
        }
        shouldLoadNextPage =true;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pages = List.generate(numberPage, (index) => ApiManger.getEccomerceModel(limit: limit,page: 20));
  if(shouldLoadNextPage==true){
    ApiManger.getEccomerceModel(limit: limit+=10).
    then((value) {
      print("limit $limit");
      if(value != null){
        print("product${value.products!.length}");
        setState(() {
         product.addAll(product);

          shouldLoadNextPage = false;
         print("product${value.products!.length}");
         print("limit $limit");
        });
      }
    });
  }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              value: select,
                items: list.map((e) => DropdownMenuItem(
                    value: e,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  SmartPhone()),
                        );
                       // Navigator.pushNamed(context, SmartPhone.route_name,arguments: list);
                      },
                      child: Text(e,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),
                      ),
                    ))).toList(),
                onChanged: (e)=>setState(() {
                  select=e;
                  onCategory!(e);
                })),
           IconButton(
               onPressed: (){
                 showSearch(context: context, delegate: NewSearch());
               },
               icon: Icon(Icons.search))
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder<Product>(
            future: ApiManger.getEccomerceModel(limit: limit+=10),
            builder: (context,snapshot){
              if(snapshot.hasError){
                return Text("Something wont wrong");
              }
              else if(snapshot.hasData){
                var product = snapshot.data!.products??[];
                if(product.isEmpty){
                  product = snapshot.data!.products??[];
                }
                // if(snapshot.data!.products![0].title != product.elementAt(0).title){
                //   product = snapshot.data!.products??[];
                // }
                return Column(
                  children: [

                    NumberPaginator(
                      config: NumberPaginatorUIConfig(
                        buttonSelectedBackgroundColor: Color(0xFF39A552),
                        buttonSelectedForegroundColor: Colors.blue,

                      ),
                      numberPages: numberPage,

                      onPageChange: (index){
                        setState(() {
                          currentPage=index;

                        // pages= ApiManger.getEccomerceModel()  ;

                        });
                      },
                    ),
                    Expanded(
                      child: GridView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          //  physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                              mainAxisExtent: 280
                          ),
                          itemCount:
                          product!.length,
                          // data!.products!.length,
                          itemBuilder: (context,index){
                           // final sortedItem = product.reversed.elementAt(index);
                         //   final item = sortedItem;
                            final sortedItem=  product.sort((a,b)=>a.rating!.compareTo(b.rating ));
                            final item1 = sortedItem;
                             product.forEach((item) {
                            item.rating;
                            print(item);
                             });
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  DetailsScreen(
                                    //  data.products!.elementAt(index).id!
                                      product!.elementAt(index).id!
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
                                          "${product!.elementAt(index).thumbnail}",
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
                                            "${product!.elementAt(index).title}",
                                      //"${item.title}",
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            //"${data!.products!.elementAt(index).price}"
                                            "price : ${product!.elementAt(index).price}",
                                           // "${item!.pric}",
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                          SizedBox(height: 15,),
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
                                              Text("${product!.elementAt(index).rating}",
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
                          }),
                    ),
                  ],
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }




              // if(snapshot.connectionState==ConnectionState.waiting){
              //   return Center(child: CircularProgressIndicator(),);
              // }else if(snapshot.hasData){
              //   var product = snapshot.data!.products??[];
              //   if(product.isEmpty){
              //     product = snapshot.data!.products??[];
              //   }
              //   return GridView.builder(
              //     controller: scrollController,
              //             shrinkWrap: true,
              //             //  physics: NeverScrollableScrollPhysics(),
              //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //                 crossAxisCount: 2,
              //                 crossAxisSpacing: 12.0,
              //                 mainAxisSpacing: 12.0,
              //                 mainAxisExtent: 250
              //             ),
              //             itemCount:
              //             product!.length,
              //            // data!.products!.length,
              //             itemBuilder: (context,index){
              //               return InkWell(
              //                 onTap: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(builder: (context) =>  DetailsScreen(
              //                       //  data.products!.elementAt(index).id!
              //                       product!.elementAt(index).id!
              //                     )),
              //                   );
              //
              //                 },
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                       color: Colors.redAccent.shade100,
              //                       borderRadius: BorderRadius.circular(16)
              //                   ),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.start,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       ClipRRect(
              //                           borderRadius: BorderRadius.only(
              //                               topRight: Radius.circular(16),
              //                               topLeft: Radius.circular(16)
              //                           ),
              //                           child: Image.network(
              //                            // "${data!.products!.elementAt(index).thumbnail}",
              //                                 "${product!.elementAt(index).thumbnail}",
              //                             height: 170,
              //                             width: double.infinity,
              //                             fit: BoxFit.cover,
              //                           )),
              //                       Padding(
              //                         padding: EdgeInsets.all(8),
              //                         child: Column(
              //                           mainAxisAlignment: MainAxisAlignment.start,
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           children: [
              //                             Text(
              //                               //"${data!.products!.elementAt(index).title}"
              //                               "${product!.elementAt(index).title}"
              //                               ,
              //                               style: TextStyle(
              //                                   color: Colors.black
              //                               ),
              //                             ),
              //                             Text(
              //                               //"${data!.products!.elementAt(index).price}"
              //                               "${product!.elementAt(index).price}"
              //                               ,
              //                               style: TextStyle(
              //                                   color: Colors.black
              //                               ),
              //                             ),
              //                             // RatingBar.builder(
              //                             //   initialRating: 3,
              //                             //   minRating: 1,
              //                             //   direction: Axis.horizontal,
              //                             //   allowHalfRating: true,
              //                             //   itemCount: 3,
              //                             //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              //                             //   itemBuilder: (context, _) => Icon(
              //                             //     Icons.star,
              //                             //     color: Colors.amber,
              //                             //     size: 15,
              //                             //   ),
              //                             //   onRatingUpdate: (rating) {
              //                             //     print(rating);
              //                             //   },
              //                             // ),
              //                           ],
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             });
              // }
           // return Center(child: CircularProgressIndicator(),);
            },
          )
          )
    );
  }

}

class NewSearch extends SearchDelegate{
  late Future<Search> search;
  NewSearch(){
    search = ApiManger.getSearchModel(search: query);
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: (){
        search = ApiManger.getSearchModel(search: query);
        showResults(context);
      },
          icon: Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.clear));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Search>(
        future: search,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasData){
            var data = snapshot.data;
            return ListView.separated(
                shrinkWrap: true,
                //  physics: NeverScrollableScrollPhysics(),
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 12.0,
                //     mainAxisSpacing: 12.0,
                //     mainAxisExtent: 250
                // ),
                itemCount:data!.products!.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  DetailsScreen(data.products!.elementAt(index).id!)),
                      );

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent.shade100,
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
                              child: Image.network("${data!.products!.elementAt(index).thumbnail}",
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
                                Text("${data!.products!.elementAt(index).title}",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                Text("${data!.products!.elementAt(index).price}",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
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
                }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 25,);
            },);
          }
          return Center(child: Text("${snapshot.error.toString()}"),);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Text("Suggesttion");
  }

}
