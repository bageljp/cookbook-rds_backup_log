What's ?
===============
chef で使用する RDSのログバックアップ の cookbook です。
AWS管理コンソールから参照出来るRDSのログは1日分しかありません。
以下にあったスクリプトを元に改変してます。
- http://blog.suz-lab.com/2013/05/rubyrds.html
- http://blog.suz-lab.com/2013/05/rdss3.html

Usage
-----
cookbook なので berkshelf で取ってきて使いましょう。

* Berksfile
```ruby
source "https://supermarket.chef.io"

cookbook "rds_backup_log", git: "https://github.com/bageljp/cookbook-rds_backup_log.git"
```

```
berks vendor
```

#### Role and Environment attributes

* sample_role.rb
```ruby
override_attributes(
  "rds_backup_log" => {
    "rotate" => "31"
    "instances" => [ "prod-rds-db01", "stg-rds-db01" ],
    "user" => "user_name",
    "group" => "group_name"
  }
)
```

スクリプトを実行するEC2インスタンスは対象のRDSが参照できること（要IAM Role）。

Recipes
----------

#### rds_backup_log::default
RDSのログバックアップスクリプトをセットアップして cron の設定を行う。

Attributes
----------

主要なやつのみ。

#### rds_backup_log::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['rds_backup_log']['instances']</tt></td>
    <td>array string</td>
    <td>対象のRDSを配列形式で指定。</td>
  </tr>
  <tr>
    <td><tt>['rds_backup_log']['root_dir']</tt></td>
    <td>string</td>
    <td>スクリプト一式をダウンロードする先。</td>
  </tr>
  <tr>
    <td><tt>['rds_backup_log']['backup_dir']</tt></td>
    <td>string</td>
    <td>バックアップ先のディレクトリ。</td>
  </tr>
  <tr>
    <td><tt>['rds_backup_log']['cron']['user']</tt></td>
    <td>string</td>
    <td>RDSログバックアップの実行ユーザ。指定したユーザのcronに設定される。</td>
  </tr>
  <tr>
    <td><tt>['rds_backup_log']['cron']['hour']</tt></td>
    <td>string</td>
    <td>RDSログバックアップを実行する時間。cronに設定される</td>
  </tr>
  <tr>
    <td><tt>['rds_backup_log']['cron']['minute']</tt></td>
    <td>string</td>
    <td>RDSログバックアップを実行する分。cronに設定される</td>
  </tr>
</table>

TODO
----------

* S3にバックアップできるといいかも。

