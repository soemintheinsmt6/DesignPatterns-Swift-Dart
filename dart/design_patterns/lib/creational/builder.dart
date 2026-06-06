// Without Builder — plain constructor approach.
// Every field must be passed in one long call:
//
// class Person {
//   final String firstName;
//   final String lastName;
//   final int age;
//   final String email;
//   final String phone;
//   final String address;
//
//   Person(this.firstName, this.lastName, this.age,
//       this.email, this.phone, this.address);
// }
//
// final person = Person('John', 'Doe', 30, 'john.doe@example.com',
//     '+1234567890', '123 Main Street');

// Product

class Person {
  final String firstName;
  final String lastName;
  final int? age;
  final String? email;
  final String? phone;
  final String? address;

  Person._(PersonBuilder builder)
      : firstName = builder._firstName,
        lastName = builder._lastName,
        age = builder._age,
        email = builder._email,
        phone = builder._phone,
        address = builder._address;

  @override
  String toString() {
    return "Person{firstName='$firstName', lastName='$lastName', "
        "age=$age, email='$email', phone='$phone', address='$address'}";
  }
}

// Builder

class PersonBuilder {
  final String _firstName;
  final String _lastName;
  int? _age;
  String? _email;
  String? _phone;
  String? _address;

  PersonBuilder(this._firstName, this._lastName);

  PersonBuilder age(int age) {
    _age = age;
    return this;
  }

  PersonBuilder email(String email) {
    _email = email;
    return this;
  }

  PersonBuilder phone(String phone) {
    _phone = phone;
    return this;
  }

  PersonBuilder address(String address) {
    _address = address;
    return this;
  }

  Person build() => Person._(this);
}

// Usage

void main() {
  final person = PersonBuilder('John', 'Doe')
      .age(30)
      .email('john.doe@example.com')
      .phone('+1234567890')
      .address('123 Main Street')
      .build();
  print(person);
}
