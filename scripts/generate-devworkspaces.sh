#!/bin/bash
#
# generate-devworkspaces.sh
#
# user-01 〜 user-15 の DevWorkspace マニフェストを生成

set -e

OUTPUT_DIR="${1:-../gitops/devworkspaces/manifests}"
TEMPLATE_FILE="../gitops/devworkspaces/devworkspace-template.yaml"

mkdir -p "$OUTPUT_DIR"

echo "=== DevWorkspace マニフェスト生成 ==="
echo "出力先: $OUTPUT_DIR"
echo ""

for i in $(seq -w 1 15); do
  USER="user-$i"
  NAMESPACE="${USER}-devspaces"
  BRANCH="${USER}"

  echo "生成中: $USER ($NAMESPACE)"

  # Namespace マニフェスト
  cat > "$OUTPUT_DIR/namespace-$USER.yaml" <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: $NAMESPACE
  labels:
    workshop: github-actions
    user: $USER
EOF

  # DevWorkspace マニフェスト
  sed -e "s/USER_NAMESPACE/$NAMESPACE/g" \
      -e "s/USER_BRANCH/$BRANCH/g" \
      "$TEMPLATE_FILE" > "$OUTPUT_DIR/devworkspace-$USER.yaml"
done

# Kustomization.yaml 生成
cat > "$OUTPUT_DIR/kustomization.yaml" <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
EOF

for i in $(seq -w 1 15); do
  USER="user-$i"
  echo "  - namespace-$USER.yaml" >> "$OUTPUT_DIR/kustomization.yaml"
  echo "  - devworkspace-$USER.yaml" >> "$OUTPUT_DIR/kustomization.yaml"
done

echo ""
echo "✓ 生成完了: $OUTPUT_DIR"
echo "  - namespace-user-*.yaml (15ファイル)"
echo "  - devworkspace-user-*.yaml (15ファイル)"
echo "  - kustomization.yaml"
