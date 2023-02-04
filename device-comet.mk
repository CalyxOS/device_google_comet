#
# Copyright (C) 2021 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

TARGET_KERNEL_DIR ?= device/google/comet-kernel
TARGET_BOARD_KERNEL_HEADERS := device/google/comet-kernel/kernel-headers

$(call inherit-product-if-exists, vendor/google_devices/comet/prebuilts/device-vendor-comet.mk)
$(call inherit-product-if-exists, vendor/google_devices/zuma/prebuilts/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/zuma/proprietary/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/comet/proprietary/comet/device-vendor-comet.mk)

include device/google/zuma/device-shipping-common.mk
include device/google/comet/audio/comet/audio-tables.mk
include device/google/gs-common/bcmbt/bluetooth.mk
include device/google/gs-common/touch/gti/gti.mk

# go/lyric-soong-variables
$(call soong_config_set,lyric,camera_hardware,shiba)
$(call soong_config_set,lyric,tuning_product,ripcurrent)
$(call soong_config_set,google3a_config,target_device,shiba)

# Init files
PRODUCT_COPY_FILES += \
	device/google/comet/conf/init.comet.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.comet.rc

# Recovery files
PRODUCT_COPY_FILES += \
        device/google/comet/conf/init.recovery.device.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.comet.rc

# insmod files
PRODUCT_COPY_FILES += \
	device/google/comet/init.insmod.comet.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/init.insmod.comet.cfg

# Camera
PRODUCT_COPY_FILES += \
	device/google/comet/media_profiles_comet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

# NFC
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
	frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
	frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml \
	frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
	device/google/comet/nfc/libnfc-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st.conf \
	device/google/comet/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf

PRODUCT_PACKAGES += \
	NfcNci \
	Tag \
	android.hardware.nfc-service.st

# SecureElement
PRODUCT_PACKAGES += \
	android.hardware.secure_element@1.2-service-gto

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
	frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
	device/google/comet/nfc/libse-gto-hal.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libse-gto-hal.conf

DEVICE_MANIFEST_FILE += \
	device/google/comet/nfc/manifest_se.xml

# Thermal Config
PRODUCT_COPY_FILES += \
	device/google/comet/thermal_info_config_comet.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config.json

# Power HAL config
PRODUCT_COPY_FILES += \
	device/google/comet/powerhint-comet.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Bluetooth HAL
PRODUCT_COPY_FILES += \
	device/google/comet/bluetooth/bt_vendor_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth/bt_vendor_overlay.conf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bluetooth.a2dp_offload.supported=true \
    persist.bluetooth.a2dp_offload.disabled=false \
    persist.bluetooth.a2dp_offload.cap=sbc-aac-aptx-aptxhd-ldac

# Bluetooth hci_inject test tool
PRODUCT_PACKAGES_DEBUG += \
    hci_inject

# Bluetooth SAR test tool
PRODUCT_PACKAGES_DEBUG += \
    sar_test

# Bluetooth EWP test tool
PRODUCT_PACKAGES_DEBUG += \
    ewp_tool

# Bluetooth AAC VBR
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.a2dp_aac.vbr_supported=true

# TODO b/261526478 remove after BT/WiFi codex device exists
# Bluetooth does not open BT/WiFi codex device before WiFi bringup
BLUETOOTH_SKIP_COEX_DEVICE := true
# Inject soong bluetooth configurations
$(call soong_config_set,bluetooth,bluetooth_skip_coex_device,$(BLUETOOTH_SKIP_COEX_DEVICE))

# Spatial Audio
PRODUCT_PACKAGES += \
	libspatialaudio \
	librondo

# Keymaster HAL
#LOCAL_KEYMASTER_PRODUCT_PACKAGE ?= android.hardware.keymaster@4.1-service

# Gatekeeper HAL
#LOCAL_GATEKEEPER_PRODUCT_PACKAGE ?= android.hardware.gatekeeper@1.0-service.software


# Gatekeeper
# PRODUCT_PACKAGES += \
# 	android.hardware.gatekeeper@1.0-service.software

# Keymint replaces Keymaster
# PRODUCT_PACKAGES += \
# 	android.hardware.security.keymint-service

# Keymaster
#PRODUCT_PACKAGES += \
#	android.hardware.keymaster@4.0-impl \
#	android.hardware.keymaster@4.0-service

#PRODUCT_PACKAGES += android.hardware.keymaster@4.0-service.remote
#PRODUCT_PACKAGES += android.hardware.keymaster@4.1-service.remote
#LOCAL_KEYMASTER_PRODUCT_PACKAGE := android.hardware.keymaster@4.1-service
#LOCAL_KEYMASTER_PRODUCT_PACKAGE ?= android.hardware.keymaster@4.1-service

# PRODUCT_PROPERTY_OVERRIDES += \
# 	ro.hardware.keystore_desede=true \
# 	ro.hardware.keystore=software \
# 	ro.hardware.gatekeeper=software

# PowerStats HAL
PRODUCT_SOONG_NAMESPACES += \
    device/google/comet/powerstats/comet

# WiFi Overlay
PRODUCT_PACKAGES += \
	WifiOverlay2024Mid_CT3 \
	PixelWifiOverlay2023

# Trusty liboemcrypto.so
PRODUCT_SOONG_NAMESPACES += vendor/google_devices/comet/prebuilts

# Location
PRODUCT_COPY_FILES += \
       device/google/comet/location/gps.cer:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.cer

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
        PRODUCT_COPY_FILES += \
		device/google/comet/location/lhd.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/lhd.conf \
		device/google/comet/location/scd.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/scd.conf \
		device/google/comet/location/gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.xml
else
        PRODUCT_COPY_FILES += \
		device/google/comet/location/lhd_user.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/lhd.conf \
		device/google/comet/location/scd_user.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/scd.conf \
		device/google/comet/location/gps_user.xml:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.xml
endif

# include GNSSD
include device/google/comet/location/gnssd/device-gnss.mk

# Install product specific framework compatibility matrix
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/comet/device_framework_matrix_product.xml


# Set zram size
PRODUCT_VENDOR_PROPERTIES += \
	vendor.zram.size=3g \
	persist.device_config.configuration.disable_rescue_party=true

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.udfps.als_feed_forward_supported=true \
    persist.vendor.udfps.lhbm_controlled_in_hal_supported=true

# Camera
# Disable camera DPM
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.camera.debug.force_dpm_on=0
