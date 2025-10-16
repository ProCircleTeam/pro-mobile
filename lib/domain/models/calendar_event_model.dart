import 'package:intl/intl.dart';

class CalendarEventModel {
  final String kind;
  final String etag;
  final String id;
  final String status;
  final String htmlLink;
  final DateTime created;
  final DateTime updated;
  final String summary;
  final String? description;
  final EventPerson creator;
  final EventPerson organizer;
  final EventDateTime start;
  final EventDateTime end;
  final String iCalUID;
  final int sequence;
  final List<Attendee> attendees;
  final String? hangoutLink;
  final ConferenceData? conferenceData;
  final Reminders reminders;
  final String eventType;
  final String? meetLink;
  final String? eventLink;

  CalendarEventModel({
    required this.kind,
    required this.etag,
    required this.id,
    required this.status,
    required this.htmlLink,
    required this.created,
    required this.updated,
    required this.summary,
    this.description,
    required this.creator,
    required this.organizer,
    required this.start,
    required this.end,
    required this.iCalUID,
    required this.sequence,
    required this.attendees,
    this.hangoutLink,
    this.conferenceData,
    required this.reminders,
    required this.eventType,
    this.meetLink,
    this.eventLink,
  });

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) {
    return CalendarEventModel(
      kind: json['kind'] ?? '',
      etag: json['etag'] ?? '',
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      htmlLink: json['htmlLink'] ?? '',
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      summary: json['summary'] ?? '',
      description: json['description'],
      creator: EventPerson.fromJson(json['creator']),
      organizer: EventPerson.fromJson(json['organizer']),
      start: EventDateTime.fromJson(json['start']),
      end: EventDateTime.fromJson(json['end']),
      iCalUID: json['iCalUID'] ?? '',
      sequence: json['sequence'] ?? 0,
      attendees:
          (json['attendees'] as List<dynamic>?)
              ?.map((attendee) => Attendee.fromJson(attendee))
              .toList() ??
          [],
      hangoutLink: json['hangoutLink'],
      conferenceData:
          json['conferenceData'] != null
              ? ConferenceData.fromJson(json['conferenceData'])
              : null,
      reminders: Reminders.fromJson(json['reminders']),
      eventType: json['eventType'] ?? 'default',
      meetLink: json['meetLink'],
      eventLink: json['eventLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kind': kind,
      'etag': etag,
      'id': id,
      'status': status,
      'htmlLink': htmlLink,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'summary': summary,
      'description': description,
      'creator': creator.toJson(),
      'organizer': organizer.toJson(),
      'start': start.toJson(),
      'end': end.toJson(),
      'iCalUID': iCalUID,
      'sequence': sequence,
      'attendees': attendees.map((attendee) => attendee.toJson()).toList(),
      'hangoutLink': hangoutLink,
      'conferenceData': conferenceData?.toJson(),
      'reminders': reminders.toJson(),
      'eventType': eventType,
      'meetLink': meetLink,
      'eventLink': eventLink,
    };
  }

  // Utility methods
  Duration get duration => end.dateTime.difference(start.dateTime);

  bool get isConfirmed => status == 'confirmed';

  bool get hasConference => conferenceData != null || hangoutLink != null;

  String get conferenceLink => meetLink ?? hangoutLink ?? '';

  bool isAttendee(String email) {
    return attendees.any((attendee) => attendee.email == email);
  }

  Attendee? getAttendee(String email) {
    return attendees.firstWhere((attendee) => attendee.email == email);
  }

  String formatEventTime() {
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('HH:mm');

    return '${dateFormat.format(start.dateTime)} • ${timeFormat.format(start.dateTime)} - ${timeFormat.format(end.dateTime)}';
  }

  @override
  String toString() {
    return 'CalendarEventModel($summary - ${formatEventTime()})';
  }
}

class EventPerson {
  final String email;
  final bool self;

  EventPerson({required this.email, required this.self});

  factory EventPerson.fromJson(Map<String, dynamic> json) {
    return EventPerson(email: json['email'] ?? '', self: json['self'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'self': self};
  }
}

class EventDateTime {
  final DateTime dateTime;
  final String timeZone;

  EventDateTime({required this.dateTime, required this.timeZone});

  factory EventDateTime.fromJson(Map<String, dynamic> json) {
    return EventDateTime(
      dateTime: DateTime.parse(json['dateTime']),
      timeZone: json['timeZone'] ?? 'UTC',
    );
  }

  Map<String, dynamic> toJson() {
    return {'dateTime': dateTime.toIso8601String(), 'timeZone': timeZone};
  }
}

class Attendee {
  final String email;
  final String responseStatus;

