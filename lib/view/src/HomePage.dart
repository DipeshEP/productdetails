import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productlist/constants/color.dart';
import 'package:productlist/control/cubit/product_cubit.dart';
import 'package:productlist/view/src/canvas.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {
  List smartPhone = [];
  List laptops = [];
  List skincare = [];
  List groceries = [];
  List homeDecoration = [];
  List selectedItem=[];
  int counter=0;
  late TabController controller=TabController(length: 5, vsync: this);
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colour.deepSeaBlue,
            ),
          );
        } else if (state is ProductLoaded) {
          final products = state.products;
          products.forEach((element) {
            if (element.category == 'smartphones') {
              smartPhone.add(element);
            } else if (element.category == 'laptops') {
              laptops.add(element);
            } else if (element.category == 'skincare') {
              skincare.add(element);
            } else if (element.category == 'groceries') {
              groceries.add(element);
            } else if (element.category == 'home-decoration') {
              homeDecoration.add(element);
            } else {}
          });
          return SafeArea(
            child: DefaultTabController(
              animationDuration: const Duration(microseconds: 20),
              length: 2,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size(double.infinity, 140),
                  child: AppBar(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: counter==0?Icon(Icons.add_shopping_cart,color: Colour.dayBlue,):TextButton(onPressed: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CanvasPage(listedProducts: selectedItem,)), (route) => false);
                        },child: Text("$counter", style: TextStyle(color: Colour.dayBlue),),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: IconButton(onPressed: (){
                        setState(() {
                          counter=0;
                          selectedItem.clear();
                        });
                        },icon: Icon(Icons.delete,color: Colour.dayBlue,),),
                      )
                    ],
                    title: Text(
                      "Product List",
                      style: TextStyle(color: Colour.dayBlue),
                    ),
                    centerTitle: true,
                    backgroundColor: Colour.deepSeaBlue,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    bottom: TabBar(
                      controller: controller,
                        unselectedLabelColor: Colour.lightBlue,
                        labelColor: Colour.dayBlue,
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colour.deepSeaBlue),
                        tabs: [
                          Tab(
                            child: InkWell(
                              onDoubleTap: (){
                                if(counter>6){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("You can't select more than 6 products" ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }else{
                                  setState(() {
                                    counter++;
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "SmartPhone",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                // border: Border.all(color: Colour.mintCream)
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("laptops",
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                // border: Border.all(color: Colour.mintCream)
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Skin care",
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                // border: Border.all(color: Colour.mintCream)
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Groceries",
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "HomeDecoration",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          controller: controller,
                          children: [
                            ListView.builder(
                              itemCount: smartPhone.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onDoubleTap: (){
                                    if(counter>=6){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("You can't select more than 6 products" ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }else{
                                      setState(() {
                                        counter++;
                                        selectedItem.add(smartPhone[index]);
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 250,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                              smartPhone[index].thumbnail,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(smartPhone[index].title),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: laptops.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onDoubleTap: (){
                                    if(counter>=6){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("You can't select more than 6 products" ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }else{
                                      setState(() {
                                        counter++;
                                        selectedItem.add(laptops[index]);

                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 250,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(laptops[index].thumbnail),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(laptops[index].title),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: skincare.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onDoubleTap: (){
                                    if(counter>=6){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("You can't select more than 6 products" ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }else{
                                      setState(() {
                                        counter++;
                                        selectedItem.add(skincare[index]);

                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 250,
                                    child: Column(
                                      children: [
                                        Image.network(
                                            skincare[index].thumbnail),
                                        Text(skincare[index].title)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: groceries.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onDoubleTap: (){
                                    if(counter>=6){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("You can't select more than 6 products" ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }else{
                                      setState(() {
                                        counter++;
                                        selectedItem.add(groceries[index]);

                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 250,
                                    child: Column(
                                      children: [
                                        Image.network(
                                            groceries[index].thumbnail),
                                        Text(groceries[index].title)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: homeDecoration.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onDoubleTap: (){
                                    if(counter>=6){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("You can't select more than 6 products" ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }else{
                                      setState(() {
                                        counter++;
                                        selectedItem.add(homeDecoration[index]);

                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 250,
                                    child: Column(
                                      children: [
                                        Image.network(
                                            homeDecoration[index].thumbnail),
                                        Text(homeDecoration[index].title)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is ProductError) {
          return const Center(
            child: Icon(
              Icons.error,
              color: Colour.deepSeaBlue,
            ),
          );
        } else {
          return Container(
            color: Colors.red,
          );
        }
      },
    );

  }
}
