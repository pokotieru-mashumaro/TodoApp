import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EditItem extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isDispayKeybord = useState<bool>(false);
    final _isFocus = useState<FocusNode>(FocusNode());

    void _onFocusChange(FocusNode focus) {
      if (focus.hasFocus) {
        isDispayKeybord.value = true;
      } else {
        isDispayKeybord.value = false;
      }
    }

    useEffect(
      () {
        _isFocus.value.addListener(() => _onFocusChange(_isFocus.value));
        return null;
      },
      const [],
    );

    return SizedBox(
      height: isDispayKeybord.value
          ? MediaQuery.of(context).size.height * 0.8
          : MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              '編集',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              focusNode: _isFocus.value,
              decoration: const InputDecoration(
                labelText: '元のテキスト',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => debugPrint('編集'),
            child: const Text('編集'),
          ),
        ],
      ),
    );
  }
}
