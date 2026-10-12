#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 

# Init Rom Manifest
repo init -u https://github.com/PixelOS-AOSP/android_manifest.git -b seventeen --git-lfs --depth 1

# Clone local_manifests repository
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a17-final-pixel .repo/local_manifests

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

cd vendor/pixel/gms/common
rm -rf common-vendor.mk
curl -O https://raw.githubusercontent.com/tavukkdoner/temp/refs/heads/main/common-vendor.mk
cd ../../../..

cd device/lineage/sepolicy
curl https://github.com/tavukkdoner/android_device_crdroid_sepolicy/commit/b4eec83467aa3bfd7473ebcac9a6424bf10075c7.patch | git am
cd ../../..

# Set up build environment
export TARGET_ENABLE_BLUR=true
export TARGET_USES_VULKAN=false
export UCLAMP_FEATURE_ENABLED=false

source build/envsetup.sh

if [ ! -e "vendor/lineage-priv" ]; then
    rm -rf vendor/key-generator
    git clone https://github.com/tavukkdoner/crDroid-build-signed-script1 -b 17.0 vendor/key-generator
    cd vendor/key-generator
    chmod +x create-signed-env.sh
    ./create-signed-env.sh
    cd ../..
fi

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/433445
lunch custom_Mi439_4_19-cp2a-userdebug && make installclean && m pixelos
# lunch lineage_Mi439_4_19-bp2a-eng && make installclean && mka bacon
