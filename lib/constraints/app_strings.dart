import 'package:get/get.dart';

class AppStrings {
  static var httpErrorMSG = "".obs;

  //1
  static const String registrationEndPoint = "auth/register";

  //2
  static const String loginEmailEndPoint = "auth/login";

  //3
  static const String enrollmentListEndPoint = "ajax/common_dropdowns";

  //4
  static const String storeEnrollmentEndpoint =
      "ajax/store_user_enrollment_data";

//5
  static const getUserEnrollmentEndpoint = "ajax/get_user_enrollment_data";

//6
  static const getSubjectListEndPoint =
      "ajax/get_subject_and_data_list_by_group_id";

//7
  static const getChapterListEndPoint = "ajax/get_chapter_list_by_group_id";

//8
  static const getChapterDetailsEndPoint = "ajax/get_chapter_details";

//9
  static const getPractiseChapterEndPoint = "ajax/practice_chapter_wise_list";

//10
  static const itemHitCountEndPoint = "ajax/item_hit_count";

//11
  static const itemMistakeCountEndPoint =
      "ajax/item_mistake_count_with_make_practice_mistake";

//12
  static const myReviewListEndPoint = "ajax/practice_review_list_by_user_id";

//13
  static const addToReviewListEndPoint = "ajax/mark_item_for_review";

//14
  static const removeFromReviewListEndPoint =
      "ajax/remove_item_from_review_list";

//15  get chapter-wise quiz data
  static const quizTestEndPoint = "ajax/practice_chapter_wise_list_randomly";

//16 get model test question
  static const modelTestEndPoint = "ajax/get_model_test_question_by_test_id";

//17
  static const currentAffairsEndPoint = "ajax/get_current_affairs";

//18
  static const getModelTestListEndPoint = "ajax/all_list_by_category";

//19
  static const getPreviousYearQuestionsListEndPoint =
      "ajax/get_previous_year_model_test_by_category";

//20
  static const getQuizResultListEndPoint =
      "ajax/get_chapter_quiz_list_by_category";

//21
  static const getQuizDetailsByIdEndPoint = "ajax/get_quiz_details_by_quiz_id";

//22
  static const getModelTestResultListEndPoint =
      "ajax/get_model_test_list_by_category";

//23
  static const getModelTestResultDetailsByIdEndPoint =
      "ajax/get_model_test_result_by_quiz_id";

//24
  static const getJobTestResultListEndPoint =
      "ajax/get_job_test_report_list_by_category";

//25
  static const getMistakeListDataEndPoint =
      "ajax/practice_mistake_list_by_category";

//26
  static const getPracticeReviewListDataEndPoint =
      "ajax/answer_review_list_by_category";

//27
  static const removeFromMistakeListByQIdEndPoint =
      "ajax/delete_practice_mistake_item";

//28
  static const removeFromReviewListByQIdEndPoint =
      "ajax/delete_answer_review_item";

//29
  static const clearMistakeListEndPoint =
      "ajax/delete_practice_mistake_list_by_category";

//30
  static const clearReviewListEndPoint =
      "ajax/delete_answer_review_list_by_category";

//31
  static const getMeritListEndPoint =
      "ajax/get_model_test_participants_by_quiz_id?";

//32
  static const vocabularyMistakeCountEndPoint =
      "ajax/get_vocabulary_mistake_count";

//33
  static const getVocabularyQuestionEndPoint =
      "ajax/get_vocabulary_app_question_list";

//34
  static const storeVocabularyAnswerEndpoint =
      "ajax/store_user_vocabulary_info_with_points";

//35
  static const getRefineVocabularyQuestionEndPoint =
      "ajax/get_vocabulary_mistake_question_list";

//36
  static const storeRefineVocabularyAnswerEndPoint =
      "ajax/store_refine_vocabulary_info_with_points";

//37
  static const getStrengthAndWeaknessEndPoint =
      "ajax/get_user_strength_meters_list";

//38
  static const getHomePageDataEndPoint = "ajax/get_dashboard_data";

//39
  static const getDashBoardDataEndPoint = "ajax/get_mobile_dashboard_data";

//40
  static const getLastFiveModelTestEndpoint =
      "ajax/get_last_five_model_test_list_by_user";

//41
  static const updateUserProfileEndPoint = "ajax/update_user_info";

//42
  static const updatePasswordEndPoint = "ajax/update_user_password";

//43
  static const getAssessmentDataEndPoint = "ajax/get_assessment_test_data";

//44
  static const submitUserAssessmentDataEndPoint =
      "ajax/store_user_assessment_data";

//45
  static const getCourseDetailsEndPoint = "ajax/get_course_details";

//46
  static const storeChapterQuizDataEndPoint = "ajax/chapter_quiz_data_store";

//47
  static const storeModelTestQuizDataEndPoint = "ajax/model_quiz_data_store";

  //48
  static const getLiveTestListEndPoint = "ajax/live_list_by_category";

  //49
  static const getMembershipPlanEndPoint =
      "ajax/get_user_enrollment_with_category_price_data";

//50
  static const getReviewCategoryListEndPoint =
      "ajax/answer_review_category_list";

//51
  static const getMistakeCategoryListEndPoint =
      "ajax/practice_mistake_category_list";

//52
  static const getCurrentWorldReviewListEndPoint =
      "ajax/current_affairs_answer_review_list";

//53
  static const getCurrentWorldMistakeListEndPoint =
      "ajax/get_current_affairs_practice_mistake_list";

//54
  static const clearCurrentAffairsMistakeListEndPoint =
      "ajax/delete_current_affairs_practice_mistake_list";

//55
  static const clearCurrentAffairsReviewListEndPoint =
      "ajax/delete_current_affairs_answer_review_list";

//56
  static const getAppLinksEndPoint = "ajax/get_app_share_link";

//57
  static const getContactUsEndPoint = "ajax/get_studypress_contact_info";

//58
  static const getOrderIdEndPoint = "ajax/store_category_pricing_plan_data";

//59
  static const makePaymentEndPoint = "ajax/pay_via_ajax_for_ssl";

//60
  static const subscriptionDetailsEndPoint="ajax/get_order_details_by_id";

//61
  static const getVersionEndPoint="common-data";
 //62
  static const socialLoginEndpoint="auth/mobile_sociallogin/";

  //63
  static const currentAffairsMCQTestEndPoint="ajax/get_current_affairs_mcq_question";

  //64
  static const deleteAccountEndpoint="ajax/delete_user_info";
  //65
  static const requestOTP="auth/sendOtpForMobile";

  //66
  static var resendOTP="auth/sendOtpForMobile";

  //67
  static var verifyOTP="auth/verifyOtp";

  //68
  static var resetPassword="auth/passwordReset";

  static const performanceMessage="Not enough information! Try practising a few quizzes to see your performance stats.";




}
