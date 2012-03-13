if [ -z "$PHONEGAP_PASS" ]; then
  echo "PHONEGAP_PASS must be defined in the environment"
  exit 1
fi

git submodule init
git submodule update

cd jquery-mobile
sha=$(git rev-parse HEAD)
make docs
cd ..

# TODO sort out if it's possible to directly reference the jquerymobile submodule
echo "updating the application assets to the latest jqm"
cp jquery-mobile/compiled/jquery.mobile.js assets/js/
cp jquery-mobile/compiled/jquery.mobile.css assets/css/
cp jquery-mobile/js/jquery.js assets/js/

echo "creating app tar.gz"
tar --exclude="jquery-mobile" --exclude=".git*" --exclude="update.*" -czvf "update.tar.gz" .

echo "pushing the updated app tar"
curl -u nous.placidus@gmail.com:$PHONEGAP_PASS -X PUT -d 'data={"version":"0.1.0"}' https://build.phonegap.com/api/v1/apps/$PHONEGAP_APP