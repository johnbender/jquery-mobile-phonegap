git submodule init
git submodule update
cd jquery-mobile
sha=$(git rev-parse HEAD)
make docs
cd ..
# TODO sort out if we can just directly reference the jquerymobile submodule
cp jquery-mobile/compiled/jquery.mobile.js assets/js/
cp jquery-mobile/compiled/jquery.mobile.css assets/css/
cp jquery-mobile/js/jquery.js assets/js/
git add assets
git commit -m "update assets from latest jquerymobile at $sha"
