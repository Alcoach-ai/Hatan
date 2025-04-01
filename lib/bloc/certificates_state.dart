part of 'certificates_cubit.dart';

abstract class CertificatesState {}

class CertificatesInitial extends CertificatesState {}

class CertificatesLoading extends CertificatesState {}
class CertificatesError extends CertificatesState {}
class CertificatesDown extends CertificatesState {}

class CertificatesEmpty extends CertificatesState {}
