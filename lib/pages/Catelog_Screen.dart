import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/provider/allproduct.dart';
import 'package:mangoit_ecart/provider/category.dart';
import 'dart:convert';
import 'package:mangoit_ecart/widgets/cardList.dart';

import '../widgets/card.dart';

class CatelogScreen extends ConsumerStatefulWidget {
  const CatelogScreen({super.key});

  @override
  ConsumerState<CatelogScreen> createState() => _CatelogScreenState();
}

class _CatelogScreenState extends ConsumerState<CatelogScreen> {
  bool changeColor = false;
  var result3;
  var id;
  var check;
  var totalCount = 59;
  var data = [];
  var data1;
  var totalPage = 6;
  var result, result1, pageNo = 1;
  var popData;
  var apiData;
  var isScroll;
  var isPop;
  var title;
  var isIcon = true;
  late ScrollController _controller;
  var selectedColor,
      selectedSize,
      selectedCategory,
      isCheck,
      page,
      start,
      end,
      isId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryapi();

    _controller = ScrollController()..addListener(loadData);
  }

  void loadData() async {
    if (data1.length < totalCount) {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        pageNo++;

        if (popData != null) {
          print('id${popData['id']}');
          print('start${popData['start']}');
          print('end${popData['end']}');
          // isPop=true;
          api(
              selectedColor: popData['selectedColor'],
              selectedSize: popData['selectedSize'],
              id: popData['id'],
              check: popData['check'],
              pageNo: pageNo,
              start: popData['start'],
              end: popData['end']);
        }
        else{
          api(id: isId, check: true, pageNo: pageNo);
        }
        // else if (isId != null && popData == null) {
        //   api(id: isId, check: true, pageNo: pageNo);
        // } else {
        //   api(id: null, check: null, pageNo: pageNo);
        // }
      }
    }
  }

  void categoryapi() async {
    var res1 = await ref.read(categoryProvider.notifier).getAllCategories();
    if (res1.statusCode == 200) {
      print('successfull appi1');
      result1 = json.decode(res1.body);
      result3 = result1['result']['data']
      ['rows'][0]['id'];

      setState(() {
        api(id: result3, check: true, pageNo: pageNo,isFirst:true);

      });
    } else {
      print('not valid 1');
    }
  }

  void api(
      {id,
      check,
      pageNo,
      isFirst,
      selectedColor,
      selectedSize,
      start,
      end}) async {
    print('apiid${id}');
    data1 = await ref.read(apiGetAllProvider.notifier).getAllProducts(
        isFirst: isFirst,
        selectedColor: selectedColor,
        selectedSize: selectedSize,
        id: [id],
        check: check,
        pageNo: pageNo,
        start: start,
        end: end);
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(loadData);
    super.dispose();
  }

  String? parsedstring;

  int pressedAttentionIndex = 0;
  @override
  Widget build(BuildContext context) {
    apiData = ref.read(apiGetAllProvider);
print('api${apiData}');
    double width = MediaQuery.of(context).size.width;
    return result1 == null
        ? Center(child: CircularProgressIndicator())
        : SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title == null
                        ? Center(
                            child: Text('Products',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18)),
                          )
                        : Center(
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: result1['result']['data']['rows'].length,
                          itemBuilder: (context, index) {
                            var pressAttention = pressedAttentionIndex == index;
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 4.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: pressAttention
                                            ? Colors.yellow.shade800
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() =>
                                            pressedAttentionIndex = index);
                                        isId = result1['result']['data']['rows']
                                            [index]['id'];
                                        title = result1['result']['data']
                                                ['rows'][index]
                                            ['categoryTranslations'][0]['name'];
                                        api(
                                            id: result1['result']['data']
                                                ['rows'][index]['id'],
                                            check: true,
                                            pageNo: 1,
                                            isFirst: true);
                                        setState(() {});
                                      },
                                      child: Text(result1['result']['data']
                                              ['rows'][index]
                                          ['categoryTranslations'][0]['name'])),
                                ),
                              ],
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () async {
                              popData =
                                  await Navigator.pushNamed(context, '/filter');
                              if (popData != null) {
                                setState(() {
                                  pressedAttentionIndex = -1;
                                });
                              }
                              else return;
                            },
                            icon: Icon(
                              Icons.filter_list_sharp,
                              color: Colors.black,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isIcon = !isIcon;
                              });
                            },
                            icon: isIcon
                                ? Icon(Icons.grid_view,
                                    color: Colors.black)
                                : Icon(
                                    Icons.format_list_bulleted_outlined,
                                    color: Colors.black,
                                  ))
                      ],
                    ),
                    apiData.length == 0
                        ? Center(
                            child: Text(
                            'no items',
                            style: TextStyle(color: Colors.black),
                          ))
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.67,
                            width: width,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: isIcon
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        controller: _controller,
                                        itemCount: apiData.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                // childAspectRatio: 0.6,
                                                childAspectRatio:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            1.1),
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 2.0,
                                                mainAxisSpacing: 2.0),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Center(
                                            child: CardWidget(
                                                name: apiData[index]
                                                                ['ProductFlat']
                                                            ['name'] ==
                                                        ''
                                                    ? 'shirts'
                                                    : apiData[index]
                                                        ['ProductFlat']['name'],
                                                price: apiData[index]
                                                    ['ProductFlat']['price'],
                                                img: apiData[index]['ProductImages']
                                                            .length ==
                                                        0
                                                    ? null
                                                    : apiData[index]
                                                            ['ProductImages'][0]
                                                        ['path'],
                                                value: '50%',
                                                color: Colors.yellow.shade800,
                                                id: apiData[index]['id']),
                                          );
                                        },
                                      )
                                    : ListView.builder(
                                        controller: _controller,
                                        itemCount: apiData.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12.0),
                                            child: CardList(
                                                name: apiData[index]['ProductFlat']
                                                            ['name'] ==
                                                        ''
                                                    ? 'shirts'
                                                    : apiData[index]
                                                        ['ProductFlat']['name'],
                                                price: apiData[index]
                                                    ['ProductFlat']['price'],
                                                img: apiData[index]['ProductImages']
                                                            .length ==
                                                        0
                                                    ? null
                                                    : apiData[index]['ProductImages']
                                                        [0]['path'],
                                                des: apiData[index]['ProductFlat']
                                                    ['description'],
                                                value: '50%',
                                                color: Colors.yellow.shade800,
                                                id: apiData[index]['id']),
                                          );
                                        })),
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
