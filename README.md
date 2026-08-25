# GitHub Actions Workshop - GitOps Repository

このリポジトリは OpenShift GitOps (Argo CD) で管理する DevWorkspace マニフェストを格納しています。

## 構成

- `devworkspaces/manifests/` - 15ユーザ分の DevWorkspace マニフェスト
  - `namespace-user-*.yaml` - ユーザ専用 Namespace (15ファイル)
  - `devworkspace-user-*.yaml` - DevWorkspace リソース (15ファイル)
  - `kustomization.yaml` - Kustomize 設定

## デプロイ方法

### 手動デプロイ

```bash
oc apply -k devworkspaces/manifests/
```

### Argo CD によるデプロイ

Argo CD Application リソースを使用:

```bash
oc apply -f application.yaml
```

## 環境情報

- OpenShift: 4.18.52
- DevSpaces: 3.29.1
- 対象ユーザ: user-01 〜 user-15
