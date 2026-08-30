#!/bin/bash

# Generate DevWorkspace manifests for 15 users
# Each user gets their own repository

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE="$SCRIPT_DIR/devworkspace-template.yaml"
MANIFESTS_DIR="$SCRIPT_DIR/manifests"

mkdir -p "$MANIFESTS_DIR"

for i in $(seq -f "%02g" 1 15); do
  USER_NUM="$i"
  USER_NAMESPACE="user-$i-devspaces"
  USER_REPO_URL="https://github.com/syamaguc-demo/github-actions-ops-workshop-user-$i.git"
  OUTPUT_FILE="$MANIFESTS_DIR/devworkspace-user-$i.yaml"

  echo "Generating: $OUTPUT_FILE"

  # Replace placeholders
  sed -e "s|USER_NAMESPACE|$USER_NAMESPACE|g" \
      -e "s|USER_REPO_URL|$USER_REPO_URL|g" \
      "$TEMPLATE" > "$OUTPUT_FILE"
done

echo ""
echo "✅ Generated 15 DevWorkspace manifests in $MANIFESTS_DIR"
echo ""
echo "Next steps:"
echo "  cd $(dirname $SCRIPT_DIR)"
echo "  git add devworkspaces/manifests/"
echo "  git commit -m 'Update DevWorkspaces to use individual user repositories'"
echo "  git push"
