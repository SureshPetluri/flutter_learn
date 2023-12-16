import 'package:flutter/material.dart';

class CustomMenuText<T> extends StatefulWidget {
  final Widget child;
  final void Function(T, int)? onChange;
  final List<MenuDropdownItem<T>> items;

  const CustomMenuText({
    Key? key,
    required this.child,
    required this.items,
    this.onChange,
  }) : super(key: key);

  @override
  CustomMenuTextState<T> createState() => CustomMenuTextState<T>();
}

class CustomMenuTextState<T> extends State<CustomMenuText<T?>> {
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // link the overlay to the button
    return InkWell(
      onTap: _toggleDropdown,
      child: Padding(padding: const EdgeInsets.all(5), child: widget.child),
    );
  }

  OverlayEntry _createOverlayEntry() {
    /// find the size and position of the current widget
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;
    return OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx - 50,
                top: topOffset+10,
                width: size.width + 100,
                child: MouseRegion(
                  onHover: (hover) {},
                  onExit: (exit) {
                    _toggleDropdown();
                  },
                  child: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.zero,
                    color: Colors.blue,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight:
                        MediaQuery.of(context).size.height - topOffset - 15,
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: widget.items.asMap().entries.map((item) {
                          return InkWell(
                            onTap: () {
                              item.value.onChange();
                              _toggleDropdown();
                            },
                            child: ListTile(
                              title: Text(item.value.text),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      this._overlayEntry.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context).insert(this._overlayEntry);
      setState(() => _isOpen = true);
    }
  }
}


/// MenuDropdownItem Class.
/// It holds the values.
class MenuDropdownItem<T> {
  final Function onChange;
  final String text;

  const MenuDropdownItem(
      {Key? key, required this.onChange, required this.text});
}