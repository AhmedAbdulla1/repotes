// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignupObject {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get boydWeight => throw _privateConstructorUsedError;
  String get height => throw _privateConstructorUsedError;
  String get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignupObjectCopyWith<SignupObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupObjectCopyWith<$Res> {
  factory $SignupObjectCopyWith(
          SignupObject value, $Res Function(SignupObject) then) =
      _$SignupObjectCopyWithImpl<$Res, SignupObject>;
  @useResult
  $Res call(
      {String name,
      String email,
      String password,
      String boydWeight,
      String height,
      String age,
      String gender});
}

/// @nodoc
class _$SignupObjectCopyWithImpl<$Res, $Val extends SignupObject>
    implements $SignupObjectCopyWith<$Res> {
  _$SignupObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? password = null,
    Object? boydWeight = null,
    Object? height = null,
    Object? age = null,
    Object? gender = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      boydWeight: null == boydWeight
          ? _value.boydWeight
          : boydWeight // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignupObjectCopyWith<$Res>
    implements $SignupObjectCopyWith<$Res> {
  factory _$$_SignupObjectCopyWith(
          _$_SignupObject value, $Res Function(_$_SignupObject) then) =
      __$$_SignupObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String email,
      String password,
      String boydWeight,
      String height,
      String age,
      String gender});
}

