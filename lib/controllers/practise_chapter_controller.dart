import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constraints/app_colors.dart';
import '../constraints/app_strings.dart';
import '../constraints/dimensions.dart';
import '../models/current_affairs_model.dart';
import '../models/get_all_questions_model.dart';
import '../models/my_review_list_model.dart';
import '../models/single_question_model.dart';
import '../services/remote_services.dart';
import '../utilities/formate_text.dart';
import '../utilities/show_snack_bar.dart';
import 'mistake_and_review_list_item_page_controller.dart';

class PractiseChapterController extends GetxController {
  var isPractise = true.obs;
  var isMistake = false.obs;
  var isReview = false.obs;
  var isLoadingMore = false.obs;
  var isCurrentWorld = false.obs;

  var id = "".obs;

  var isLoading = true.obs;
  var response = GetAllQuestionsModel().obs;

  var questions = <SingleQuestionModel>[].obs;
  var formattedQuestions = <SingleQuestionModel>[].obs;

  var myAnswers = [].obs;
  var correctAns = 0.obs;
  var wrongAns = 0.obs;
  var score = 0.0.obs;
  var optionsIndex = ["A", "B", "C", "D", "E", "F"];
  var reviewListModel = MyReviewListModel().obs;
  var myReviewList = [].obs;
  var isUpdating = false.obs;

  var endPoint = "".obs;
  var quizType = "chapterQuiz".obs; //chapterQuiz    or   modelTest
  var chapterId = "".obs;
  var testId = "".obs;

  var currentAffairsData=CurrentAffairsModel().obs;

  // var id="".obs;
  void getReviewList() async {
    myReviewList.value = [];
    var endPoint = AppStrings.myReviewListEndPoint;
    var data = await RemoteServices.getRequest(endPoint: endPoint);
    if (data != null) {
      reviewListModel.value = MyReviewListModel.fromJson(data);
      reviewListModel.value.data?.forEach((element) => myReviewList.add(element.qid));
    }
  }


  void selectAnswer(int index, dynamic answer) {
    myAnswers[index] = answer;
  }

