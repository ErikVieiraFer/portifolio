import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<void> {
  ContactsCubit() : super(null);

  Future<void> launchEmail() async {
    final uri = Uri.parse('mailto:erik.vieiradev@hotmail.com');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> launchWhatsApp() async {
    final uri = Uri.parse('https://wa.me/5527998547188');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> launchGitHub() async {
    final uri = Uri.parse('https://github.com/ErikVieiraFer');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
