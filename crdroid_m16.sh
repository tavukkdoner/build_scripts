#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
#rm -rf prebuilts/clang/host/linux-x86
#rm -rf external/chromium-webview
#rm -rf packages/modules/adb
#rm -rf kernel/xiaomi/mithorium-4.19
# rm -rf hardware/mithorium/
# rm -rf hardware/qcom-caf/msm8937

# Init Rom Manifest
repo init -u https://github.com/crdroidandroid/android.git -b 16.0 --git-lfs --no-clone-bundle

# Clone local_manifests repository
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a16-final .repo/local_manifests

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

#cd build/make
#curl https://github.com/tavukkdoner/android_build/commit/02b273229d018d2bfaff989e2289420736d83bfc.patch | git am
#cd ../..

# cd system/core
# curl https://github.com/tavukkdoner/android_system_core/commit/fd885f14692478d52ffd8de2d02131fd0b5357fe.patch | git am
# cd ../..

# cd frameworks/av
# git fetch https://github.com/LineageOS/android_frameworks_av refs/changes/14/468714/1 && git cherry-pick FETCH_HEAD
# cd ../..

cd vendor/lineage
curl https://github.com/tavukkdoner/android_vendor_crdroid/commit/56cfbd73169367e57d5a8aed169b0ac89eb41958.patch | git am
cd ../..

cd frameworks/base
curl https://github.com/tavukkdoner/android_frameworks_base/commit/dbde4ab5025fbce90e76b4f296f8b6720583054a.patch | git am
cd ../..

cd kernel/xiaomi/mithorium-4.19/kernel
curl https://github.com/tavukkdoner/kernel_msm-4.19/commit/a0c4253fb91bbfd7e915bbd045dff1eb8c8d8fea.patch | git am
curl https://github.com/tavukkdoner/kernel_msm-4.19/commit/250349dec3c89291f0974c9332093963264ad04f.patch | git am
cd ../../../..

cd device/lineage/sepolicy
curl https://github.com/tavukkdoner/android_device_crdroid_sepolicy/commit/b4eec83467aa3bfd7473ebcac9a6424bf10075c7.patch | git am
cd ../../..

# Set up build environment
export BUILD_USERNAME=tavukkdoner 
export BUILD_HOSTNAME=crave
export TARGET_ENABLE_BLUR=true
export TARGET_USES_VULKAN=false
export UCLAMP_FEATURE_ENABLED=false
export TARGET_USES_MAGICPORTRAIT=true

source build/envsetup.sh

if [ ! -e "vendor/lineage-priv" ]; then
    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
    chmod +x create-signed-env.sh
    ./create-signed-env.sh
fi

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/433445
lunch lineage_Mi439_4_19-bp4a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-bp2a-eng && make installclean && mka bacon
