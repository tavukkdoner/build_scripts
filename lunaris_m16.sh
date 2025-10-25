#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
rm -rf prebuilts/clang/host/linux-x86
#rm -rf packages/modules/adb
#rm -rf kernel/xiaomi/mithorium-4.19
# rm -rf hardware/mithorium/
# rm -rf hardware/qcom-caf/msm8937

# Init Rom Manifest
repo init -u https://github.com/Lunaris-AOSP/android -b 16 --git-lfs

# Clone local_manifests repository
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a16-final-lunaris .repo/local_manifests

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

# Set up build environment
export BUILD_USERNAME=tavukkdoner 
export BUILD_HOSTNAME=crave
export TARGET_ENABLE_BLUR=true
export UCLAMP_FEATURE_ENABLED=true
export TARGET_DEFAULT_PIXEL_LAUNCHER=false
export DEX2OAT_THREADS=2
export DEX2OAT_CORES=6,7
export WITH_BCR=true
export WITH_GMS=false

source build/envsetup.sh

if [ ! -e "vendor/lineage-priv" ]; then
    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
    chmod +x create-signed-env.sh
    ./create-signed-env.sh
fi

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/433445
lunch lineage_Mi439_4_19-bp2a-userdebug && make installclean && m lunaris
# lunch lineage_Mi439_4_19-bp2a-eng && make installclean && mka bacon
