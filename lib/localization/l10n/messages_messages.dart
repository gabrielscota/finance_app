import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef MessageIfAbsent = Function(String messageStr, List args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, String Function()> _notInlinedMessages(_) =>
      {'title': MessageLookupByLibrary.simpleMessage('Hello World')};
}
