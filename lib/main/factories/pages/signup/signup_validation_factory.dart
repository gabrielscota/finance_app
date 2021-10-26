import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../builders/builders.dart';
import '../../../composites/composites.dart';

Validation makeSignUpValidation() => ValidationComposite(
      validations: makeSignUpValidations(),
    );

List<FieldValidation> makeSignUpValidations() => [
      ...ValidationBuilder.field('name').required().min(3).build(),
      ...ValidationBuilder.field('email').required().email().build(),
      ...ValidationBuilder.field('cpf').required().cpf().build(),
      ...ValidationBuilder.field('password').required().min(6).build()
    ];
