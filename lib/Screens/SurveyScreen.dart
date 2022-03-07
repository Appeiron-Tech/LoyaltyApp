import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:testing/Models/QuestionModel.dart';
import 'package:testing/Resources/firestore_methods.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final _formKey = GlobalKey<FormState>();
  List<QuestionModel> questions = [];
  List answerControllers = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    questions = await FirestoreMethods().getQuestions();
    for (var question in questions) {
      answerControllers.add(TextEditingController());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Encuesta')),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextFormField(
              //   controller: answerControllers[0],
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     icon: Icon(Icons.favorite),
              //     labelText: questions[0].text,
              //   ),
              // ),
              // SizedBox(height: 10),
              // TextFormField(
              //   controller: answerControllers[1],
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     icon: Icon(Icons.favorite),
              //     labelText: questions[1].text,
              //   ),
              // ),
              // SizedBox(height: 10),
              // TextFormField(
              //   controller: answerControllers[2],
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     icon: Icon(Icons.favorite),
              //     labelText: questions[2].text,
              //   ),
              // ),
              // SizedBox(height: 10),
              ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  late Widget element;
                  if (questions[index].type == "TEXT") {
                    element = TextFormField(
                      controller: answerControllers[index],
                      decoration: InputDecoration(
                        icon: Icon(Icons.favorite),
                        labelText: questions[index].text,
                      ),
                    );
                  } else if (questions[index].type == "SCALE") {
                    element = RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    );
                  }

                  return element;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // upload answers
                      var i = 0;
                      List answerIds = [];
                      for (var field in answerControllers) {
                        String res = await FirestoreMethods()
                            .uploadAnswer(questions[i].uid, field.text);
                        answerIds.add(res);
                        i++;
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}
