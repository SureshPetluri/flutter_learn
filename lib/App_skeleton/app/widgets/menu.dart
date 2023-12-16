import 'package:flutter/material.dart';

import 'custom_widgets.dart';


class MenuAppBar extends StatefulWidget{
  const MenuAppBar({super.key,required this.body});
final Widget body;
  @override
  State<MenuAppBar> createState() => _MenuAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MenuAppBarState extends State<MenuAppBar> {
  bool isHome = false;

  final GlobalKey nurseryWidgetKey = GlobalKey();
  final GlobalKey farmerWidgetKey = GlobalKey();
  final GlobalKey employeeWidgetKey = GlobalKey();
  OverlayEntry? overlayProfileEntry;

  colorChange({
    bool isHomeColor = false,
  }) {
    setState(() {
      isHome = isHomeColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        removeProfileOverlay();
      },
      child: Scaffold(
          appBar:MediaQuery.of(context).size.width > 749
          ? AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0.0,
            // title: Text(widget.title),
            actions: [
             /* Center(
                child: CustomMenuText(
                  items: [
                    MenuDropdownItem(
                      onChange: () {},
                      text: "Farmers List",
                    ),
                    MenuDropdownItem(
                      onChange: (){},
                      text: "Create Farmer",

                    ),
                    MenuDropdownItem(
                      onChange: (){},
                      text: "ejhfgeruyfe",

                    )
                  ],
                  child: Text("Farmer"),
                ),
              ),*/
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Home",
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    overLayProfileInfo(
                      context,
                      farmerWidgetKey,
                    );
                  },
                  child: Padding(
                    key: farmerWidgetKey,
                    padding: EdgeInsets.all(8.0),
                    child: const Text(
                      "Farmer",
                    ),
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Employee",
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Nursery",
                  ),
                ),
              ),
              // Center(
              //   child: Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: Text(
              //       "Contact",
              //     ),
              //   ),
              // ),
              // Center(
              //   child: Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: Text(
              //       "Resume",
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 8.0),
              //   child: SwitchMode(
              //     themeMode: widget.themeMode,
              //     changeTheme: widget.changeTheme,
              //   ),
              // ),
// buildModes(context)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          )
          : AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
// foregroundColor: Colors.black,
// elevation: 0.0,
            ),
      drawer: menuDrawer(context),
      body: GestureDetector(
          onPanDown: (pan) {
        removeProfileOverlay();
      },
      child: NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
      if (scrollNotification is ScrollStartNotification) {
      removeProfileOverlay();
      }
      return false;
      },
      child:widget.body)),
      ),
    );
  }


  removeProfileOverlay() {
    if (overlayProfileEntry != null) {
      overlayProfileEntry?.remove();
      overlayProfileEntry = null;
    }
  }
  overLayProfileInfo(

      BuildContext context,
      GlobalKey widgetKey,
      ) async {
    if (overlayProfileEntry != null) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);
    RenderBox renderBox =
    widgetKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    overlayProfileEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: position.dx,
        top: position.dy + renderBox.size.height,
        child: MouseRegion(
          onHover: (hover) {},
          onExit: (exit) {
            // removeProfileOverlay();
          },
          child: Material(
              elevation: 5.0,
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: MouseRegion(
                onHover: (hover) {},
                onExit: (exit) {
                   removeProfileOverlay();
                },
                child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            removeProfileOverlay();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Farmer List"),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            removeProfileOverlay();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Create farmer"),
                          ),
                        ),

                        // paddingText("QA JOBS"),
                      ],
                    )),
              )),
        ),
      );
    });

    /// Inserting the OverlayEntry into the Overlay
    overlayState.insert(overlayProfileEntry!);
  }

}

Drawer? menuDrawer(BuildContext context) {
  return MediaQuery.of(context).size.width < 750
      ? Drawer(
          backgroundColor: Theme.of(context).colorScheme.primary,
// shadowColor:Theme.of(context).colorScheme.primary ,
// surfaceTintColor: Theme.of(context).colorScheme.primary,
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sizedBoxH40(),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green,
                  ),
                  sizedBoxH40(),
                  const Text(
                    "Home",
                  ),
                  sizedBoxH20(),
                  const Text(
                    "About",
                  ),
                  sizedBoxH20(),
                  const Text(
                    "Services",
                  ),
                  sizedBoxH20(),
                  const Text(
                    "Projects",
                  ),
                  sizedBoxH20(),
                  const Text(
                    "Contact",
                  ),
                  sizedBoxH20(),
                  const Text(
                    "Resume",
                  ),
                ],
              ),
            ),
          ),
        )
      : null;
}

