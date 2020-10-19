
# flutter 常用方法总结。

### 设置TextFormField 默认值

```dart
TextFormField(
    decoration: const InputDecoration(
        hintText: '标签名称',
        // border: InputBorder.none,
    ),
    validator: (value) {
        if (value.isEmpty) {
        return '请输入标签名称';
        }
        return null;
    },
    controller: new TextEditingController(text: widget.name),
    onSaved: (val) {
        name = val;
    },
)
```