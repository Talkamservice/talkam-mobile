import 'package:talkam/features/authentication/data/models/get_avatars_response.dart';
import 'package:talkam/features/post/data/models/update_profile_response.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';

abstract class ProfileRepository {
  Future<dynamic> uploadAvatar(String filePath);

  Future<UpdateProfileResponse> updateProfile(UpdateProfilePayload payload);

  Future<GetAvatarsResponse> getAvatars();
  Future<dynamic> blockUser(String userId);

}
