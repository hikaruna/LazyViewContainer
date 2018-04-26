# LazyViewContainer
LazyViewContainer は、時間がかかる処理のための処理中の画面を簡単に構築する方法を提供します。

## Installing
### Carthage

```
# Cartfile
github "hikaruna/LazyViewContainer"
```

詳細の手順は、https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos

## Usage

### 1. Storyboardで、[Storyboard Reference]を配置します

```
// Storyboard Reference の Properties設定
Storyboard: LazyViewContainer
ReferenceID: (初期値であるinitialViewControllerでOK)
Bundle: net.hikaruna.LazyViewContainer
```

### 2. [Storyboard Reference]に[Storyboard Segue]を接続する

```
// Storybard Segue の Properties設定
identifier: ToSecond
```

### 3. prepareForSegueでLazyViewContainerViewControllerの設定を行う

### 3.1. doInBackgroundにblockをセットする
[var lazyViewContainerViewController.doInBackground: () -> UIViewController?] にバックグラウンドで行わせたい時間のかかる処理のブロックをセットする
UIViewControllerをreturnすると、LazyViewContainerの中身がそれに差し替わる


```
// FirstViewController.swift
import LazyViewContainer

class FirstViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "ToSecond":
            print("Prepare for ToSecond segue.")
            let lazyViewController = segue.destination as! LazyViewContainerViewController
            lazyViewController.doInBackground = { [weak self] () -> UIViewController? in
                print("Task begin.")
                sleep(3)
                print("Task finished.")
                guard let `self` = self else { return nil }
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "Second") as! SecondViewController
                secondViewController.text = "Second View."
                return secondViewController
            }
        default:
            break
        }
    }
}
```

詳細は、[Example](Example)を見て下さい

## Progress画面のカスタマイズ

```
// prepareForSegue
let lazyViewController = segue.destination as! LazyViewContainerViewController
lazyViewController.progressViewController = yourProgressViewController
```

## License
[MIT](LICENSE.txt)
