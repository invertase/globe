import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../../data/models/user.dart';
import '../../data/providers/auth_provider.dart';
import '../../utils/misc.dart';
import '../../utils/state.dart';

class BaseAuthLayout extends StatefulWidget {
  final Widget Function(AuthProvider auth, BaseAuthLayoutState layout) child;

  const BaseAuthLayout({super.key, required this.child});

  @override
  State<BaseAuthLayout> createState() => BaseAuthLayoutState();
}

class BaseAuthLayoutState extends State<BaseAuthLayout> {
  bool _showingLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProv = context.read<AuthProvider>();
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Stack(
        children: [
          Container(color: Colors.white),
          Center(
            child: SizedBox(
              width: 320,
              child: Card(
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_showingLoading)
                      const SizedBox(
                          width: double.maxFinite, child: ProgressBar()),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 16),
                      child: widget.child(authProv, this),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setLoading(bool show) => setState(() => _showingLoading = show);

  void handleErrors(ProviderEvent<AuthUser> event) {
    if (event.state != ProviderState.error) return;
    showError(context, event.errorMessage!);
  }
}
