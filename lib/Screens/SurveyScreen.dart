import 'package:flutter/material.dart';
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
    print(questions.length);
    print(answerControllers.length);

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
              TextFormField(
                controller: answerControllers[0],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.favorite),
                  labelText: questions[0].text,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: answerControllers[1],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.favorite),
                  labelText: questions[1].text,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: answerControllers[2],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.favorite),
                  labelText: questions[2].text,
                ),
              ),
              SizedBox(height: 10),
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
