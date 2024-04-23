# 技術課題
とあるベンチャー企業の iOS TechLead Engineer として、 `GitHub のレポジトリを検索し、一覧表示するアプリ` を開発してください。

## 仮想チーム構成
あなたを含む２人チームを想定します。

* TechLead: あなた。実装作業もする主力エンジニア。
* Member:
   * I さん: あなたのチームに配属されたばかりのエンジニア。チームへのオンボーディングは済んでいます。

チーム内で作業を分担し、担当部分を遂行してください。

## 成果物
提出期限までを 1 スプリントと想定して、期間終了後にスプリントレビューとして成果物デモをしていただき、合わせて技術ディスカッションを実施します。

### 成果物デモで見せていただきたいもの
* あなたが担当した機能が動作する iOS アプリ
* チームとして開発し成果を出すためにあなたが考え行ったこと

成果物についての要件を以下に記載します。

## 開発するアプリについて

### 必須機能
* 検索フィールドを用意し、入力された文字列でレポジトリを検索できること。
* 検索結果が一覧表示されること。
* 一覧での表示項目は以下の通り。
  * レポジトリ名
  * オーナー
  * スター数
  * フォーク数
* ページネーションで20件ごと読み込み。
* 検索結果の任意のレポジトリをタップすると、そのレポジトリの詳細画面に遷移すること。詳細画面の内容はおまかせします（一覧で表示していた内容＋αであればなんでもOKです）。
* ユニットテストを追加すること。

### 技術要件
* GitHub GraphQL API を使用してください。
* OAuthトークンは変数として宣言し、書き換えられるようにお願いいたします。
* 開発言語は Swift を使用してください。
* UI作成は SwiftUI を使用してください。UIKit でしか実現できないところで、UIKit を使用することは構いません。
* サードパーティライブラリは使用せずに実装してください。
* アーキテクチャの選定は自由ですが、評価対象となります。

### 歓迎機能
* アーキテクチャ
* テスト拡充
* 必須要件以外の機能追加
* 検索履歴
* リアクション
* ウォッチ

## 提出期限
* 2024-05-07 23:59:59
  * 成果物提出後1週間以内を目安に、成果物レビューを含む1時間の技術ディスカッションを実施します。

## 課題ディスカッション
* 日時: 2024-05-10 14:30 ~ 15:30
  * Meet: https://meet.google.com/mvd-gmpp-zqw

## 補足
* 成果物はこのリポジトリの　`main` ブランチにコミットを積むことで提出してください。Pull Requests は自由に使っていただいて構いません。
* 質問がある場合、 issue を作成して [@kauche-interview/kauche-ios](https://github.com/orgs/kauche-interview/teams/kauche-ios) 宛にメンションするようにお願いいたします。

## 注意事項
* 技術課題の内容に関しては、口外しないようにお願いいたします。

