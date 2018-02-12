# android-docker-slim [![CircleCI](https://circleci.com/gh/mmastrac/android-docker-slim.svg?style=svg)](https://circleci.com/gh/mmastrac/android-docker-slim)

The bitrise.io android-ndk image (https://hub.docker.com/r/bitriseio/android-ndk/, source at https://github.com/bitrise-docker/android-ndk) is far bigger than it needs to be. This is partly because it could be built more efficiently, and partly because it contains system images for a number of SDKs that aren't always necessary for a build machine that isn't running tests.

This image uses the bitrise.io image as a base, removing unnecessary packages and rebuilding it as a set of layers that are approximately 2x as fast to pull from scratch (at least when building in non-bitrise environments!).

New builds are automatically pushed to https://hub.docker.com/r/mmastrac/bitrise-android-ndk-trimmed/tags/
