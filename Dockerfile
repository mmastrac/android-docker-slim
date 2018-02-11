FROM bitriseio/android-ndk:latest
RUN rm -rf /tmp/*
RUN rm -rf /opt/android-sdk-linux/system-images
RUN rm -rf /usr/lib/node_modules
RUN apt-get clean
# Don't need these - neuter policy-rc to allow us to delete packages that it thinks could be running (they aren't)
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
RUN sudo dpkg --remove --force-all libllvm3.8 libllvm5.0 nodejs clang-3.8 docker-ce llvm-3.8-dev libgl1-mesa-dri
# Bake gradle 2.14.1-all in
RUN gradle wrapper --gradle-distribution-url https://services.gradle.org/distributions/gradle-2.14.1-all.zip
RUN ./gradlew

FROM scratch
# Big ones first!
COPY --from=0 /opt/android-sdk-linux /opt/android-sdk-linux
COPY --from=0 /opt/android-ndk /opt/android-ndk
COPY --from=0 /bin /bin
COPY --from=0 /etc /etc
COPY --from=0 /lib /lib
COPY --from=0 /lib64 /lib64
COPY --from=0 /sbin /sbin
COPY --from=0 /sys /sys
COPY --from=0 /usr /usr

ENV ANDROID_HOME /opt/android-sdk-linux
ENV ANDROID_NDK_HOME /opt/android-ndk
ENV ANDROID_NDK_VERSION r16b

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_NDK_HOME}
ENV GCLOUD_SDK_CONFIG /usr/lib/google-cloud-sdk/lib/googlecloudsdk/core/config.json

ENV QT_QPA_PLATFORM offscreen
ENV LD_LIBRARY_PATH ${ANDROID_HOME}/tools/lib64:${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/qt/lib
