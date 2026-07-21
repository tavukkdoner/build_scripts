#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
# error: Unable to fully sync the tree
# error: Updating local project lists failed.
# Try re-running with "-j1 --fail-fast" to exit at the first error.
# ================================================================================
# Repo command failed due to the following `SyncError` errors:
# error: prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9: Cannot remove project: uncommitted changes are present.
rm -rf prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9

# Init Rom Manifest
#repo init -u https://github.com/Evolution-X/manifest -b bka --git-lfs
#repo init -u https://github.com/Evolution-X/manifest -b bq1 --git-lfs
repo init -u https://github.com/Evolution-X/manifest -b cnb --git-lfs --depth 1

# Clone local_manifests repository
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a17-final-evo .repo/local_manifests

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

# if [ ! -e "vendor/lineage-priv" ]; then
#     curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
#     chmod +x create-signed-env.sh
#     ./create-signed-env.sh
# fi

#cd frameworks/av
#git fetch https://github.com/LineageOS/android_frameworks_av refs/changes/14/468714/1 && git cherry-pick FETCH_HEAD
#cd ../..

cd device/lineage/sepolicy
curl https://github.com/tavukkdoner/android_device_crdroid_sepolicy/commit/b4eec83467aa3bfd7473ebcac9a6424bf10075c7.patch | git am
cd ../../..

cd build/make
curl https://github.com/tavukkdoner/android_build/commit/02b273229d018d2bfaff989e2289420736d83bfc.patch | git am
cd ../..

#cd system/core
#curl https://github.com/tavukkdoner/android_system_core/commit/fd885f14692478d52ffd8de2d02131fd0b5357fe.patch | git am
#cd ../..

if [ ! -e "vendor/evolution-priv" ]; then
    git clone https://github.com/Evolution-X/vendor_evolution-priv_keys-template vendor/evolution-priv/keys
    cd vendor/evolution-priv/keys
    chmod +x keys.sh
    ./keys.sh
    cd ../../../
fi

export WITH_GMS=false
export TARGET_ENABLE_BLUR=true
export TARGET_USES_VULKAN=false
export UCLAMP_FEATURE_ENABLED=false
export LTO_FEATURE_ENABLED=true
#export TARGET_USES_EROFS=true
export TARGET_USES_PICO_GAPPS=false
# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/490985
#lunch lineage_Mi439_4_19-bp3a-userdebug && make installclean && m evolution
lunch lineage_Mi439_4_19-cp2a-userdebug && make installclean && m evolution
#lunch lineage_Mi439_4_19-bp2a-eng && make installclean && m evolution
