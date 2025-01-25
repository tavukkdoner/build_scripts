#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 

# Init Rom Manifest
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs

# Clone local_manifests repository
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests 
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-avc1-viperfx .repo/local_manifests
git clone https://github.com/tavukkdoner/local_manifests1.git --depth 1 -b a15-crdroid-mithorium .repo/local_manifests 

# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests && 
# if [ ! $? == 0 ]
# then   curl -o .repo/local_manifests https://github.com/tavukkdoner/local_manifests.git
#  echo "Git clone failed, downloading through curl instead..."
# fi 

# Sync the repositories  
# /opt/crave/resync.sh 
/opt/crave/resynctest.sh

# Ty Crave 
cd packages/apps/Settings
git remote add tmpRepo https://github.com/tavukkdoner/android_packages_apps_Settings
git fetch tmpRepo 15.0
git cherry-pick 3a97225
git cherry-pick 46f3cd9
git cherry-pick e6444ae
# https://github.com/tavukkdoner/android_packages_apps_Settings/commit/1ebf2c407e48741d2a6b06e45837580230c3256f
git revert 1ebf2c4
git remote remove tmpRepo
cd ../../../

# cd lineage-sdk
# git remote add tmpRepo1 https://github.com/tavukkdoner/android_lineage-sdk
# git fetch tmpRepo1 15.0
# git cherry-pick a3743d1
# git remote remove tmpRepo1
# cd ../

cd vendor/lineage
git remote add tmpRepo2 https://github.com/tavukkdoner/android_vendor_crdroid
git fetch tmpRepo2 15.0
git cherry-pick 7af373d
git remote remove tmpRepo2
#git remote add tmpRepo4 https://github.com/LineageOS/android_vendor_lineage
#git fetch tmpRepo4 lineage-22.0
#git cherry-pick d6777fa
#git remote remove tmpRepo4
cd ../../

cd packages/modules/Connectivity
# git remote add tmpRepo7 https://github.com/LineageOS/android_packages_modules_Connectivity
# git fetch tmpRepo7 lineage-22.1
# git revert 7f2b3da
git remote add tmpRepo7 https://github.com/tavukkdoner/android_packages_modules_Connectivity
git fetch tmpRepo7 lineage-22.1
git cherry-pick bdd1db1
cd ../../../

#cd system/netd
#git remote add tmpRepo5 https://github.com/tavukkdoner/android_system_netd
#git fetch tmpRepo5 lineage-22.0
#git cherry-pick d904525
#git remote remove tmpRepo5
#cd ../../

#cd build/soong
#git remote add tmpRepo3 https://github.com/LineageOS/android_build_soong
#git fetch tmpRepo3 lineage-22.0
#git cherry-pick 9d6c7dc
#git remote remove tmpRepo3
#cd ../../

# cd packages/apps/DocumentsUI
# git remote add tmpRepo6 https://github.com/tavukkdoner/android_packages_apps_DocumentsUI
# git fetch tmpRepo6 15.0
# git cherry-pick db1dd11
# git remote remove tmpRepo6
# cd ../../../

# cd frameworks/av/media/libstagefright/data/
# curl -O https://raw.githubusercontent.com/tavukkdoner/patches/refs/heads/main/media_codecs_sw.xml
# cd ../../../../../

# Set up build environment
export BUILD_USERNAME=tavukkdoner 
export BUILD_HOSTNAME=crave

source build/envsetup.sh

if [ ! -e "vendor/lineage-priv" ]; then
    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
    chmod +x create-signed-env.sh
    ./create-signed-env.sh
fi
 
# Build the ROM
# lunch lineage_Mi439-ap2a-userdebug && make installclean && mka bacon

# Build the ROM
# lunch lineage_Mi439_4_19-ap2a-userdebug && make installclean && mka bacon

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/402103
# lunch lineage_Mi439_4_19-ap3a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-ap3a-eng && make installclean && mka bacon

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/411251
lunch lineage_Mi439_4_19-ap4a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-ap4a-eng && make installclean && mka bacon

