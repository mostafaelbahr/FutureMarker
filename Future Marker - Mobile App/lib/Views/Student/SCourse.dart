import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:futuremarkerapp/Controllers/Student/CourseController.dart';
import 'package:futuremarkerapp/Controllers/Student/Grades.dart';
import 'package:futuremarkerapp/Controllers/Student/PostController.dart';
import 'package:futuremarkerapp/Controllers/Student/UserDataController.dart';
import 'package:futuremarkerapp/Views/Student/SAssignmentBody.dart';

import 'package:futuremarkerapp/Views/Student/SFolder.dart';
import 'package:futuremarkerapp/Views/Student/Suser_profile.dart';
import 'dart:async';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter/src/gestures/tap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class StudentCourse extends StatefulWidget {
  int CourseID;

  String CourseName, CourseDir;
  StudentCourse(this.CourseID, this.CourseName, this.CourseDir);

  @override
  _StudentCourseState createState() => _StudentCourseState();
}

class _StudentCourseState extends State<StudentCourse> {
  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  int postID;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _CommentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Folder'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: ' Folder Name',
                    ),
                    controller: _nameController,
                    validator: (value) => value.length >= 3
                        ? null
                        : 'Name should Contain at least 3 char',
                    onSaved: (value) => _nameController.text = value,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Create'),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  int index = 0;
  Color _iconColor = Colors.grey;
  int CommentCount;
  @override
  Widget build(BuildContext context) {
    Icon icone = Icon(Icons.favorite_border);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff263238),
        title: Text(widget.CourseName),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          indexcontroller.add(index);
        },
        controller: pageController,
        children: <Widget>[
          //Material screen
          Container(
            child: Stack(
              children: <Widget>[
                FutureBuilder(
                  future: Courses().CourseContent(widget.CourseID),
                  builder: (context, ss) {
                    if (ss.hasError) {
                      print('error');
                    }
                    if (ss.hasData) {
                      List myData = ss.data['material'];
                      print(myData);
                      return ListView.builder(
                          itemCount: myData.length,
                          itemBuilder: (context, position) {
                            Map myMap = myData[position];
                            List mylist = myMap['dir'];
                            print(
                                'aaaaaaaaaaaaaaaaaaaaaaaaaaa $mylist aaaaaaaaaaaaaaaaaaaaaa');
                            return myMap.keys.last == 'dir'
                                ? Container()
                                : SingleChildScrollView(
                                    child: Container(
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SFolderContent(
                                                                  widget
                                                                      .CourseID,
                                                                  myMap.values
                                                                      .last,
                                                                  widget
                                                                      .CourseDir,
                                                                  mylist)));
                                                },
                                                child: Card(
                                                  elevation: 5,
                                                  child: ListTile(
                                                    leading: Icon(Icons.folder),
                                                    title: Text(
                                                        '${myMap.values.last}'),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                          });
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          //assinments screen
          Container(
            child: Stack(
              children: <Widget>[
                FutureBuilder(
                  future: Courses().CourseContent(widget.CourseID),
                  builder: (context, ss) {
                    if (ss.hasError) {
                      print('error');
                    }
                    if (ss.hasData) {
                      List myData = ss.data['assignments'];
                      List mylist = ss.data['assignments_dec'];
                      List myatt = ss.data['assignment_attach'];

                      List maps = List();

                      myatt.forEach((e) {
                        if (e.isEmpty) {
                          print('hi');
                          maps.add({});
                        } else {
                          print('bye');
                          maps.add(e);
                        }
                      });
                      print(maps);
                      return ListView.builder(
                          itemCount: myData.length,
                          itemBuilder: (context, position) {
                            Map myMap = myData[position];
                            Map att = maps[position];

                            return SingleChildScrollView(
                              child: Container(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StudentAssignment(
                                                            myMap,
                                                            mylist[position],
                                                            att)));
                                          },
                                          child: Card(
                                            child: ListTile(
                                              leading: Icon(Icons.assignment),
                                              title: Text(
                                                  '${myMap['assignment_title']}'),
                                              subtitle: Text(
                                                  'Due ${myMap['assignment_deadline']}'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),

          Container(
            child: Stack(
              children: <Widget>[
                FutureBuilder(
                  future: Courses().CourseContent(widget.CourseID),
                  builder: (context, ss) {
                    if (ss.hasError) {
                      print('error');
                    }
                    if (ss.hasData) {
                      List myData = ss.data['quizzes'];


                      return ListView.builder(
                          itemCount: myData.length,
                          itemBuilder: (context, position) {
                            Map myMap = myData[position];

                            return SingleChildScrollView(
                              child: Container(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {launch('${UserData().imageurl}/student/course/startQuiz/${myMap['id']}');},
                                          child: Card(

                                            child: ListTile(
                                              leading: Icon(Icons.filter_frames),
                                              title: Text(
                                                  '${myMap['quiz_title']}'),
                                              subtitle: Text(
                                                  'Due ${myMap['quiz_deadline']}'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          //grades screen
          Container(
            child: FutureBuilder(
              future: Grade().courseGrade(widget.CourseID),
              builder: (context, ss) {
                if (ss.hasError) {
                  print('error');
                }
                if (ss.hasData) {
                  Map mymap = ss.data;
                  List assignment = mymap['finishedAssignments'];
                  List Quiz = mymap['finishedQuizzes'];

                  return SingleChildScrollView(
                    child: Card(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Container(
                                  child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Assignments",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 23,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: assignment.length,
                                      itemBuilder: (context, position) {
                                        Map Amap = assignment[position];
                                        return Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Text(
                                                  '${Amap['assignment']['assignment_title']}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  '${Amap['compilation_grade'] + Amap['style_grade'] + Amap['dynamic_test_grade'] + Amap['feature_test_grade']} %',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        );
                                      }),
                                  Divider(
                                    color: Colors.black38,
                                    height: 50,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Quizzes",
                                      style: TextStyle(
                                        //   color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 23,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: Quiz.length,
                                      itemBuilder: (context, position) {
                                        Map Qmap = Quiz[position];
                                        return Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Text(
                                                  '${Qmap['quiz']['quiz_title']}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  '${Qmap['quiz_grade'] }%',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        );
                                      }),
                                ],
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          //posts screen
          Container(
            child: Stack(
              children: <Widget>[
                FutureBuilder(
                    future: Courses().CourseContent(widget.CourseID),
                    builder: (context, ss) {
                      if (ss.hasError) {
                        print('error');
                      }
                      if (ss.hasData) {
                        var myData = ss.data['posts'].length > 1? ss.data['posts'] : {'1':ss.data['posts'][0]};
                        List<String> k_posts = [];
                        List<Map> v_posts = [];
                        myData.forEach((k, v) {
                          k_posts.add(k);
                          v_posts.add(v);
                        });

                        List myattch = ss.data['posts_attch'];

                        return ListView.builder(
                            itemCount: v_posts.length,
                            itemBuilder: (context, position1) {
                              Map myMap = v_posts[position1];
                              List comment = myMap['comments'];
                              postID = myMap['id'];

                              return SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Wrap(
                                            children: <Widget>[
                                              Text(
                                                '${myMap['user']['name']}',
                                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${myMap['created_at']}',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          Text(
                                              '${html2md.convert(myMap['post_content'])}',style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),),
                                          SizedBox(
                                            height: 15,
                                          ),

                                          ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount:
                                                  myattch[position1].length,
                                              itemBuilder: (context, position) {
                                                Map x = myattch[position1];
                                                List<String> y1 = [];
                                                List<String> y2 = [];
                                                x.forEach((x, y) {
                                                  y1.add(x);
                                                  y2.add(y);
                                                });

                                                return  Padding(
                                                  padding: const EdgeInsets.only(top: 18),
                                                  child: RichText(
                                                    text: new LinkTextSpan(
                                                        url:
                                                            '${UserData().imageurl}/${y2[position]}',
                                                        text: '${y1[position]}',
                                                        style:TextStyle(
                                                            color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 16)),
                                                  ),
                                                );
                                              }),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 16.0,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    showDialog<void>(
                                                      context: context,
                                                      barrierDismissible:
                                                          false, // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Add Comment'),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: ListBody(
                                                              children: <
                                                                  Widget>[
                                                                Form(
                                                                  key: _formKey,
                                                                  child:
                                                                      TextFormField(
                                                                    maxLines: 3,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          ' Write A Comment',
                                                                    ),
                                                                    controller:
                                                                        _CommentController,
                                                                    validator: (value) =>
                                                                        value.length >=
                                                                                3
                                                                            ? null
                                                                            : 'Comment should Contain at least 3 char',
                                                                    onSaved: (value) =>
                                                                        _CommentController.text =
                                                                            value,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                              child: Text(
                                                                  'Cancel'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            FlatButton(
                                                              child: Text(
                                                                  'Comment'),
                                                              onPressed: () {
                                                                var key = _formKey
                                                                    .currentState;
                                                                if (key
                                                                    .validate()) {
                                                                  key.save();

                                                                  setState(() {
                                                                    Post().createComment(
                                                                        _CommentController
                                                                            .text,
                                                                        myMap[
                                                                            'id']);

                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Icon(Icons.comment)),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text('${comment.length}'),
                                            ],
                                          ),
                                          Divider(),
                                          //Comments
                                          ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: comment.length,
                                              itemBuilder:
                                                  (context, position2) {
                                                Map mycomment =
                                                    comment[position2];

                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 40,
                                                            height: 40,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              border: Border.all(
                                                                  width: 3,
                                                                  color: Colors
                                                                      .white),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      '${UserData().imageurl}/${mycomment['user']['image']}'),
                                                                  fit: BoxFit
                                                                      .fill),
                                                            ),
                                                          ),
                                                          Text(
                                                              '${mycomment['user']['name']}',style: TextStyle(
                                                              fontWeight: FontWeight.bold,fontSize: 16))
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 40),
                                                        child: Text(
                                                            '${mycomment['comment_content']}',style: TextStyle(
                                                            fontWeight: FontWeight.bold,fontSize: 16)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
          //members screem
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: Courses().CourseContent(widget.CourseID),
                    builder: (context, ss) {
                      if (ss.hasError) {
                        print('erroe');
                      }
                      if (ss.hasData) {
                        List members = ss.data['users'];
                        return ListView.builder(
                            itemCount: members.length,
                            itemBuilder: (context, position) {
                              Map member = members[position];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => S_userProfile(
                                              member['id'], member['name'])));
                                },
                                child: Card(
                                  child: ListTile(
                                    leading: Container(
                                      width: 80,
                                      height: 100,
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 3, color: Colors.white),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${UserData().imageurl}/${member['image']}'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    title: Text('${member['name']}'),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              currentIndex: cIndex,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(
                    icon: Icon(Icons.book), title: Text('Material')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.assignment), title: Text('Assignments')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.filter_frames), title: Text('Quizzes')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.grade), title: Text('Grades')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.speaker_phone), title: Text('Updates')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.people), title: Text('Members')),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }),
    );
  }
}

class FancyBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final List<FancyBottomNavigationItem> items;
  final ValueChanged<int> onItemSelected;

  FancyBottomNavigation(
      {Key key,
      this.currentIndex = 0,
      this.iconSize = 24,
      this.activeColor,
      this.inactiveColor,
      this.backgroundColor,
      @required this.items,
      @required this.onItemSelected}) {
    assert(items != null);
    assert(onItemSelected != null);
  }

  @override
  _FancyBottomNavigationState createState() {
    return _FancyBottomNavigationState(
        items: items,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        iconSize: iconSize,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onItemSelected: onItemSelected);
  }
}

class _FancyBottomNavigationState extends State<FancyBottomNavigation> {
  final int currentIndex;
  final double iconSize;
  Color activeColor;
  Color inactiveColor;
  Color backgroundColor;
  List<FancyBottomNavigationItem> items;
  int _selectedIndex;
  ValueChanged<int> onItemSelected;

  _FancyBottomNavigationState(
      {@required this.items,
      this.currentIndex,
      this.activeColor,
      this.inactiveColor = Colors.black,
      this.backgroundColor,
      this.iconSize,
      @required this.onItemSelected}) {
    _selectedIndex = currentIndex;
  }

  Widget _buildItem(FancyBottomNavigationItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? 124 : 50,
      height: double.maxFinite,
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              color: Color(0xfff263238),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected ? backgroundColor : inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: TextStyle(color: backgroundColor),
                      child: item.title,
                    )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    activeColor =
        (activeColor == null) ? Theme.of(context).accentColor : activeColor;

    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              onItemSelected(index);

              setState(() {
                _selectedIndex = index;
              });
            },
            child: _buildItem(item, _selectedIndex == index),
          );
        }).toList(),
      ),
    );
  }
}

class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                launch(url);
              });
}

class FancyBottomNavigationItem {
  final Icon icon;
  final Text title;

  FancyBottomNavigationItem({
    @required this.icon,
    @required this.title,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}
