
perl -pi -e 's/^(.*openapi:?)$/#$1/g' "pubspec.yaml"
flutter pub get

bash ./scripts/api_generate.sh

perl -pi -e 's/^#(.*openapi:?)$/$1/g' "pubspec.yaml"

bash ./scripts/build_runner_clean.sh
bash ./scripts/build_runner_build.sh