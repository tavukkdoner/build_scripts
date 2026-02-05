#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
rm -rf prebuilts/clang/host/linux-x86
# rm -rf frameworks/base
# rm -rf kernel/xiaomi/mithorium-4.19/kernel
# rm -rf hardware/mithorium/
# rm -rf hardware/qcom-caf/msm8937

# Init Rom Manifest
repo init --depth=1 --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16-QPR2 -g default,-mips,-darwin,-notdefault

# Clone local_manifests repository
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a16-final-infinity .repo/local_manifests

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

# cd frameworks/av
# it fetch https://github.com/LineageOS/android_frameworks_av refs/changes/14/468714/1 && git cherry-pick FETCH_HEAD
# cd ../..

# cd frameworks/native
# curl https://github.com/VoltageOS/frameworks_native/commit/7e4df9a63981d6796d31e810a427b7d58c0d4dc7.patch | git am
# cd ../..

#cd vendor/lineage
#curl https://github.com/tavukkdoner/android_vendor_crdroid/commit/56cfbd73169367e57d5a8aed169b0ac89eb41958.patch | git am
#cd ../..

cd device/lineage/sepolicy
curl https://github.com/tavukkdoner/android_device_crdroid_sepolicy/commit/b4eec83467aa3bfd7473ebcac9a6424bf10075c7.patch | git am
cd ../../..

# Set up build environment
export BUILD_USERNAME=tavukkdoner 
export BUILD_HOSTNAME=crave

source build/envsetup.sh

#if [ ! -e "vendor/lineage-priv" ]; then
#    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
#    chmod +x create-signed-env.sh
#    ./create-signed-env.sh
#fi

cd build/make
curl https://github.com/tavukkdoner/android_build/commit/02b273229d018d2bfaff989e2289420736d83bfc.patch | git am
cd ../..

# cd system/core
# curl https://github.com/tavukkdoner/android_system_core/commit/fd885f14692478d52ffd8de2d02131fd0b5357fe.patch | git am
# cd ../..

export WITH_GMS=false
export TARGET_BOOT_ANIMATION_RES=720
export WITH_GAPPS=false
export TARGET_ENABLE_BLUR=true
export UCLAMP_FEATURE_ENABLED=false
export TARGET_USES_VULKAN=false
export TARGET_USES_MAGICPORTRAIT=true

if [ ! -e "vendor/infinity-priv" ]; then
    git clone https://github.com/ProjectInfinity-X/vendor_infinity-priv_keys-template vendor/infinity-priv/keys
    cd vendor/infinity-priv/keys
    chmod +x keys.sh
    ./keys.sh
    cd ../../../
fi


# https://android.googlesource.com/platform/hardware/interfaces/+/refs/tags/android-15.0.0_r23
# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/421399
# lunch lineage_Mi439_4_19-bp1a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-bp1a-eng && make installclean && mka bacon

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/433445
lunch infinity_Mi439_4_19-userdebug && make installclean && mka bacon
# lunch infinity_Mi439_4_19-eng && make installclean && mka bacon

#brunch Mi439_4_19 userdebug
