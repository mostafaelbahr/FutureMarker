import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:futuremarkerapp/Controllers/Instructor/CourseController.dart';
import 'package:futuremarkerapp/Views/Instructor/uplode_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../Widget/bezierContainer.dart';
import 'package:image/image.dart' as img;




class CreateCourse extends StatefulWidget {
  @override
  _CreateCourseState createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {

  @override
  void initState() {
    super.initState();
  }


  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfff263238), Color(0xfff668595)])),
      child: Text(
        'Create',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff263238),
        title: Center(child: Text('Create Course')),
        automaticallyImplyLeading: true,



      ),
      body:Container(
        height: height,
        child: Stack(
          children: <Widget>[

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 80,),
                    Text('Enter The Course Information' ,style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 22 ),),
                    SizedBox(height: 50),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 8.0),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(

                                hintText: ' Course Name',
                              ),
                              controller: _nameController,
                              validator: (value) => value.length >= 3
                                  ? null
                                  : 'Name should Contain at least 3 char',
                              onSaved: (value) =>
                              _nameController.text = value,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 8.0),
                            child: TextFormField(
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(

                                hintText: ' Course Description',
                              ),
                              controller: _descriptionController,
                              validator: (value) => value.length >= 20
                                  ? null
                                  : 'Description should Contain at least 20 char',
                              onSaved: (value) =>
                              _descriptionController.text = value,
                            ),
                          ),


                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    InkWell(
                        onTap: (){
                          Create();
                        },
                        child: _submitButton()),


                    SizedBox(height: height * .055),

                  ],
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
  Create(){
    var key = _formKey.currentState;
    if (key.validate()) {
      key.save();

      setState(() {
        Courses().createCourse(_nameController.text, _descriptionController.text);

        Navigator.pop(context);
      });
    }
  }
}
