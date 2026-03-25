# VitanaChatButtonDemo

独立 iOS Demo 工程，用于复现 `VitanaChatButton` 的 Rive 崩溃问题。

## 路径

`/Users/roni/Desktop/workspace/VitanaChatButtonDemo`

## 打开方式

1. 首次执行依赖安装：
   ```bash
   cd /Users/roni/Desktop/workspace/VitanaChatButtonDemo
LANG=en_US.UTF-8 pod install
   ```
2. 打开 `VitanaChatButtonDemo.xcworkspace`
3. 选择 iPhone 11 真机运行

## 资源文件

请将以下两个文件放入 `Resources` 目录（文件名必须一致）：

- `output-vitana-bt-bg.riv`
- `output-vitana-icon.riv`

如果缺少资源，Demo 仍可启动，但不会完整播放动画。

## 复现步骤

1. 进入 Demo 页
2. 点击 `Play Both (并发)`
3. 反复点击 `Toggle Large Visible`
4. 观察是否出现崩溃

## 工程生成

本工程使用 `xcodegen` 生成：

```bash
cd /Users/roni/Desktop/workspace/VitanaChatButtonDemo
xcodegen generate
LANG=en_US.UTF-8 pod install
```
