class UserModel{
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName name;
  final UserDOB dob;
  final UserLoc loc;

  UserModel({
      required this.email,
      required this.phone,
      required this.cell,
      required this.nat,
      required this.gender,
      required this.name,
      required this.dob,
      required this.loc,
  });

  factory UserModel.fromMap(Map<String, dynamic> e) {

    ///username

    final name = UserName(
      title: e['name']['title'],
      first: e['name']['first'],
      last: e['name']['last'],
    );

    ///dateofbirth

    final date = e['dob']['date'];

    final dob = UserDOB(
      date: DateTime.parse(date),
      age: e['dob']['age'],
    );

    ///location

    final coordinates = LocationCoordinates(
      latitude: e['location']['coordinates']['latitude'],
      longitude: e['location']['coordinates']['longitude'],
    );
    final timezone = LocationTimeZone(
      offset: e['location']['timezone']['offset'],
      description: e['location']['timezone']['description'],
    );
    final street = LocationStreet(
      number: e['location']['street']['number'],
      name: e['location']['street']['name'],
    );

    final loc = UserLoc(
      city: e['location']['city'],
      state: e['location']['state'],
      country: e['location']['country'],
      postcode: e['location']['postcode'].toString(),
      coordinates: coordinates,
      timezone: timezone,
      street: street,
    );


    return UserModel(
      cell: e['cell'],
      email: e['email'],
      phone: e['phone'],
      nat: e['nat'],
      gender: e['gender'],
      name: name,
      dob: dob,
      loc: loc,
    );
  }


  String get fullName{
    return '${name.title} ${name.first} ${name.last}';
  }
  String get fullAddress{
    return '${loc.street.number} ${loc.street.name} ${loc.city} ${loc.state}  ${loc.country}  ${loc.postcode}';
  }
  String get fullDOB{
    return '${dob.date.day}/${dob.date.month}/${dob.date.year}';
  }
}


class UserName{
  final String title;
  final String first;
  final String last;

  UserName({
    required this.title,
    required this.first,
    required this.last
  });
}

class UserDOB{
  final DateTime date;
  final int age;

  UserDOB({
    required this.date,
    required this.age
  });
}

class UserLoc{
  final String city;
  final String state;
  final String country;
  final String postcode;
  final LocationStreet street;
  final LocationCoordinates coordinates;
  final LocationTimeZone timezone;


  UserLoc({
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
    required this.street,
  });
}

class LocationCoordinates{
  final String latitude;
  final String longitude;

  LocationCoordinates({
    required this.latitude,
    required this.longitude
  });
}

class LocationTimeZone{
  final String offset;
  final String description;

  LocationTimeZone({
    required this.offset,
    required this.description
  });
}

class LocationStreet{
  final int number;
  final String name;

  LocationStreet({
    required this.number,
    required this.name
  });
}
