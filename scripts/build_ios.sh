#!/usr/bin/env bash

# Copyright (c) 2022. Alexandr Moroz

echo "BUILDING FOR iOS..."

flutter build ios

# iOS - без подписи. Шаг выше всё равно нужен для обновления инфы о версии
#appName="Hercules"
#cd ./ios/ || exit
#xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Release clean archive -archivePath "../build/ios/${appName}.xcarchive" CODE_SIGN_IDENTITY="" CODE_SIGNING_ALLOWED="NO"

echo "BUILDING FOR iOS COMPLETE"
