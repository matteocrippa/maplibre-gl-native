if [[ "$CI" ]]; then
  echo "CI environment, access token not required"
  exit 0
else
  echo "Inserting Mapbox access token..."
  token_file=~/.mapbox
  token_file2=~/mapbox
  token="$(cat $token_file 2>/dev/null || cat $token_file2 2>/dev/null)"
  if [ "$token" ]; then
    plutil -replace MGLMapboxAccessToken -string $token "$TARGET_BUILD_DIR/$INFOPLIST_PATH"
    echo "Token insertion successful"
  else
    echo \'Warning: Missing Mapbox access token.  You can optionally use MapLibre with Mapbox Styles\'
    echo "Warning: Get an access token from <https://www.mapbox.com/studio/account/tokens/>, then create a new file at $token_file that contains the access token."
  fi
fi
