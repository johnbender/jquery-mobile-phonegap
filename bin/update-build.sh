if [ -z "$PHONEGAP_PASS" -o -z "$PHONEGAP_USER" -o -z "$PHONEGAP_APP" ]; then
  echo "PHONEGAP_(PASS|USER|APP) must be defined in the environment"
  exit 1
fi

echo "creating app tar.gz"
tar --exclude="debug" --exclude="jquery-mobile" --exclude=".git*" --exclude="bin" --exclude="update.*" -czvf "update.tar.gz" .

echo "pushing the updated app tar"
curl -u $PHONEGAP_USER:$PHONEGAP_PASS -X PUT -d 'data={"version":"0.1.0"}' https://build.phonegap.com/api/v1/apps/$PHONEGAP_APP