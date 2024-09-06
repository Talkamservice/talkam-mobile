import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/pusher/pusher_channel_service.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart';
import 'package:talkam/features/messaging/dormain/mixins/messaging_formater_mixin.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/dormain/repository/messaging_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

part 'messaging_state.dart';

part 'messaging_cubit.freezed.dart';

class MessagingCubit extends Cubit<MessagingState> with MessagingFormatterMixin {
  final MessagingRepository messagingRepository;

  TalkamConversation? currentConversation;
  List<AppMessageModel> messages = [];
  final ScrollController listController = ScrollController();

  MessagingCubit(
    this.messagingRepository,
  ) : super(const MessagingState.initial());

  Future<void> sendMessage(AppMessageModel message) async {
    var newMessages = sortAndInsertDividers([
      message,
      ...messages,
    ]);
    messages.clear();
    messages = sortAndInsertDividers(newMessages
      ..removeWhere(
        (element) => element.messageType == "divider",
      ));

    logger.w("cjns");

    emit(const MessagingState.sendMessageLoading());
    // listController.jumpTo(0);

    try {
      final response = await messagingRepository.sendMessage(message);

      logger.w("NO WAY MY ID IS ${injector.get<ProfileBloc>().appUser?.id}");
      logger.w("NO CONVERSATION ID IS ${currentConversation!.id}");

      _listenForMessages(currentConversation!.id.toString());

      messages.where((element) => element.id == message.id).first.sendingState = SendingState.success;

      emit(MessagingState.sendMessageSuccess(response));
    } catch (e) {
      messages.where((element) => element.id == message.id).first.sendingState = SendingState.failed;
      emit(MessagingState.sendMessageFailure(e.toString()));
    }
  }

  Future<void> getMessages(String conversationId, {bool? refresh = true}) async {
    if (refresh!) {
      emit(const MessagingState.fetchCurrentConversationLoading());
    }

    try {
      final response = await messagingRepository.getMessages(conversationId);
      messages = sortAndInsertDividers(response.data.data
          .map(
            (e) => AppMessageModel.fromResponse(e),
          )
          .toList()
        ..removeWhere(
          (element) => element.messageType == "divider",
        ));
      emit(MessagingState.getMessagesSuccess(response));
      _listenForMessages(currentConversation!.id.toString());
    } catch (e, stack) {
      emit(MessagingState.getMessagesFailure(e.toString()));
    }
  }

  Future<void> deleteConversation(String id) async {
    emit(const MessagingState.deleteConversationLoading());
    try {
      await messagingRepository.deleteConversation(id);
      emit(const MessagingState.deleteConversationSuccess());
    } catch (e, stack) {
      emit(MessagingState.deleteConversationFailure(e.toString()));
    }
  }

  Future<void> fetchCurrentConversation(String receiverId, {bool? refresh = true}) async {
    if (refresh!) {
      emit(const MessagingState.fetchCurrentConversationLoading());
    }

    try {
      final response = await messagingRepository.fetchCurrentConversation(receiverId);

      currentConversation = response;

      getMessages(response.id.toString(), refresh: refresh);
      // emit(MessagingState.fetchCurrentConversationSuccess(response));
    } catch (e, stack) {
      emit(MessagingState.fetchCurrentConversationFailure(e.toString()));
    }
  }

  Future<void> updateConversationStatus({required String conversationId, required String status}) async {
    emit(const MessagingState.updateConversationStatusLoading());
    try {
      final response = await messagingRepository.updateConversationStatus(conversationId: conversationId, status: status);
      currentConversation = null;

      emit(MessagingState.updateConversationStatusSuccess(response));
    } catch (e, stack) {
      emit(MessagingState.updateConversationStatusFailure(e.toString()));
    }
  }

  void init({TalkamConversation? conversation, required String receiverId}) {
    if (conversation == null) {
      fetchCurrentConversation(receiverId);
    } else {
      currentConversation = conversation;
      emit(MessagingState.fetchCurrentConversationSuccess(currentConversation!));
    }
  }

  void _listenForMessages(String conversationId) async {
    logger.w('listening');

    try {
      var pusherService = await PusherChannelService.getInstance;
      var pusher = await pusherService.getClient;
      if (pusher != null) {
        logger.w('connecting');

        if (!pusher.channels.containsKey("private-conversation.$conversationId")) {
          pusher.onAuthorizer = _authorize;

          PusherChannel channel = await pusher.subscribe(
            channelName: "private-conversation.$conversationId",
            onSubscriptionError: (message, d) => onSubscriptionError(message, d),
            onSubscriptionSucceeded: (data) {
              // log('subscribed');
              // AppUtils.showCustomToast("onSubscriptionSucceeded:  data: $data");
              // return data;a
            },
            onEvent: (event) => onEventReceived(event),
          );
          logger.w('connected');
        } else {
          logger.w('connected2');
          pusher.onAuthorizer = _authorize;

          pusher.getChannel("private-conversation.${currentConversation?.id}")?.onEvent = onEventReceived;
        }
        await pusher.connect();
      }
    } catch (e, s) {
      logger.w(e.toString());
      // SentryService.captureException(e, stackTrace: s);
    }
  }

  _authorize(String channelName, String socketId, options) async {
    return {
      "auth": "1934aa1e05c3acfdfd3f:${getSignature("$socketId:private-conversation.${currentConversation!.id.toString()}")}",
    };
  }

  getSignature(String value) {
    var key = utf8.encode('0bfd461496258bd6e236');
    var bytes = utf8.encode(value);
    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    print("HMAC signature in string is: $digest");
    return digest;
  }

  onSubscriptionError(message, d) {
    logger.e(message);
  }

  onEventReceived(event) {
    try {
      var receivedEvent = (event as PusherEvent);
      logger.i('received chat message${receivedEvent.data}');

      if (receivedEvent.eventName == 'receive-message.${injector.get<ProfileBloc>().appUser?.id}') {
        logger.i('received chat message${receivedEvent.data}');
        // var dataMap = jsonDecode(receivedEvent.data);

        final newMessage = AppMessageModel.fromResponse(TalkamMessage.fromJson(jsonDecode(receivedEvent.data)["data"]));

        if (!newMessage.iAmSender) {
          logger.i('adding chat message');

          messages = sortAndInsertDividers(messages
            ..add(newMessage)
            ..removeWhere(
              (element) => element.messageType == "divider",
            ));
          emit(MessagingState.messageUpdated(newMessage));
          // listController.jumpTo(0);
        }

        logger.i(receivedEvent.data.runtimeType);
      }
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
    }
  }
}
