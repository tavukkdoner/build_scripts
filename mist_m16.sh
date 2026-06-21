#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
#rm -rf prebuilts/clang/host/linux-x86
#rm -rf packages/modules/adb
#rm -rf kernel/xiaomi/mithorium-4.19
# rm -rf hardware/mithorium/
# rm -rf hardware/qcom-caf/msm8937

# Init Rom Manifest
repo init -u https://github.com/Project-Mist-OS/manifest -b 16.2 --git-lfs --depth=1

# Clone local_manifests repository
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a16-final-mist .repo/local_manifests

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

cd build/make
curl https://github.com/tavukkdoner/android_build/commit/02b273229d018d2bfaff989e2289420736d83bfc.patch | git am
cd ../..

cd device/lineage/sepolicy
curl https://github.com/tavukkdoner/android_device_crdroid_sepolicy/commit/b4eec83467aa3bfd7473ebcac9a6424bf10075c7.patch | git am
cd ../../..

# Set up build environment
export BUILD_USERNAME=tavukkdoner 
export BUILD_HOSTNAME=crave
export TARGET_ENABLE_BLUR=true
export UCLAMP_FEATURE_ENABLED=false
export DEX2OAT_THREADS=4
export DEX2OAT_CORES=4,5,6,7
export WITH_GMS=false
export TARGET_DEFAULT_PIXEL_LAUNCHER=false
export TARGET_BOOT_ANIMATION_RES=720
export TARGET_USES_VULKAN=false

source build/envsetup.sh

if [ ! -e "vendor/lineage-priv" ]; then
    git clone https://github.com/tavukkdoner/crDroid-build-signed-script1 vendor/key-generator
    cd vendor/key-generator
    chmod +x create-signed-env.sh
    ./create-signed-env.sh
    cd ../..
fi

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/433445
# lunch lineage_Mi439_4_19-bp2a-userdebug
mistify Mi439_4_19 userdebug
make installclean
mist b
# lunch lineage_Mi439_4_19-bp2a-eng && make installclean && mka bacon
