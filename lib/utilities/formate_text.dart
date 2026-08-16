

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/single_question_model.dart';

class FormatText{
  String? unFormattedQuestion;
  String unFormattedOptions;



  FormatText({required this.unFormattedOptions,this.unFormattedQuestion});
   static var formattedOptions=[].obs;
   static var formattedOptions_2=<List>[].obs;
   static var formattedQuestion=[].obs;
   static var correctAnswerIndex=[].obs;

  static List options=["A","B","C","D","E"];
  static var correctAnswerOption="";

   void formatAnswers(){
    //formattedQuestion.value=Bidi.stripHtmlIfNeeded(unFormattedQuestion??"");
    formattedQuestion.value.add(unFormattedQuestion!.replaceAll("\n", "")
        .replaceAll("<p>", "")
        .replaceAll("</p>", "")
        .replaceAll("<br />", "")
        .trim());
    var texts=Bidi.stripHtmlIfNeeded(unFormattedOptions);
    //var texts=unFormattedOptions.replaceAll("&nbsp", "");
    print(texts);
    print(formattedQuestion);
   // var formattedText=texts.split("///");
    var formattedText=unFormattedOptions.split("///");
    var answerIndex=formattedText.indexWhere((element) => element.contains("@@"));
    var answer=answerIndex<0?["",""]:formattedText.elementAt(answerIndex).split("@@");
    if(answerIndex>=0){
      formattedText[answerIndex]=answer[1];
    }
    formattedOptions_2.value.add(formattedText);
    correctAnswerIndex.value.add(answerIndex);
    print(formattedOptions_2);
  }


  static SingleQuestionModel getSingleFormattedQuestion(
      {required SingleQuestionModel unFormattedQuestion}){

     var formattedQuestion=SingleQuestionModel();
     formattedQuestion=unFormattedQuestion;
     formattedQuestion.correctAnswerIndex=getCorrectAnswerIndex(unformattedOption: unFormattedQuestion.options??"");
     formattedQuestion.correctAns=correctAnswerOption;
     formattedQuestion.formattedOptions=getFormattedOptions(unformattedOption: unFormattedQuestion.options??"");
     formattedQuestion.question=getFormattedQuestion(unformattedQuestion: formattedQuestion.question??"");
     //formattedQuestion.myOptions=[];
     return formattedQuestion;


  }


 static String getFormattedQuestion({required String unformattedQuestion}){
    return unformattedQuestion.replaceAll("\n", "")
        .replaceAll("<p>", "")
        .replaceAll("</p>", "")
        .replaceAll("<br />", "")
        .replaceAll("&nbsp;", "")
        .trim();
  }

  static List<String> getFormattedOptions({required String unformattedOption}){
    var formattedOptions=unformattedOption.replaceAll("@@","").split("///");
    return formattedOptions;
  }

  static getCorrectAnswerIndex({required String unformattedOption}){
     correctAnswerOption="";

    formattedOptions.value=unformattedOption.split("///");
    var answerIndex=formattedOptions.indexWhere((element) => element.contains("@@"));

    if(answerIndex>=0){
      formattedOptions[answerIndex]=formattedOptions[answerIndex].replaceAll("@@","");
      correctAnswerOption=options[answerIndex];
    }
  //  print("Correct Answer index: $answerIndex");
   // print("Correct Answer index: $correctAnswerOption");
    return answerIndex;
  }




}