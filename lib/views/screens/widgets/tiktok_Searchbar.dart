import 'package:flutter/material.dart';

class TikTokSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const TikTokSearchBar({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TikTokSearchBarState createState() => _TikTokSearchBarState();
}

class _TikTokSearchBarState extends State<TikTokSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.red,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _controller.clear();
              widget.onChanged('');
            },
            child: const Icon(Icons.clear, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
