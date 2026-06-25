class ResourceString {
  static Map<String, String> dataString = {
    ///A
    'academic_schedule': "Academic Schedule",
    "activity_schedule": "Activity Schedule",
    "advidor": "Advisor",
    "age": "Age",
    "anesth": "Anesth",

    ///B
    ///C
    'chief_r': "Chief R",
    "create_schedule": "Create Schedule",

    ///D
    "date": "Date",
    'dx': 'DX',

    ///E
    "edit_profile": "Edit Profile",
    "edit_schedule": "Edit Schedule",
    "email": "E-mail",
    "end": "End",
    'er_day_time': 'ER DayTime',

    ///F
    "fax": "Fax",
    "fill_out_all_info": "Please fill out all information.",
    "first_name": "First name",

    ///G
    "group": "Group",

    ///H
    "hn": "HN",

    ///I
    'implant': 'Implant',
    "intern": "Intern",
    'ipd': 'IPD',

    ///G
    ///K
    ///L
    "last_name": "Last name",
    "logout": "Log out",

    ///M
    "my_profile": "My Profile",
    "my_schedule": "My schedule",

    ///N
    ///O
    'op': 'OP',
    'opd': 'OPD',
    "operative_room": "Operative room",
    "or_no": "OR No.",
    "ordes": "Order",

    ///P
    "patient_name": "Patient name",
    "phone": "Phone",
    "position": "Position",
    "praticipants": "Participants",

    ///Q
    ///R
    'r1': 'R1',
    'r2': 'R2',
    'r3': 'R3',
    'r4': 'R4',
    'remark': 'Remark',
    'resident': "Resident",

    ///S
    "schedule_detail": "Schedule Detail",
    "service_detail": "Service Detail",
    "service_schedule": "Service Schedule",
    "staff_name": "Staff name",
    "start": "Start",

    ///T
    "tel": "Tel",
    "time_cannot_same": "Time can't be the same",
    "title": "Title",
    "type": "Type",

    ///U
    ///V
    'venue': 'Venue',
    'vip': 'VIP',

    ///W
    ///X
    ///Y
    "your_name": "Your name",

    ///Z
  };

  static String getString(String key) {
    return dataString[key];
  }
}
