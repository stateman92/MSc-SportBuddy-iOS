#!/bin/bash

getPackageVersion () {
  local PACKAGE_VERSION=$(cat SportBuddy/SportBuddy.xcodeproj/project.pbxproj | grep MARKETING_VERSION)
  echo $(echo "$PACKAGE_VERSION" | xargs | cut -d '=' -f2 | cut -d ';' -f1)
}

PACKAGE_VERSION="$(getPackageVersion)"

MAJOR=$(echo $PACKAGE_VERSION | cut -d '.' -f1)
MINOR=$(echo $PACKAGE_VERSION | cut -d '.' -f2)
PATCH=$(echo $PACKAGE_VERSION | cut -d '.' -f3)

patch () {
  echo "PATCH UPDATE"
  echo "It was: $PACKAGE_VERSION"
  NEW_PATCH=$((PATCH+1))
  SEARCH="MARKETING_VERSION = $PACKAGE_VERSION"
  REPLACE="MARKETING_VERSION = $MAJOR.$MINOR.$NEW_PATCH"
  sed -i '' "s/$SEARCH/$REPLACE/g" SportBuddy/SportBuddy.xcodeproj/project.pbxproj
  echo "Now: $(getPackageVersion)"
}

minor () {
  echo "MINOR UPDATE"
  echo "It was: $PACKAGE_VERSION"
  NEW_MINOR=$((MINOR+1))
  SEARCH="MARKETING_VERSION = $PACKAGE_VERSION"
  REPLACE="MARKETING_VERSION = $MAJOR.$NEW_MINOR.0"
  sed -i '' "s/$SEARCH/$REPLACE/g" SportBuddy/SportBuddy.xcodeproj/project.pbxproj
  echo "Now: $(getPackageVersion)"
}

major () {
  echo "MAJOR UPDATE"
  echo "It was: $PACKAGE_VERSION"
  NEW_MAJOR=$((MAJOR+1))
  SEARCH="MARKETING_VERSION = $PACKAGE_VERSION"
  REPLACE="MARKETING_VERSION = $NEW_MAJOR.0.0"
  sed -i '' "s/$SEARCH/$REPLACE/g" SportBuddy/SportBuddy.xcodeproj/project.pbxproj
  echo "Now: $(getPackageVersion)"
}

shopt -s nocasematch

if [ -z "$1" ]
then
  patch
else
  if [[ "$1" == *"major"* ]]
  then
    major
  elif [[ "$1" == *"minor"* ]]
  then
    minor
  else
    # fallback to patch
    patch
  fi
fi