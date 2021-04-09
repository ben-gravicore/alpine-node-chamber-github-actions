#!/bin/bash

function stripColors {
  echo "${1}" | sed 's/\x1b\[[0-9;]*m//g'
}

function hasPrefix {
  case ${2} in
    "${1}"*)
      true
      ;;
    *)
      false
      ;;
  esac
}

function parseInputs {
  # Required inputs
  if [ "${INPUT_GRAVICORE_ACTIONS_COMMAND}" != "" ]; then
    gcActionCommand=${INPUT_GRAVICORE_ACTIONS_COMMAND}
  else
    echo "Input gravicore_actions_command cannot be empty"
    exit 1
  fi

  # Optional inputs
  gcWorkingDir="."
  if [[ -n "${INPUT_GC_ACTIONS_WORKING_DIR}" ]]; then
    gcWorkingDir=${INPUT_GC_ACTIONS_WORKING_DIR}
  fi
}

function main {
  # Source the other files to gain access to their functions
  scriptDir=$(dirname ${0})
  source ${scriptDir}/react.sh

  parseInputs
  cd ${GITHUB_WORKSPACE}/${gcWorkingDir}

  case "${gcActionCommand}" in
    react-build)
      # installTerragrunt
      reactBuild ${*}
      ;;
    react-unit-tests)
      # installTerragrunt
      reactUnitTests ${*}
      ;;
    *)
      echo "Error: Must provide a valid value for gravicore_actions_command"
      exit 1
      ;;
  esac
}

main "${*}"
