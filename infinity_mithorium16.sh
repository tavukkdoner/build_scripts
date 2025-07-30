#!/bin/bash

# Remove Local Manifests
#rm -rf .repo/local_manifests/ 
#rm -rf prebuilts/clang/host/linux-x86
# rm -rf frameworks/base
# rm -rf kernel/xiaomi/mithorium-4.19/kernel
# rm -rf hardware/mithorium/
# rm -rf hardware/qcom-caf/msm8937

# Init Rom Manifest
#repo init --depth=1 --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault

# Clone local_manifests repository
#git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a16-final-infinity .repo/local_manifests

# Original local_manifest Mi439 A15 QPR2 no modifications -> a15-qpr2-mithorium
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a15-qpr2-mithorium .repo/local_manifests

# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests && 
# if [ ! $? == 0 ]
# then   curl -o .repo/local_manifests https://github.com/tavukkdoner/local_manifests.git
#  echo "Git clone failed, downloading through curl instead..."
# fi 

# Sync the repositories  
#/opt/crave/resync.sh 
# /opt/crave/resynctest.sh


# Set up build environment
export BUILD_USERNAME=tavukkdoner 
export BUILD_HOSTNAME=crave

source build/envsetup.sh

#if [ ! -e "vendor/lineage-priv" ]; then
#    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
#    chmod +x create-signed-env.sh
#    ./create-signed-env.sh
#fi

export WITH_GMS=false
export TARGET_BOOT_ANIMATION_RES=720

#git clone https://github.com/ProjectInfinity-X/vendor_infinity-priv_keys-template vendor/infinity-priv/keys
#cd vendor/infinity-priv/keys
#chmod +x keys.sh
#./keys.sh
#cd ../../../

# https://android.googlesource.com/platform/hardware/interfaces/+/refs/tags/android-15.0.0_r23
# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/421399
# lunch lineage_Mi439_4_19-bp1a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-bp1a-eng && make installclean && mka bacon

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/433445
lunch infinity_Mi439_4_19-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-bp2a-eng && make installclean && mka bacon

#brunch Mi439_4_19 userdebug
