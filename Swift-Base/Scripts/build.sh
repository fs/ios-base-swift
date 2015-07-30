#!/bin/sh
xcodebuild -workspace Swift-Base.xcworkspace -scheme Production -sdk iphoneos -configuration Release OBJROOT=$PWD/build SYMROOT=$PWD/build ONLY_ACTIVE_ARCH=NO CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO | xcpretty -c && exit ${PIPESTATUS[0]}
