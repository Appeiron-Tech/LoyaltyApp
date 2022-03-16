import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:testing/Models/QuestionModel.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:testing/Screens/SurveySentScreen.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:testing/Widgets/appBar.dart';

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
      backgroundColor: linesColor,
      appBar: const AppBarWidget(
        appBarText: 'Cuestionario',
        appbackgroundColor: linesColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 35,
              width: MediaQuery.of(context).size.width * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text('Completa el cuestionario para recibir tus puntos.',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SurveySentPage(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      width: 110,
                      height: 110,
                      child: const Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xfff4797e),
                            Color(0xfffba4c2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // body: Form(
      //   key: _formKey,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       ListView.builder(
      //         itemCount: questions.length,
      //         itemBuilder: (context, index) {
      //           late Widget element;
      //           if (questions[index].type == "TEXT") {
      //             element = TextFormField(
      //               controller: answerControllers[index],
      //               decoration: InputDecoration(
      //                 icon: Icon(Icons.favorite),
      //                 labelText: questions[index].text,
      //               ),
      //             );
      //           } else if (questions[index].type == "SCALE") {
      //             element = RatingBar.builder(
      //               initialRating: 3,
      //               minRating: 1,
      //               direction: Axis.horizontal,
      //               allowHalfRating: true,
      //               itemCount: 5,
      //               itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      //               itemBuilder: (context, _) => const Icon(
      //                 Icons.star,
      //                 color: mainCTAColor,
      //               ),
      //               onRatingUpdate: (rating) {
      //                 print(rating);
      //               },
      //             );
      //           }

      //           return element;
      //         },
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 16.0),
      //         child: ElevatedButton(
      //           onPressed: () async {
      //             // Validate returns true if the form is valid, or false otherwise.
      //             if (_formKey.currentState!.validate()) {
      //               // upload answers
      //               var i = 0;
      //               List answerIds = [];
      //               for (var field in answerControllers) {
      //                 String res = await FirestoreMethods()
      //                     .uploadAnswer(questions[i].uid, field.text);
      //                 answerIds.add(res);
      //                 i++;
      //               }
      //             }
      //           },
      //           child: const Text('Submit'),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
