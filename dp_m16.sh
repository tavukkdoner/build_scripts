#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
rm -rf prebuilts/clang/host/linux-x86
#rm -rf packages/modules/adb
#rm -rf kernel/xiaomi/mithorium-4.19
# rm -rf hardware/mithorium/
# rm -rf hardware/qcom-caf/msm8937

# Init Rom Manifest
repo init -u https://github.com/DerpFest-AOSP/android_manifest.git -b 16 --git-lfs

# Clone local_manifests repository
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a16-final-de .repo/local_manifests

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

source build/envsetup.sh

cd vendor/google/gms
rm -rf gms-vendor.mk
curl -O https://raw.githubusercontent.com/tavukkdoner/temp/refs/heads/main/gms-vendor.mk
cd ../../..

if [ ! -e "vendor/lineage-priv" ]; then
    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
    chmod +x create-signed-env.sh
    ./create-signed-env.sh
fi

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/433445
lunch lineage_Mi439_4_19-bp2a-userdebug && make installclean && mka derp
# lunch lineage_Mi439_4_19-bp2a-eng && make installclean && mka bacon
