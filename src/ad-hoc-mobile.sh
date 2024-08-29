#!/bin/bash

cd ../mobile/fastlane

# Build and upload ios
bundle exec fastlane ios build_ad_hoc
IOS_OUTPUT=$(bundle exec fastlane ios upload_ad_hoc)
echo "$IOS_OUTPUT"
IOS_LINK=$(echo "$IOS_OUTPUT" | grep -wns Link:)

# Build and upload android 
bundle exec fastlane android build_ad_hoc
ANDROID_OUTPUT=$(bundle exec fastlane android upload_ad_hoc)
ANDROID_LINK=$(echo "$ANDROID_OUTPUT" | grep -wns Link:)

# Echo and label the links
BRANCH=$(git rev-parse --abbrev-ref HEAD)
TEAM=$(echo $BRANCH | cut -d '-' -f1)
PR_NUMBER=$(echo $BRANCH | cut -d'-' -f2)
INVESTOR_IOS_LINK=$(echo $IOS_LINK | awk -F'Link: ' '{print $2}')
INVESTOR_ANDROID_LINK=$(echo $ANDROID_LINK | awk -F'Link: ' '{print $2}')
echo "Branch: $TEAM-$PR_NUMBER"
echo "🍎 iOS Link: $INVESTOR_IOS_LINK"
echo "🤖 Android Link: $INVESTOR_ANDROID_LINK"
echo "Local commit sha: $(git rev-parse HEAD)"