/// @nodoc
class __$$_SignupObjectCopyWithImpl<$Res>
    extends _$SignupObjectCopyWithImpl<$Res, _$_SignupObject>
    implements _$$_SignupObjectCopyWith<$Res> {
  __$$_SignupObjectCopyWithImpl(
      _$_SignupObject _value, $Res Function(_$_SignupObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? password = null,
    Object? boydWeight = null,
    Object? height = null,
    Object? age = null,
    Object? gender = null,
  }) {
    return _then(_$_SignupObject(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == boydWeight
          ? _value.boydWeight
          : boydWeight // ignore: cast_nullable_to_non_nullable
              as String,
      null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String,
      null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
      null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SignupObject implements _SignupObject {
  _$_SignupObject(this.name, this.email, this.password, this.boydWeight,
      this.height, this.age, this.gender);

  @override
  final String name;
  @override
  final String email;
  @override
  final String password;
  @override
  final String boydWeight;
  @override
  final String height;
  @override
  final String age;
  @override
  final String gender;

  @override
  String toString() {
    return 'SignupObject(name: $name, email: $email, password: $password, boydWeight: $boydWeight, height: $height, age: $age, gender: $gender)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignupObject &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.boydWeight, boydWeight) ||
                other.boydWeight == boydWeight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, email, password, boydWeight, height, age, gender);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignupObjectCopyWith<_$_SignupObject> get copyWith =>
      __$$_SignupObjectCopyWithImpl<_$_SignupObject>(this, _$identity);
}

abstract class _SignupObject implements SignupObject {
  factory _SignupObject(
      final String name,
      final String email,
      final String password,
      final String boydWeight,
      final String height,
      final String age,
      final String gender) = _$_SignupObject;

  @override
  String get name;
  @override
  String get email;
  @override
  String get password;
  @override
  String get boydWeight;
  @override
  String get height;
  @override
  String get age;
  @override
  String get gender;
  @override
  @JsonKey(ignore: true)
  _$$_SignupObjectCopyWith<_$_SignupObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LoginObject {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$_LoginObjectCopyWith(
          _$_LoginObject value, $Res Function(_$_LoginObject) then) =
      __$$_LoginObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$_LoginObjectCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$_LoginObject>
    implements _$$_LoginObjectCopyWith<$Res> {
  __$$_LoginObjectCopyWithImpl(
      _$_LoginObject _value, $Res Function(_$_LoginObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$_LoginObject(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginObject implements _LoginObject {
  _$_LoginObject(this.email, this.password);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginObject &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      __$$_LoginObjectCopyWithImpl<_$_LoginObject>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String email, final String password) =
      _$_LoginObject;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ForgotPasswordObject {
  String get email => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ForgotPasswordObjectCopyWith<ForgotPasswordObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordObjectCopyWith<$Res> {
  factory $ForgotPasswordObjectCopyWith(ForgotPasswordObject value,
          $Res Function(ForgotPasswordObject) then) =
      _$ForgotPasswordObjectCopyWithImpl<$Res, ForgotPasswordObject>;
  @useResult
  $Res call({String email, String otp, String password});
}

/// @nodoc
class _$ForgotPasswordObjectCopyWithImpl<$Res,
        $Val extends ForgotPasswordObject>
    implements $ForgotPasswordObjectCopyWith<$Res> {
  _$ForgotPasswordObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? otp = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ForgotPasswordObjectCopyWith<$Res>
    implements $ForgotPasswordObjectCopyWith<$Res> {
  factory _$$_ForgotPasswordObjectCopyWith(_$_ForgotPasswordObject value,
          $Res Function(_$_ForgotPasswordObject) then) =
      __$$_ForgotPasswordObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String otp, String password});
}

/// @nodoc
class __$$_ForgotPasswordObjectCopyWithImpl<$Res>
    extends _$ForgotPasswordObjectCopyWithImpl<$Res, _$_ForgotPasswordObject>
    implements _$$_ForgotPasswordObjectCopyWith<$Res> {
  __$$_ForgotPasswordObjectCopyWithImpl(_$_ForgotPasswordObject _value,
      $Res Function(_$_ForgotPasswordObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? otp = null,
    Object? password = null,
  }) {
    return _then(_$_ForgotPasswordObject(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ForgotPasswordObject implements _ForgotPasswordObject {
  _$_ForgotPasswordObject(this.email, this.otp, this.password);

  @override
  final String email;
  @override
  final String otp;
  @override
  final String password;

  @override
  String toString() {
    return 'ForgotPasswordObject(email: $email, otp: $otp, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForgotPasswordObject &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, otp, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ForgotPasswordObjectCopyWith<_$_ForgotPasswordObject> get copyWith =>
      __$$_ForgotPasswordObjectCopyWithImpl<_$_ForgotPasswordObject>(
          this, _$identity);
}

abstract class _ForgotPasswordObject implements ForgotPasswordObject {
  factory _ForgotPasswordObject(
          final String email, final String otp, final String password) =
      _$_ForgotPasswordObject;

  @override
  String get email;
  @override
  String get otp;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_ForgotPasswordObjectCopyWith<_$_ForgotPasswordObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TrainingObject {
  String get exercises => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  int get large => throw _privateConstructorUsedError;
  int get smale => throw _privateConstructorUsedError;
  bool get autoStart => throw _privateConstructorUsedError;
  int get idleTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainingObjectCopyWith<TrainingObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingObjectCopyWith<$Res> {
  factory $TrainingObjectCopyWith(
          TrainingObject value, $Res Function(TrainingObject) then) =
      _$TrainingObjectCopyWithImpl<$Res, TrainingObject>;
  @useResult
  $Res call(
      {String exercises,
      String image,
      int large,
      int smale,
      bool autoStart,
      int idleTime});
}

/// @nodoc
class _$TrainingObjectCopyWithImpl<$Res, $Val extends TrainingObject>
    implements $TrainingObjectCopyWith<$Res> {
  _$TrainingObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercises = null,
    Object? image = null,
    Object? large = null,
    Object? smale = null,
    Object? autoStart = null,
    Object? idleTime = null,
  }) {
    return _then(_value.copyWith(
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      large: null == large
          ? _value.large
          : large // ignore: cast_nullable_to_non_nullable
              as int,
      smale: null == smale
          ? _value.smale
          : smale // ignore: cast_nullable_to_non_nullable
              as int,
      autoStart: null == autoStart
          ? _value.autoStart
          : autoStart // ignore: cast_nullable_to_non_nullable
              as bool,
      idleTime: null == idleTime
          ? _value.idleTime
          : idleTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrainingObjectCopyWith<$Res>
    implements $TrainingObjectCopyWith<$Res> {
  factory _$$_TrainingObjectCopyWith(
          _$_TrainingObject value, $Res Function(_$_TrainingObject) then) =
      __$$_TrainingObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String exercises,
      String image,
      int large,
      int smale,
      bool autoStart,
      int idleTime});
}

/// @nodoc
class __$$_TrainingObjectCopyWithImpl<$Res>
    extends _$TrainingObjectCopyWithImpl<$Res, _$_TrainingObject>
    implements _$$_TrainingObjectCopyWith<$Res> {
  __$$_TrainingObjectCopyWithImpl(
      _$_TrainingObject _value, $Res Function(_$_TrainingObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercises = null,
    Object? image = null,
    Object? large = null,
    Object? smale = null,
    Object? autoStart = null,
    Object? idleTime = null,
  }) {
    return _then(_$_TrainingObject(
      null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as String,
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      null == large
          ? _value.large
          : large // ignore: cast_nullable_to_non_nullable
              as int,
      null == smale
          ? _value.smale
          : smale // ignore: cast_nullable_to_non_nullable
              as int,
      null == autoStart
          ? _value.autoStart
          : autoStart // ignore: cast_nullable_to_non_nullable
              as bool,
      null == idleTime
          ? _value.idleTime
          : idleTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TrainingObject implements _TrainingObject {
  _$_TrainingObject(this.exercises, this.image, this.large, this.smale,
      this.autoStart, this.idleTime);

  @override
  final String exercises;
  @override
  final String image;
  @override
  final int large;
  @override
  final int smale;
  @override
  final bool autoStart;
  @override
  final int idleTime;

  @override
  String toString() {
    return 'TrainingObject(exercises: $exercises, image: $image, large: $large, smale: $smale, autoStart: $autoStart, idleTime: $idleTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainingObject &&
            (identical(other.exercises, exercises) ||
                other.exercises == exercises) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.large, large) || other.large == large) &&
            (identical(other.smale, smale) || other.smale == smale) &&
            (identical(other.autoStart, autoStart) ||
                other.autoStart == autoStart) &&
            (identical(other.idleTime, idleTime) ||
                other.idleTime == idleTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, exercises, image, large, smale, autoStart, idleTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainingObjectCopyWith<_$_TrainingObject> get copyWith =>
      __$$_TrainingObjectCopyWithImpl<_$_TrainingObject>(this, _$identity);
}

abstract class _TrainingObject implements TrainingObject {
  factory _TrainingObject(
      final String exercises,
      final String image,
      final int large,
      final int smale,
      final bool autoStart,
      final int idleTime) = _$_TrainingObject;

  @override
  String get exercises;
  @override
  String get image;
  @override
  int get large;
  @override
  int get smale;
  @override
  bool get autoStart;
  @override
  int get idleTime;
  @override
  @JsonKey(ignore: true)
  _$$_TrainingObjectCopyWith<_$_TrainingObject> get copyWith =>
      throw _privateConstructorUsedError;
}
