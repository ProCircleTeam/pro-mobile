import 'package:pro_mobile/domain/models/time_zone.dart';

class SVGImageUrl {
  static const onboardingImage1 = "assets/images/svg/onboardingImage1.svg";
  static const onboardingImage2 = "assets/images/svg/onboardingImage2.svg";
  static const onboardingImage3 = "assets/images/svg/onboardingImage3.svg";
  static const googleLogo = "assets/images/svg/google-logo.svg";
  static const trophy = "assets/images/svg/trophy.svg";
  static const fire = "assets/images/svg/fire.svg";
  static const warningIcon = "assets/images/svg/warning_icon.svg";
  static const emptyHome = "assets/images/svg/empty-home.svg";
  static const emptyNotification = "assets/images/svg/empty-notification.svg";
  static const emptyDirectory = "assets/images/svg/open_folder.svg";
}

class PNGImageUrl {
  static const sampleProfilePix = "assets/images/png/sample-profile-pix.png";
  static const sampleProfilePix2 = "assets/images/png/sample-profile-pix-2.png";
}

class ErrorText {
  static const generic = "Something went wrong, please try again later";
}

class StringConstants {
  static const authToken = "auth_token";
  static const userObject = "user_object";
  static const isFirstTimeUser = "is_first_time_user";
  static const String profileImageUrl =
      "https://scontent.flos5-3.fna.fbcdn.net/v/t39.30808-6/469524331_1540055199984082_3973845869113443537_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeHSrflZ3cxEMTUgOYKay6tLp8NttrSiJc6nw222tKIlzhVUGevAkm8vNB_pBT9DurH3trzVxGNeMlutLbdOeY6_&_nc_ohc=3S4_A-MNcZ4Q7kNvwHi4JVx&_nc_oc=Adk67YY3_F3Zv8lkuWxrWfouysTP7y6g3kUaztIPrGROBmMdM44piAfYxqCHJuFF6Cc&_nc_zt=23&_nc_ht=scontent.flos5-3.fna&_nc_gid=Rg3TT84-k0uZFkF0XsN51Q&oh=00_AfS7yCNWx11Dj02SRzEGP9s6qxZ3rNJHKauhFXeU1WKfNQ&oe=6886FCF9";
  static const String sampleProfileImage =
      "https://cdn.vectorstock.com/i/2000v/54/17/gray-man-placeholder-photo-vector-24005417.avif";
  static const String sampleProfileImage2 =
      "https://www.shutterstock.com/image-photo/smiling-african-american-millennial-businessman-600nw-1437938108.jpg";
  static const String sampleProfileImage3 =
      "https://media.istockphoto.com/id/1411155612/photo/side-profile-of-a-beautiful-young-black-woman-thinking-and-looking-powerful-standing-against.jpg?s=612x612&w=0&k=20&c=q64YMacmkFA78WDmlShv9Q44va-8k2iDaYFIkWNeyqg=";
  static const String sampleProfileImage4 =
      "https://t3.ftcdn.net/jpg/03/62/40/80/360_F_362408093_AlwyWJQbyc6edRlXGaGz3xquwzLGXhkX.jpg";
  static const String sampleProfileImage5 =
      "https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=";
}

List<TimeZoneModel> timeZones =
    sampleTimeZones.map((e) => TimeZoneModel.fromJson(e)).toList();

const List<String> industrySectors = [
  "Select Industry Sector",
  'Information Technology (IT)',
  'Finance & Banking',
  'Healthcare & Medical Services',
  'Education',
  'Manufacturing',
  'Retail & E-commerce',
  'Agriculture',
  'Energy & Utilities',
  'Transportation & Logistics',
  'Construction & Real Estate',
  'Telecommunications',
  'Media & Entertainment',
  'Hospitality & Tourism',
  'Food & Beverage',
  'Legal Services',
  'Government & Public Administration',
  'Nonprofit & NGOs',
  'Environmental Services',
  'Automotive',
  'Aerospace & Defense',
  'Pharmaceuticals & Biotechnology',
  'Insurance',
  'Sports & Recreation',
  'Arts & Culture',
  'Research & Development',
  'Mining & Metals',
  'Chemicals',
  'Fashion & Apparel',
  'Human Resources & Staffing',
  'Consulting & Business Services',
];

const List<String> interests = [
  "Select Interest",
  "AI & Machine Learning",
  "Cybersecurity",
  "Data Science",
  "Coding cool apps",
  "Building websites",
  "Blockchain & Crypto",
  "Space stuff",
  "Robotics",
  "Quantum computing (mind bendy stuff)",
  "Eco tech & green living",
  "Drawing & digital art",
  "Photography",
  "Video editing & YouTube",
  "Graphic design",
  "Making short films",
  "Animation & motion graphics",
  "Music production",
  "DJing for fun",
  "Singing & songwriting",
  "Stand-up comedy",
  "Fitness & workouts",
  "Healthy eating",
  "Mental health & mindfulness",
  "Yoga & meditation",
  "Skincare & beauty",
  "Fashion & styling",
  "Interior decor",
  "DIY & crafts",
  "Travel adventures ",
  "Learning new languages",
  "Public speaking",
  "Hosting events",
  "Writing stories or poetry",
  "Journaling",
  "Book clubs & reading",
  "Personal finance & investing",
  "Stock trading (for real or fun)",
  "Career growth hacks",
  "Entrepreneurship",
  "Startups & pitching ideas",
  "Volunteering & giving back",
  "Tech communities & meetups",
  "Gaming (mobile/console/PC)",
  "Esports",
  "Cooking & food blogging",
  "Pet care & training",
  "Parenting hacks",
  "Relationship & dating tips",
  "Car customization & racing",
  "Watching documentaries & learning stuff",
];

List<Map<String, dynamic>> sampleTimeZones = [
  {"id": -1, "name": "Time", "abbreviation": "Select time zone"},
  {"id": 2, "name": "Central European Time", "abbreviation": "CET"},
  {"id": 3, "name": "Africa/Brazzaville", "abbreviation": "WAT"},
];
