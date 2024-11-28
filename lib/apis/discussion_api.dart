import 'package:peer_instruction_student/models/discussion/discussion.dart';
import 'package:peer_instruction_student/models/discussion/review.dart';
import 'package:peer_instruction_student/models/result.dart';
import 'package:peer_instruction_student/utils/base_request.dart';

class DiscussionApi {
  static DiscussionApi? _instance;

  factory DiscussionApi() => _instance ?? DiscussionApi._internal();

  static DiscussionApi get instance => _instance ?? DiscussionApi._internal();

  DiscussionApi._internal();

  Future<bool> addDiscussion(int courseId, String title, String content) async {
    var json = await BaseRequest().request("/courses/$courseId/discussions",
        method: RequestMethod.post,
        data: {"discussion_title": title, "discussion_content": content});
    var res = Result<Null>.fromJson(json, (json) => null);
    return res.isSuccess;
  }

  Future<Result<DiscussionList>> getDiscussions(
      int courseId, int lastDiscussionId, int num) async {
    BaseRequest().openLog(requestBody: true, responseBody: true);
    var json = await BaseRequest().request("/courses/$courseId/discussions",
        queryParameters: {"last_discussion_id": lastDiscussionId, "num": num});
    var res = Result<DiscussionList>.fromJson(
        json, (json) => DiscussionList.fromJson(json));
    return res;
  }

  Future<bool> sendReview(
      int courseId, int discussionId, String reviewContent) async {
    var json = await BaseRequest().request(
        "/courses/$courseId/discussions/$discussionId/reviews",
        method: RequestMethod.post,
        data: {"review_content": reviewContent});
    var res = Result<Null>.fromJson(json, (json) => null);
    return res.isSuccess;
  }

  Future<Result<ReviewList>> getReviews(
      int courseId, int discussionId, int lastReviewId, int num) async {
    var json = await BaseRequest().request(
        "/courses/$courseId/discussions/$discussionId/reviews",
        queryParameters: {"last_review_id": lastReviewId, "num": num});
    var res =
        Result<ReviewList>.fromJson(json, (json) => ReviewList.fromJson(json));
    return res;
  }
}
