import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

class CpfValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  const CpfValidation({required this.field});

  @override
  ValidationError validate(Map input) => input[field]?.isNotEmpty == true && CPFValidator.isValid(input[field])
      ? ValidationError.noError
      : ValidationError.invalidCpf;

  @override
  List<Object> get props => [field];
}
