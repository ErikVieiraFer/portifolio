import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/core/services/url_service.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial());

  Future<void> launchEmail(BuildContext context) async {
    await UrlService.launchEmail('erik.vieiradev@hotmail.com', context);
  }

  Future<void> launchWhatsApp(BuildContext context) async {
    await UrlService.launchWhatsApp('5527998547188', context);
  }

  Future<void> launchGitHub(BuildContext context) async {
    await UrlService.launchGitHub('ErikVieiraFer', context);
  }
}