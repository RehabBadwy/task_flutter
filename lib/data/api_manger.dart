import 'dart:convert';
import 'package:e_commerce/model/product_details.dart';
import 'package:e_commerce/model/search.dart';
import 'package:http/http.dart' as http;
import '../model/product.dart';
import '../model/smart_phone_model.dart';

class ApiManger{

static const String baseUrl = "fakestoreapi.com";

static Future<SmartPhoneModel> getCtaegoryModel()async{
  var responce = await http.get(Uri.parse("https://dummyjson.com/products/category/smartphones",
  ));
  try{
    var json = jsonDecode(responce.body);
    print(responce.body);
    var smartPhoneModel = SmartPhoneModel.fromJson(json);
    return smartPhoneModel;
  }catch(exeption){
    throw exeption;
  }
}

  static Future<Product> getEccomerceModel({int? limit,int? page})async{
   var responce = await http.get(Uri.parse("https://dummyjson.com/products/?limit=$limit&page=$page",
   ));
   try{
     var json = jsonDecode(responce.body);
     print(responce.body);
     var eccomerce = Product.fromJson(json);
     return eccomerce;
   }catch(exeption){
     throw exeption;
   }
  }

static Future<ProductDetails> getDetailsModel(int id)async{
  var responce = await http.get(Uri.parse("https://dummyjson.com/products/$id"));
  try{
    var json = jsonDecode(responce.body);
    print(responce.body);
    var productDetails = ProductDetails.fromJson(json);
    return productDetails;
  }catch(exeption){
    throw exeption;
  }
}

static Future<Search> getSearchModel({String? search})async{
  var responce = await http.get(Uri.parse("https://dummyjson.com/products/search?q=$search"));
  try{
    var json = jsonDecode(responce.body);
    print("search${responce.body}");
    var search = Search.fromJson(json);
    return search;
  }catch(exeption){
    throw exeption;
  }
}
}