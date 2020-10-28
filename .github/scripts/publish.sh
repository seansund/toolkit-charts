#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname "$0"); pwd -P)
ROOT_DIR=$(cd "${SCRIPT_DIR}/../.."; pwd -P)

PUBLISH_DIR="$1"
if [[ -z "${PUBLISH_DIR}" ]]; then
  PUBLISH_DIR="tmp"
fi

PUBLISH_DIR="${ROOT_DIR}/${PUBLISH_DIR}"
CHART_DIR="${ROOT_DIR}/stable"

publish_content() {
  cp -n "${PUBLISH_DIR}"/* "${CHART_DIR}"

  rm -rf "${PUBLISH_DIR}"
}

generate_index() {
  helm repo index "${CHART_DIR}" --url "${REPO_URL}/${CHART_DIR}/" --merge "${CHART_DIR}/index.yaml"
  cp "${CHART_DIR}/index.yaml" .
}

publish_content
generate_index
