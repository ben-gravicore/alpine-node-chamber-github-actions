#!/bin/bash

function reactBuild {

  chamber export cel-borrower-$DEPLOYMENT_STAGE -f dotenv | grep -e AWS_REGION -e ADMIN_COGNITO_USER_POOL_ID -e ADMIN_COGNITO_CLIENT_ID -e ADMIN_COGNITO_IDENTITY_POOL_ID -e ADMIN_COGNITO_DOMAIN_NAME -e ADMIN_APPSYNC_URIS -e ADMIN_DATADOG_RUM_CLIENT_TOKEN -e ADMIN_DATADOG_RUM_APPLICATION_ID > .env
  sed -i -e 's/^/REACT_APP_/' .env && cat .env
  yarnOutput=$(yarn install)
  yarnExitCode=${?}
  
  # Exit code of 0 indicates success. Print the output and exit.
  if [ ${yarnExitCode} -ne 0 ]; then
    echo "react-build: error: yarn install failed"
    echo "${yarnOutput}"
    echo
    exit ${yarnExitCode}
  fi

  yarnOutput=$(CI=false yarn run build)
  yarnExitCode=${?}

  # Exit code of 0 indicates success. Print the output and exit.
  if [ ${yarnExitCode} -ne 0 ]; then
    echo "react-build: error: yarn run build failed"
    echo "${yarnOutput}"
    echo
    exit ${yarnExitCode}
  fi

  exit ${yarnExitCode}
}
