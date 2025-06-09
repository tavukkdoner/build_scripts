#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
# rm -rf frameworks/base
# rm -rf kernel/xiaomi/mithorium-4.19/kernel
# rm -rf hardware/mithorium/

# Init Rom Manifest
repo init -u https://github.com/AxionAOSP/android.git -b lineage-22.2 --git-lfs

# Clone local_manifests repository
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests 
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-avc1-viperfx .repo/local_manifests
# git clone https://github.com/tavukkdoner/local_manifests1.git --depth 1 -b a15-crdroid-mithorium .repo/local_manifests 
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a15-qpr2-axion .repo/local_manifests

# Original local_manifest Mi439 A15 QPR2 no modifications -> a15-qpr2-mithorium
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a15-qpr2-mithorium .repo/local_manifests

# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests && 
# if [ ! $? == 0 ]
# then   curl -o .repo/local_manifests https://github.com/tavukkdoner/local_manifests.git
#  echo "Git clone failed, downloading through curl instead..."
# fi 

# Sync the repositories  
/opt/crave/resync.sh 
# /opt/crave/resynctest.sh

# cd frameworks/av/media/libstagefright/data/
# curl -O https://raw.githubusercontent.com/tavukkdoner/patches/refs/heads/main/media_codecs_sw.xml
# cd ../../../../../

# Set up build environment
export BUILD_USERNAME=tavukkdoner 
export BUILD_HOSTNAME=crave

source build/envsetup.sh

if [ ! -e "vendor/lineage-priv" ]; then
    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
    chmod +x create-signed-env.sh
    ./create-signed-env.sh
fi


# https://android.googlesource.com/platform/hardware/interfaces/+/refs/tags/android-15.0.0_r23
# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/421399
axion Mi439_4_19 va
# lunch lineage_Mi439_4_19-bp1a-eng && make installclean && mka bacon
# export TARGET_USES_EROFS=true
# axion Mi439_4_19 gms pico
# https://github.com/AxionAOSP/android_build/blob/lineage-22.2/envsetup.sh#L1383
# ax -br
brunch Mi439_4_19

