#!/bin/sh


#input params
FASTLANE_NAME=$1

if [[ "$FASTLANE_NAME" ]]; then

    echo ""
    echo "********************************"
    echo "* Checking CI *"
    echo "********************************"
    echo ""

    CI_NAME=""
    CI_BRANCH=""
    CI_EMAIL=""
    IS_PR=false

    if [[ "$CIRCLECI" == "true" ]]; then

        CI_NAME="Circle CI"
        CI_BRANCH="$CIRCLE_BRANCH"
        CI_EMAIL="circleci@flatstack.com"
        IS_PR=$CI_PULL_REQUEST

    elif [[ "$TRAVIS" == "true" ]]; then

        CI_NAME="Travis CI"
        CI_BRANCH="$TRAVIS_BRANCH"
        CI_EMAIL="travisci@flatstack.com"
        IS_PR=$TRAVIS_PULL_REQUEST

    else
        echo "Unknown CI"
        exit 1
    fi

    echo ""
    echo "********************************"
    echo "* Checking branch *"
    echo "********************************"
    echo ""

    echo "$CI_NAME running on $CI_BRANCH branch..."

#    if [[ "$IS_PR" == "true" ]]; then
#        echo "This is a pull request. No deployment will be done."
#        exit 0
#    fi

    echo ""
    echo "********************************"
    echo "* Config *"
    echo "********************************"
    echo ""

    git config --global user.name $CI_NAME
    git config --global user.email $CI_EMAIL
    echo "username is $CI_NAME"
    echo "email is $CI_EMAIL"

    echo ""
    echo "********************************"
    echo "* Info *"
    echo "********************************"
    echo ""

    git remote -v

    git branch --list

    echo ""
    echo "********************"
    echo "* Uploading... *"
    echo "********************"
    echo ""

    bundle exec fastlane ios $FASTLANE_NAME remove_local_tags:false

else
    echo "Missing required parameter FASTLANE_NAME"
    exit 1
fi
