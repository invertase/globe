import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:fluent_ui/fluent_ui.dart';

void showError(BuildContext context, String error) => CherryToast.error(
      title: Text(
        error,
        style: FluentTheme.of(context)
            .typography
            .bodyLarge!
            .copyWith(fontSize: 12, color: Colors.white),
      ),
      toastPosition: Position.bottom,
      autoDismiss: true,
      borderRadius: 0,
      shadowColor: Colors.transparent,
      toastDuration: const Duration(seconds: 5),
      displayCloseButton: false,
      iconWidget: const Icon(FluentIcons.error, color: Colors.white),
    ).show(context);

// 
