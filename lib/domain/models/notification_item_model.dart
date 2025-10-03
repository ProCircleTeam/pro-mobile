class NotificationItemModel {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool isRead;

  NotificationItemModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    return NotificationItemModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }
}

const sampleNotifications = [
  {
    "id": "1",
    "title": "Welcome to ProCircle",
    "body": "Thanks for joining our community. Let’s get started!",
    "timestamp": "2025-10-01T09:30:00Z",
    "isRead": false,
  },
  {
    "id": "2",
    "title": "Profile Completed",
    "body": "Great! Your profile is now 100% complete.",
    "timestamp": "2025-10-01T10:15:00Z",
    "isRead": true,
  },
  {
    "id": "3",
    "title": "New Connection",
    "body": "Alex Johnson just connected with you.",
    "timestamp": "2025-10-02T14:20:00Z",
    "isRead": false,
  },
  {
    "id": "4",
    "title": "Event Reminder",
    "body": "Don’t forget about the ProCircle Meetup tomorrow.",
    "timestamp": "2025-10-02T18:45:00Z",
    "isRead": false,
  },
  {
    "id": "5",
    "title": "Achievement Unlocked",
    "body": "You’ve reached 100 points this week. Keep it up!",
    "timestamp": "2025-10-03T07:50:00Z",
    "isRead": true,
  },
  {
    "id": "6",
    "title": "Message Received",
    "body": "You have a new message from Sarah.",
    "timestamp": "2025-10-03T12:05:00Z",
    "isRead": false,
  },
  {
    "id": "7",
    "title": "Weekly Digest",
    "body": "Here’s what you missed this week on ProCircle.",
    "timestamp": "2025-10-03T15:30:00Z",
    "isRead": true,
  },
  {
    "id": "8",
    "title": "Security Alert",
    "body": "A new login was detected from Lagos, Nigeria.",
    "timestamp": "2025-10-03T16:00:00Z",
    "isRead": false,
  },
  {
    "id": "9",
    "title": "Payment Successful",
    "body": "Your ProCircle Pro subscription has been renewed.",
    "timestamp": "2025-10-03T18:40:00Z",
    "isRead": true,
  },
  {
    "id": "10",
    "title": "System Update",
    "body": "We’ve updated our terms and privacy policy.",
    "timestamp": "2025-10-03T20:10:00Z",
    "isRead": false,
  },
];