  Attendee({required this.email, required this.responseStatus});

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      email: json['email'] ?? '',
      responseStatus: json['responseStatus'] ?? 'needsAction',
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'responseStatus': responseStatus};
  }

  bool get hasAccepted => responseStatus == 'accepted';
  bool get hasDeclined => responseStatus == 'declined';
  bool get needsAction => responseStatus == 'needsAction';
}

class ConferenceData {
  final CreateRequest createRequest;
  final List<EntryPoint> entryPoints;
  final ConferenceSolution conferenceSolution;
  final String conferenceId;

  ConferenceData({
    required this.createRequest,
    required this.entryPoints,
    required this.conferenceSolution,
    required this.conferenceId,
  });

  factory ConferenceData.fromJson(Map<String, dynamic> json) {
    return ConferenceData(
      createRequest: CreateRequest.fromJson(json['createRequest']),
      entryPoints:
          (json['entryPoints'] as List<dynamic>)
              .map((entry) => EntryPoint.fromJson(entry))
              .toList(),
      conferenceSolution: ConferenceSolution.fromJson(
        json['conferenceSolution'],
      ),
      conferenceId: json['conferenceId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createRequest': createRequest.toJson(),
      'entryPoints': entryPoints.map((entry) => entry.toJson()).toList(),
      'conferenceSolution': conferenceSolution.toJson(),
      'conferenceId': conferenceId,
    };
  }

  String? get videoLink {
    final videoEntry = entryPoints.firstWhere(
      (entry) => entry.entryPointType == 'video',
      orElse: () => EntryPoint(entryPointType: '', uri: '', label: ''),
    );
    return videoEntry.uri.isNotEmpty ? videoEntry.uri : null;
  }
}

class CreateRequest {
  final String requestId;
  final ConferenceSolutionKey conferenceSolutionKey;
  final RequestStatus status;

  CreateRequest({
    required this.requestId,
    required this.conferenceSolutionKey,
    required this.status,
  });

  factory CreateRequest.fromJson(Map<String, dynamic> json) {
    return CreateRequest(
      requestId: json['requestId'] ?? '',
      conferenceSolutionKey: ConferenceSolutionKey.fromJson(
        json['conferenceSolutionKey'],
      ),
      status: RequestStatus.fromJson(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'conferenceSolutionKey': conferenceSolutionKey.toJson(),
      'status': status.toJson(),
    };
  }
}

class ConferenceSolutionKey {
  final String type;

  ConferenceSolutionKey({required this.type});

  factory ConferenceSolutionKey.fromJson(Map<String, dynamic> json) {
    return ConferenceSolutionKey(type: json['type'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'type': type};
  }
}

class RequestStatus {
  final String statusCode;

  RequestStatus({required this.statusCode});

  factory RequestStatus.fromJson(Map<String, dynamic> json) {
    return RequestStatus(statusCode: json['statusCode'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'statusCode': statusCode};
  }
}

class EntryPoint {
  final String entryPointType;
  final String uri;
  final String label;

  EntryPoint({
    required this.entryPointType,
    required this.uri,
    required this.label,
  });

  factory EntryPoint.fromJson(Map<String, dynamic> json) {
    return EntryPoint(
      entryPointType: json['entryPointType'] ?? '',
      uri: json['uri'] ?? '',
      label: json['label'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'entryPointType': entryPointType, 'uri': uri, 'label': label};
  }
}

class ConferenceSolution {
  final ConferenceSolutionKey key;
  final String name;
  final String iconUri;

  ConferenceSolution({
    required this.key,
    required this.name,
    required this.iconUri,
  });

  factory ConferenceSolution.fromJson(Map<String, dynamic> json) {
    return ConferenceSolution(
      key: ConferenceSolutionKey.fromJson(json['key']),
      name: json['name'] ?? '',
      iconUri: json['iconUri'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'key': key.toJson(), 'name': name, 'iconUri': iconUri};
  }
}

class Reminders {
  final bool useDefault;
  final List<ReminderOverride> overrides;

  Reminders({required this.useDefault, required this.overrides});

  factory Reminders.fromJson(Map<String, dynamic> json) {
    return Reminders(
      useDefault: json['useDefault'] ?? true,
      overrides:
          (json['overrides'] as List<dynamic>?)
              ?.map((override) => ReminderOverride.fromJson(override))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'useDefault': useDefault,
      'overrides': overrides.map((override) => override.toJson()).toList(),
    };
  }
}

class ReminderOverride {
  final String method;
  final int minutes;

  ReminderOverride({required this.method, required this.minutes});

  factory ReminderOverride.fromJson(Map<String, dynamic> json) {
    return ReminderOverride(
      method: json['method'] ?? '',
      minutes: json['minutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'method': method, 'minutes': minutes};
  }
}
