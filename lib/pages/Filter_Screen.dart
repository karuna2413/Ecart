import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:mangoit_ecart/provider/allproduct.dart';
import 'package:mangoit_ecart/provider/category.dart';
import 'package:mangoit_ecart/provider/colors.dart';
import 'package:mangoit_ecart/provider/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  int price = 100;
  double start = 0.0;
  double end = 1000.0;
  var page = 1;
  var result;
  var result1;
  var result2;
  var isCheck = false;
  var isColor;
  void filterItems(
      {selectedColor,
      selectedSize,
      selectedCategory,
      isCheck,
      page,
      start,
      end}) async {
    print(selectedColor);
    var res3 = await ref.read(apiGetAllProvider.notifier).getAllProducts(
        isFirst: true,
        selectedColor: colors,
        selectedSize: active1,
        id: active,
        check: isCheck,
        pageNo: page,
        start: start,
        end: end);
    Navigator.pop(context, {
      'selectedColor': colors,
      'selectedSize': active1,
      'id': active,
      'check': isCheck,
      'pageNo': page,
      'start': start,
      'end': end
    });
  }

  void storageData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    start =
        prefs.getDouble('price1') == null ? 0.0 : prefs.getDouble('price1')!;
    end =
        prefs.getDouble('price2') == null ? 1000.0 : prefs.getDouble('price2')!;
    colors = (prefs.getStringList('color') == null
        ? []
        : prefs.getStringList('color'))!;
    active = (prefs.getStringList('active') == null
        ? []
        : prefs.getStringList('active'))!;
    active1 = (prefs.getStringList('active1') == null
        ? []
        : prefs.getStringList('active1'))!;
  }

  void api() async {
    var res = await ref.read(colorsProvider.notifier).getAllColors();
    if (res.statusCode == 201) {
      print('successfull appi1');
      result = json.decode(res.body);
      setState(() {});
    } else {
      print('not valid 1');
    }
    var res1 = await ref.read(sizesProvider.notifier).getAllSizes();
    if (res1.statusCode == 201) {
      print('successfull appi2');
      result1 = json.decode(res1.body);
      print(result1['result']['size'][0]['AttributeOptions'].length);
      setState(() {});
    } else {
      print('not valid 2');
    }
    var res2 = await ref.read(categoryProvider.notifier).getAllCategories();
    if (res2.statusCode == 200) {
      print('successfull appi3');
      result2 = json.decode(res2.body);

      setState(() {});
    } else {
      print('not valid 3');
    }
  }

  @override
  void initState() {
    storageData();

    api();
    // TODO: implement initState
    super.initState();
  }

  @override
  int pressedAttentionIndex = -1;
  int pressedAttentionIndex1 = 1;
  List<String> active = [];
  List<String> active1 = [];
  List<String> colors = [];
  List<String> selectedColor = [];
  List<String> selectedSize = [];
  List<String> selectedCategory = [];
  bool isClicked = false;
  var k = 0;
  @override
  Widget build(BuildContext context) {
    return result == null || result1 == null || result2 == null
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                //replace with our own icon data.
              ),
            ),
            body: Center(child: CircularProgressIndicator()),
          )
        : SafeArea(
            child: Scaffold(
                backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  title: Center(child: Text('Filters')),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Price range',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 12.0),
                                          child: Text(
                                              '\$${start.toStringAsFixed(0)}'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, top: 12.0),
                                          child: Text(
                                              '\$${end.toStringAsFixed(0)}'),
                                        ),
                                      ],
                                    ),
                                    RangeSlider(
                                      activeColor:
                                          const Color.fromRGBO(255, 161, 19, 1),
                                      inactiveColor: const Color.fromRGBO(
                                          155, 155, 155, 1),
                                      values: RangeValues(start, end),
                                      labels: RangeLabels(
                                          start.toString(), end.toString()),
                                      onChanged: (value) {
                                        setState(() {
                                          start = value.start;
                                          end = value.end;
                                        });
                                      },
                                      min: 0.0,
                                      max: 1000.0,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              const Text(
                                'Colors',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: result['result']['colors'][0]
                                            ['AttributeOptions']
                                        .length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (colors.contains(result['result']
                                                          ['colors'][0]
                                                      ['AttributeOptions']
                                                  [index]['optionValue']
                                              .substring(1, 7))) {
                                            colors.remove(result['result']
                                                            ['colors'][0]
                                                        ['AttributeOptions']
                                                    [index]['optionValue']
                                                .substring(1, 7));
                                          } else {
                                            colors.add(result['result']
                                                            ['colors'][0]
                                                        ['AttributeOptions']
                                                    [index]['optionValue']
                                                .substring(1, 7));
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          color: Colors.grey.shade200,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 5,
                                                    color: colors.contains(result[
                                                                            'result']
                                                                        [
                                                                        'colors'][0]
                                                                    [
                                                                    'AttributeOptions']
                                                                [
                                                                index]['optionValue']
                                                            .substring(1, 7))
                                                        ? Colors.yellow.shade800
                                                        : Colors.white,
                                                  ),
                                                  color: Color(int.parse(
                                                          result['result']['colors']
                                                                              [
                                                                              0]
                                                                          [
                                                                          'AttributeOptions']
                                                                      [index][
                                                                  'optionValue']
                                                              .substring(1, 7),
                                                          radix: 16) +
                                                      0xFF000000),
                                                  shape: BoxShape.circle),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              const Text(
                                'Sizes',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: result1['result']['size'][0]
                                            ['AttributeOptions']
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    active1.contains(result1[
                                                                        'result']
                                                                    ['size'][0][
                                                                'AttributeOptions']
                                                            [
                                                            index]['optionValue'])
                                                        ? Colors.yellow.shade800
                                                        : Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    side: const BorderSide(
                                                        color: Colors.grey)),
                                              ),
                                              onPressed: () {
                                                if (active1.contains(result1[
                                                            'result']['size'][0]
                                                        ['AttributeOptions']
                                                    [index]['optionValue'])) {
                                                  active1.remove(result1[
                                                                      'result']
                                                                  ['size']
                                                              [0]
                                                          ['AttributeOptions']
                                                      [index]['optionValue']);
                                                } else {
                                                  active1.add(result1['result']
                                                              ['size'][0]
                                                          ['AttributeOptions']
                                                      [index]['optionValue']);
                                                }
                                                setState(() {});
                                              },
                                              child: Text(
                                                  result1['result']['size'][0]
                                                          ['AttributeOptions']
                                                      [index]['adminName'],
                                                  style: TextStyle(
                                                    color: active1.contains(result1[
                                                                        'result']
                                                                    ['size'][0][
                                                                'AttributeOptions']
                                                            [
                                                            index]['optionValue'])
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ))),
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              const Text(
                                'Category',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: result2['result']['data']['rows']
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4.0, right: 4.0),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  side: const BorderSide(
                                                      color: Colors.grey)),
                                              backgroundColor: active.contains(
                                                      result2['result']['data']
                                                                  ['rows']
                                                              [index]['id']
                                                          .toString())
                                                  ? Colors.yellow.shade800
                                                  : Colors.white,
                                            ),
                                            onPressed: () {
                                              if (active.contains(
                                                  result2['result']['data']
                                                          ['rows'][index]['id']
                                                      .toString())) {
                                                active.remove(result2['result']
                                                            ['data']['rows']
                                                        [index]['id']
                                                    .toString());
                                              } else {
                                                active.add(result2['result']
                                                            ['data']['rows']
                                                        [index]['id']
                                                    .toString());
                                              }
                                              setState(() {});
                                            },
                                            child: Text(
                                              result2['result']['data']['rows']
                                                          [index]
                                                      ['categoryTranslations']
                                                  [0]['name'],
                                              style: TextStyle(
                                                color: active.contains(
                                                        result2['result']
                                                                        ['data']
                                                                    ['rows']
                                                                [index]['id']
                                                            .toString())
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            )),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow.shade800),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Discard')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow.shade800),
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.remove('price1');
                                  await prefs.remove('price2');
                                  await prefs.remove('color');
                                  await prefs.remove('active');
                                  await prefs.remove('active1');

                                  filterItems(
                                      selectedColor: colors,
                                      selectedSize: active1,
                                      selectedCategory: active,
                                      isCheck: true,
                                      page: page,
                                      start: start.toInt(),
                                      end: end.toInt());

                                  await prefs.setDouble('price1', start);
                                  await prefs.setDouble('price2', end);
                                  await prefs.setStringList('active1', active1);

                                  await prefs.setStringList('active', active);
                                  await prefs.setStringList('color', colors);
                                },
                                child: const Text('Apply')),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          );
  }
}
