#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 
#rm -rf prebuilts/clang/host/linux-x86
#rm -rf packages/apps/Etar
# rm -rf frameworks/base
# rm -rf kernel/xiaomi/mithorium-4.19/kernel
# rm -rf hardware/mithorium/
rm -rf vendor/gms
# rm -rf hardware/qcom-caf/msm8937
# rm -rf prebuilts/clang/host/

# Init Rom Manifest
#repo init -u https://github.com/Evolution-X/manifest -b bka --git-lfs
#repo init -u https://github.com/Evolution-X/manifest -b bq1 --git-lfs
repo init -u https://github.com/Evolution-X/manifest -b bq2 --git-lfs

# Clone local_manifests repository
#git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a16-final-evo .repo/local_manifests
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a16-final-evo2 .repo/local_manifests

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

# https://android.googlesource.com/platform/hardware/interfaces/+/refs/tags/android-15.0.0_r23
# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/421399
# lunch lineage_Mi439_4_19-bp1a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-bp1a-eng && make installclean && mka bacon

#cd build/make
#curl https://github.com/tavukkdoner/android_build/commit/02b273229d018d2bfaff989e2289420736d83bfc.patch | git am
#cd ../..

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
export UCLAMP_FEATURE_ENABLED=false
export TARGET_USES_VULKAN=false
#export TARGET_USES_EROFS=true
export TARGET_USES_PICO_GAPPS=false
# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/433445
#lunch lineage_Mi439_4_19-bp3a-userdebug && make installclean && m evolution
lunch lineage_Mi439_4_19-bp4a-userdebug && make installclean && m evolution
#lunch lineage_Mi439_4_19-bp2a-eng && make installclean && m evolution
