import 'package:flutter/material.dart';

const primary = const Color(0xff4caf50);
const secondary = const Color(0xff087f23);

enum MenuState { mini, normal, small }

class Dashboard extends StatefulWidget {
  final Widget Function(MenuState) drawer;
  final Widget Function(MenuState) header;

  final bool center;

  final Widget body;
  final Widget title;
  final Widget floating;

  final double minWidth;

  final List<Widget> actions;
  final Function(bool dark) themeChange;

  final Color primaryColor;
  final Color secondColor;

  const Dashboard(
      {this.title,
      this.center = false,
      this.primaryColor = primary,
      this.secondColor = secondary,
      this.actions,
      this.header,
      this.minWidth = 700,
      this.drawer,
      this.body,
      this.themeChange,
      this.floating});

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  AnimationController _controller;

  bool dark() => Theme.of(context).brightness == Brightness.dark;
  bool small() => MediaQuery.of(context).size.width < widget.minWidth;

  bool mini = false;
  double width = 250;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _miniButton() {
    return IconButton(
      splashRadius: 20,
      color: Colors.white,
      icon: Icon(
        Icons.menu,
      ),
      onPressed: () => setState(() {
        mini = !mini;
        width = mini ? 60 : 250;
      }),
    );
  }

  Widget _themeButton() {
    return IconButton(
      splashRadius: 20,
      color: Colors.white,
      icon: Icon(
        dark() ? Icons.toggle_on_outlined : Icons.toggle_off_outlined,
      ),
      onPressed: () {
        setState(() => widget.themeChange(!dark()));
      },
    );
  }

  Widget _appbar() {
    return AppBar(
      elevation: small() ? 0 : 0,
      leading: small() ? null : _miniButton(),
      backgroundColor: widget.primaryColor,
      title: widget.title,
      centerTitle: widget.center,
      actions: [
        if (widget.actions != null) ...widget.actions,
        if (widget.themeChange != null) _themeButton(),
      ],
    );
  }

  Widget _getActionBar() {
    if (small()) {
      return _appbar();
    }
    return PreferredSize(
      preferredSize: Size.fromHeight(57),
      child: Material(
        elevation: 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 200),
              alignment: Alignment.centerLeft,
              width: width,
              height: 57,
              color: widget.secondColor,
              child: widget.header == null
                  ? null
                  : widget.header(
                      small()
                          ? MenuState.small
                          : (mini ? MenuState.mini : MenuState.normal),
                    ),
            ),
            Expanded(
              child: _appbar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody() {
    if (small()) {
      return widget.body;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          elevation: 10,
          child: Center(
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 200),
              width: width,
              child: widget.drawer(mini ? MenuState.mini : MenuState.normal),
            ),
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: _controller,
            child: widget.body,
            builder: (BuildContext context, Widget child) {
              return FadeTransition(
                opacity: _controller,
                child: child,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getActionBar(),
      drawer: small()
          ? Drawer(
              child: Column(
                children: [
                  if (widget.header != null)
                    Container(
                      height: 56,
                      color: widget.secondColor,
                      child: widget.header(
                        small()
                            ? MenuState.small
                            : (mini ? MenuState.mini : MenuState.normal),
                      ),
                    ),
                  Expanded(
                    child: widget.drawer(MenuState.small),
                  ),
                ],
              ),
            )
          : null,
      body: _getBody(),
      floatingActionButton: widget.floating,
    );
  }
}
