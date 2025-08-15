#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
# rm -rf prebuilts/clang/host/linux-x86
# rm -rf frameworks/base
# rm -rf kernel/xiaomi/mithorium-4.19/kernel
# rm -rf hardware/mithorium/
# rm -rf hardware/qcom-caf/msm8937

# Init Rom Manifest
repo init --depth=1 -u https://github.com/VoltageOS/manifest.git -b 16 --git-lfs

# Clone local_manifests repository
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a16-final-voltage .repo/local_manifests

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

source build/envsetup.sh

#if [ ! -e "vendor/lineage-priv" ]; then
#    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
#    chmod +x create-signed-env.sh
#    ./create-signed-env.sh
#fi

export WITH_GMS=false
export TARGET_BOOT_ANIMATION_RES=1280
export WITH_GAPPS=false

#git clone https://github.com/VoltageOS/vendor_voltage-priv_keys -b 16 vendor/voltage-priv/keys
#cd vendor/voltage-priv/keys
#chmod +x keys.sh
#./keys.sh
#cd ../../../

# https://android.googlesource.com/platform/hardware/interfaces/+/refs/tags/android-15.0.0_r23
# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/421399
# lunch lineage_Mi439_4_19-bp1a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-bp1a-eng && make installclean && mka bacon

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/433445
lunch voltage_Mi439_4_19-bp2a-userdebug && make installclean && mka bacon
# lunch voltage_Mi439_4_19-bp2a-eng && make installclean && mka bacon

#brunch Mi439_4_19 userdebug
