# GUIで設定する系
## WSLらへん
- インストール: `wsl --install Ubuntu`
- install.sh実行: `curl -sSf https://raw.githubusercontent.com/shizukani-cp/dotfiles/main/install.sh | bash`
## Edgeらへん
### 拡張機能
- [Casca](https://chromewebstore.google.com/detail/nifaiikfnpnppeicpgannigjabpjdcmh)
- [Dark Reader](https://chromewebstore.google.com/detail/eimadpbcbfnmbkopoojfekhnkhdbieeh)
- [DeepL](https://chromewebstore.google.com/detail/cofdbpoegempjloogbagkncekinflcnj)(ログインも)
- [Proton Pass](https://chromewebstore.google.com/detail/ghmbeldphafepmbegfdlkpapadhbakde)(ログインも)
- [Proton VPN](https://chromewebstore.google.com/detail/jplgfhpmjnbigmhklmmbgecoobifkmpa)(ログインも)
- [uBlock](https://chromewebstore.google.com/detail/epcnnfbjfcgphgdmggkamkmgojdagdnn)
- [Vimium](https://chromewebstore.google.com/detail/dbepggeogbaibhgnhhndojpepiihcmeb)(Custom key mappingを以下の通りに)
```
unmap J
unmap K
map J nextTab
map K previousTab
```
- [左サイドバー(自作)](https://github.com/shizukani-cp/sidebar_left)
### 設定
- [パスワードマネージャー無効化](edge://wallet/settings#settings-passwords-section)
- [閲覧履歴削除](edge://settings/privacy/clearBrowsingData/clearOnClose)
- [ダークテーマ](edge://settings/appearance)
- [検索エンジンDuckDuckGo化](edge://settings/privacy/services/search/searchEngines)
- [垂直タブバー](edge://settings/appearance/tabs)
## Windows全体
### アプリ
- [CurvosSKK](https://github.com/nathancorvussolis/corvusskk/releases)
- [AutoHotKey](https://www.autohotkey.com/download/)(2.0)
### 設定
- クリップボード履歴ON: システム > クリップボード
- 固定キー機能OFF: アクセシビリティ > キーボード
- タスクバー左寄せ: 個人用設定 > タスクバー > タスクバーの動作
- IME CurvosSKK化: 時刻と言語 > 言語と地域 > 日本語の右の三点 > 言語のオプション > キーボードの追加
### その他
- AHKスクリプトをスタートで実行: dotfilesのものにショートカットを作成 > コピー > Win + R > shell:startup > ペースト