  void fetchCurrentAffairsQuestion() async {
    formattedQuestions.value = [];
    // formattedOptions.value = [];
    FormatText.formattedOptions_2.value = [];
    FormatText.formattedQuestion.value = [];
    FormatText.correctAnswerIndex.value = [];
    isLoading.value = true;
    // var endPoint = AppStrings.getPractiseChapterEndPoint;
    var parameters ={"memberShip":"1"};
    try {
      var data = await RemoteServices.getRequest(
          endPoint: endPoint.value, parameters: parameters);
      if (data != null) {
        response.value = GetAllQuestionsModel.fromJson(data);
        questions.value = response.value.data?.data ?? [];
        for (SingleQuestionModel element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(unFormattedQuestion: element));
        }
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }



  void fetchDataWithChapterId({String? categoryId}) async {
    formattedQuestions.value = [];
    // formattedOptions.value = [];
    FormatText.formattedOptions_2.value = [];
    FormatText.formattedQuestion.value = [];
    FormatText.correctAnswerIndex.value = [];
    isLoading.value = true;
    // var endPoint = AppStrings.getPractiseChapterEndPoint;
    var parameters = quizType.value == "chapterQuiz"
        ? {
      "chapter": chapterId.value,
      "category_id":categoryId
    }
        : {"id": testId.value};
    try {
      var data = await RemoteServices.getRequest(
          endPoint: endPoint.value, parameters: parameters);
      if (data != null) {
        response.value = GetAllQuestionsModel.fromJson(data);
        questions.value = response.value.data?.data ?? [];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void fetchMistakeListData() async {
    formattedQuestions.value = [];
    // formattedOptions.value = [];
    FormatText.formattedOptions_2.value = [];
    FormatText.formattedQuestion.value = [];
    FormatText.correctAnswerIndex.value = [];
    //isLoading.value = true;
    var parameters = {"id": id.value};
    var endPoint = AppStrings.getMistakeListDataEndPoint;
    try {
      var data = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (data != null) {
        response.value = GetAllQuestionsModel.fromJson(data);
        questions.value = response.value.data?.data ?? [];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void fetchPracticeReviewListData(/*{required String endPoint}*/) async {
    formattedQuestions.value = [];
    // formattedOptions.value = [];
    FormatText.formattedOptions_2.value = [];
    FormatText.formattedQuestion.value = [];
    FormatText.correctAnswerIndex.value = [];
    var endPoint = AppStrings.getPracticeReviewListDataEndPoint;
    var parameters = {"id": id.value};
    try {
      var data = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (data != null) {
        response.value = GetAllQuestionsModel.fromJson(data);
        questions.value = response.value.data?.data ?? [];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void itemHitCount({required qId}) async {
    var endPoint = AppStrings.itemHitCountEndPoint;
    var parameters = {
      "qid": qId.toString(),
    };
    try {
      var data = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (data != null) {}
    } finally {}
  }

  void itemMistakeCount({required qId}) async {
    var endPoint = AppStrings.itemMistakeCountEndPoint;
    var parameters = {"qid": qId.toString()};
    try {
      var data = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (data != null) {}
    } finally {}
  }

  void optionClicked({required int questionIndex, required int optionIndex}) {
    if (formattedQuestions.value[questionIndex].correctAnswerIndex ==
        optionIndex) {
      HapticFeedback.selectionClick();
    } else {
      HapticFeedback.vibrate();
    }
    if (!myAnswers.value.contains(questionIndex)) {
      if (formattedQuestions.value[questionIndex].correctAnswerIndex ==
          optionIndex) {
        correctAns.value++;
        score.value++;
        RemoteServices.itemHitCount(
            qId: formattedQuestions[questionIndex].id.toString());
      } else {
        wrongAns.value++;
        score.value = score.value - .25;
        RemoteServices.itemHitCount(
            qId: formattedQuestions[questionIndex].id.toString());
        RemoteServices.itemMistakeCount(
            qId: formattedQuestions[questionIndex].id.toString(),
            chapterId: formattedQuestions[questionIndex].chapter ?? "");
      }
      myAnswers.value.add(questionIndex);
    }
    formattedQuestions.value[questionIndex].myOptions?.add(optionIndex);

    if(formattedQuestions.value[questionIndex].correctAnswerIndex !=
        optionIndex){
      formattedQuestions.value[questionIndex].myOptions?.add(formattedQuestions[questionIndex].correctAnswerIndex!);
    }

    formattedQuestions.refresh();
  }

  void addToReviewList({required String qid, required String chapterId}) async {
    isUpdating.value = true;
    var endPoint = AppStrings.addToReviewListEndPoint;
    var parameters = {"qid": qid, "chapter_id": chapterId};
    try {
      var data = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (data != null) {
        Get.closeAllSnackbars();
        CustomSnackBar(isSuccess: true, msg: data["msg"]).showSnackBar();
        myReviewList.add(int.parse(qid));
      }else{
        Get.closeAllSnackbars();
        CustomSnackBar(isSuccess: false, msg: AppStrings.httpErrorMSG.value).showSnackBar();
      }
    } finally {
      isUpdating.value = false;
    }
  }

  void removeFromReviewList({required String qid}) async {
    isUpdating.value = true;
    var endPoint = AppStrings.removeFromReviewListEndPoint;
    var parameters = {"qid": qid};
    try {
      var data = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);
      if (data != null) {
        Get.closeAllSnackbars();
        CustomSnackBar(isSuccess: true, msg: data["msg"]).showSnackBar();
        myReviewList.remove(int.parse(qid));
      }
    } finally {
      isUpdating.value = false;
    }
  }

  void removeFromMistakeListByQid({required int qId}) async {
    isUpdating.value = true;
    var endPoint = AppStrings.removeFromMistakeListByQIdEndPoint;
    var parameters = {"qid": qId.toString()};
    var data = await RemoteServices.getRequest(
        endPoint: endPoint, parameters: parameters);
    if (data != null) {
      formattedQuestions.value.removeWhere((element) => element.id == qId);
      response.value.data?.total = (response.value.data?.total ?? 0) - 1;
      // response.refresh();
      formattedQuestions.refresh();
      isUpdating.value = false;
    }
  }

  void removeFromPracticeReviewListByQid({required int qId}) async {
    isUpdating.value = true;
    var endPoint = AppStrings.removeFromReviewListByQIdEndPoint;
    var parameters = {"qid": qId.toString()};

    var data = await RemoteServices.getRequest(
        endPoint: endPoint, parameters: parameters);
    if (data != null) {
      formattedQuestions.value.removeWhere((element) => element.id == qId);
      response.value.data?.total = (response.value.data?.total ?? 0) - 1;
      formattedQuestions.refresh();
      isUpdating.value = false;
    }
  }

  void clearMistakeList() {
    if (formattedQuestions.value.isNotEmpty) {
      Get.defaultDialog(
          title: "Doy you really want to clear Mistake List?",
          //confirm: AppButton(bgColor:AppColors.appErrorColor, child: HeaderText(text: "Yes"), callback: (){}),
          //cancel: AppButton(bgColor:AppColors.appErrorColor, child: HeaderText(text: "No"), callback: (){}),
          textConfirm: "Yes",
          textCancel: "No",
          titlePadding: EdgeInsets.only(
              left: AppDimensions.leftPadding,
              right: AppDimensions.rightPadding,
              top: 20.h,
              bottom: 10.h),
          titleStyle: const TextStyle(color: AppColors.appSecondaryColor),
          confirmTextColor: Colors.white,
          cancelTextColor: AppColors.appPrimaryColor,
          middleText: "",
          buttonColor: AppColors.appPrimaryColor,
          onConfirm: () async {
            Get.back();
            isUpdating.value = true;
            var endPoint = AppStrings.clearMistakeListEndPoint;
            var parameters = {"id": id.value};
            var data = await RemoteServices.getRequest(
                endPoint: endPoint, parameters: parameters);
            if (data != null) {
              fetchMistakeListData();
              // formattedQuestions.value = [];
              // formattedQuestions.refresh();

              var mistakeAndReviewListController=Get.put(MistakeAndReviewController());
              mistakeAndReviewListController.getMistakeCategoryList();
              mistakeAndReviewListController.categoryList.refresh();
              myAnswers.value = [];
              correctAns.value = 0;
              wrongAns.value = 0;
              score.value = 0.0;
              isUpdating.value = false;
            }
          });
    } else {
      CustomSnackBar(isWarning: true, msg: "Your Mistake List is Empty!!!")
          .showSnackBar();
    }
  }
  void clearCurrentAffairsMistakeList() {
    if (formattedQuestions.value.isNotEmpty) {
      Get.defaultDialog(
          title: "Doy you really want to clear Mistake List?",
          //confirm: AppButton(bgColor:AppColors.appErrorColor, child: HeaderText(text: "Yes"), callback: (){}),
          //cancel: AppButton(bgColor:AppColors.appErrorColor, child: HeaderText(text: "No"), callback: (){}),
          textConfirm: "Yes",
          textCancel: "No",
          titlePadding: EdgeInsets.only(
              left: AppDimensions.leftPadding,
              right: AppDimensions.rightPadding,
              top: 20.h,
              bottom: 10.h),
          titleStyle: const TextStyle(color: AppColors.appSecondaryColor),
          confirmTextColor: Colors.white,
          cancelTextColor: AppColors.appPrimaryColor,
          middleText: "",
          buttonColor: AppColors.appPrimaryColor,
          onConfirm: () async {
            Get.back();
            isUpdating.value = true;
            var endPoint = AppStrings.clearCurrentAffairsMistakeListEndPoint;
            var data = await RemoteServices.getRequest(
                endPoint: endPoint);
            if (data != null) {
              fetchMistakeListData();
              var mistakeAndReviewListController=Get.put(MistakeAndReviewController());
              mistakeAndReviewListController.getMistakeCategoryList();
              mistakeAndReviewListController.categoryList.refresh();


              myAnswers.value = [];
              correctAns.value = 0;
              wrongAns.value = 0;
              score.value = 0.0;
              isUpdating.value = false;
            }
          });
    } else {
      CustomSnackBar(isWarning: true, msg: "Your Mistake List is Empty!!!")
          .showSnackBar();
    }
  }

  void clearReviewList() {
    if (formattedQuestions.value.isNotEmpty) {
      Get.defaultDialog(
          title: "Doy you really want to clear Review List?",
          //confirm: AppButton(bgColor:AppColors.appErrorColor, child: HeaderText(text: "Yes"), callback: (){}),
          //cancel: AppButton(bgColor:AppColors.appErrorColor, child: HeaderText(text: "No"), callback: (){}),
          textConfirm: "Yes",
          textCancel: "No",
          titlePadding: EdgeInsets.only(
              left: AppDimensions.leftPadding,
              right: AppDimensions.rightPadding,
              top: 20.h,
              bottom: 10.h),
          titleStyle: const TextStyle(color: AppColors.appSecondaryColor),
          confirmTextColor: Colors.white,
          cancelTextColor: AppColors.appPrimaryColor,
          middleText: "",
          buttonColor: AppColors.appPrimaryColor,
          onConfirm: () async {
            isUpdating.value = true;
            var endPoint = AppStrings.clearReviewListEndPoint;
            var parameters = {"id": id.value};

            try {
              var data = await RemoteServices.getRequest(
                  endPoint: endPoint, parameters: parameters);
              if (data != null) {
                fetchPracticeReviewListData();
                formattedQuestions.value = [];
                formattedQuestions.refresh();
                var mistakeAndReviewListController=Get.put(MistakeAndReviewController());
                mistakeAndReviewListController.getMistakeCategoryList();
                mistakeAndReviewListController.categoryList.refresh();
                myAnswers.value = [];
                correctAns.value = 0;
                wrongAns.value = 0;
                score.value = 0.0;
                isUpdating.value = false;
              }
            } finally {
              // TODO
              isUpdating.value=false;
            }
            Get.back();
          });
    } else {
      CustomSnackBar(isWarning: true, msg: "Your Review List is Empty!!!")
          .showSnackBar();
    }
  }
  void clearCurrentWorldReviewList() {
    if (formattedQuestions.value.isNotEmpty) {
      Get.defaultDialog(
          title: "Doy you really want to clear Review List?",
          textConfirm: "Yes",
          textCancel: "No",
          titlePadding: EdgeInsets.only(
              left: AppDimensions.leftPadding,
              right: AppDimensions.rightPadding,
              top: 20.h,
              bottom: 10.h),
          titleStyle: const TextStyle(color: AppColors.appSecondaryColor),
          confirmTextColor: Colors.white,
          cancelTextColor: AppColors.appPrimaryColor,
          middleText: "",
          buttonColor: AppColors.appPrimaryColor,
          onConfirm: () async {
            isUpdating.value = true;
            var endPoint = AppStrings.clearReviewListEndPoint;
            var parameters = {"id": id.value};

            try {
              var data = await RemoteServices.getRequest(
                  endPoint: endPoint, parameters: parameters);
              if (data != null) {
                fetchPracticeReviewListData();
                formattedQuestions.value = [];
                formattedQuestions.refresh();
                var mistakeAndReviewListController=Get.put(MistakeAndReviewController());
                mistakeAndReviewListController.getReviewCategoryList();
                mistakeAndReviewListController.categoryList.refresh();

                myAnswers.value = [];
                correctAns.value = 0;
                wrongAns.value = 0;
                score.value = 0.0;
                isUpdating.value = false;
              }
            } finally {
              // TODO
              isUpdating.value=false;
            }
            Get.back();
          });
    } else {
      CustomSnackBar(isWarning: true, msg: "Your Review List is Empty!!!")
          .showSnackBar();
    }
  }

  void loadMoreData() async {
    try {
      var parameters = quizType.value == "chapterQuiz"
          ? {
              "chapter": chapterId.value,
              "page": ((response.value.data?.currentPage ?? 0) + 1).toString()
            }
          : {
              "id": testId.value,
              "page": ((response.value.data?.currentPage ?? 0) + 1).toString()
            };

      var data = await RemoteServices.getRequest(
          endPoint: endPoint.value, parameters: parameters);

      /*var data=await RemoteServices.getRequestLoadMore(response.value.data?.nextPageUrl??"", {});*/
      if (data != null) {
        response.value = GetAllQuestionsModel.fromJson(data);
        questions.value = (response.value.data?.data ?? []);
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
      }
    } finally {
      isLoadingMore.value = false;
    }
  }

  void loadMoreMistakeData() async {
    try {
      var parameters = {
        "id": id.value,
        "page": ((response.value.data?.currentPage ?? 0) + 1).toString(),
      };

      var endPoint = AppStrings.getMistakeListDataEndPoint;
      var data = await RemoteServices.getRequest(
          endPoint: endPoint, parameters: parameters);

      /*var data=await RemoteServices.getRequestLoadMore(response.value.data?.nextPageUrl??"", {});*/
      if (data != null) {
        response.value = GetAllQuestionsModel.fromJson(data);
        questions.value = (response.value.data?.data ?? []);
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
      }
    } finally {
      isLoadingMore.value = false;
    }
  }

  void loadMoreReviewData() async {
    var parameters = isCurrentWorld.value
        ? {"page": ((response.value.data?.currentPage ?? 0) + 1).toString()}
        : {
            "id": id.value,
            "page": ((response.value.data?.currentPage ?? 0) + 1).toString(),
          };
    var endPoint = isCurrentWorld.value
        ? AppStrings.getCurrentWorldReviewListEndPoint
        : AppStrings.getPracticeReviewListDataEndPoint;
    try {
      var data = await RemoteServices.getRequest(
              endPoint: endPoint, parameters: parameters);
      if (data != null) {
        response.value = GetAllQuestionsModel.fromJson(data);
        questions.value = (response.value.data?.data ?? []);
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
      }
    } finally {
      isLoadingMore.value = false;
    }
  }

  void fetchPracticeCurrentAffairsReviewListData() async {
    formattedQuestions.value = [];
    FormatText.formattedOptions_2.value = [];
    FormatText.formattedQuestion.value = [];
    FormatText.correctAnswerIndex.value = [];
    var endPoint = AppStrings.getCurrentWorldReviewListEndPoint;

    try {
      var data = await RemoteServices.getRequest(endPoint: endPoint);
      if (data != null) {
        response.value = GetAllQuestionsModel.fromJson(data);
        questions.value = response.value.data?.data ?? [];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
      }
    } finally {
      isLoading.value = false;
    }
  }



  void fetchPracticeCurrentAffairsMistakeListData() async{
    formattedQuestions.value = [];
    FormatText.formattedOptions_2.value = [];
    FormatText.formattedQuestion.value = [];
    FormatText.correctAnswerIndex.value = [];

    var endPoint = AppStrings.getCurrentWorldMistakeListEndPoint;

    try {
      var data = await RemoteServices.getRequest(endPoint: endPoint);
      if (data != null) {
        response.value = GetAllQuestionsModel.fromJson(data);
        questions.value = response.value.data?.data ?? [];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  void resetStats() {
    isMistake.value = false;
    isReview.value = false;
    isPractise.value = false;
    isLoading.value = false;
  }
}
