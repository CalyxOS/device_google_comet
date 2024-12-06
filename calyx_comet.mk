#
# SPDX-FileCopyrightText: 2021-2024 The LineageOS Project
# SPDX-FileCopyrightText: 2021-2024 The Calyx Institute
# SPDX-License-Identifier: Apache-2.0
#

# Inherit some common stuff
TARGET_DISABLE_EPPE := true
$(call inherit-product, vendor/calyx/config/common_foldable_book_telephony.mk)

# Inherit device configuration
DEVICE_CODENAME := comet
DEVICE_PATH := device/google/comet
VENDOR_PATH := vendor/google/comet
$(call inherit-product, device/google/zumapro/calyx_common.mk)
$(call inherit-product, $(DEVICE_PATH)/$(DEVICE_CODENAME)/device-calyx.mk)
$(call inherit-product, $(DEVICE_PATH)/aosp_$(DEVICE_CODENAME).mk)

# Device identifier. This must come after all inclusions
PRODUCT_BRAND := google
PRODUCT_MODEL := Pixel 9 Pro Fold
PRODUCT_NAME := calyx_$(DEVICE_CODENAME)

PRODUCT_BUILD_PROP_OVERRIDES := \
    BuildDesc="comet-user 15 AP4A.241205.013 12621605 release-keys" \
    BuildFingerprint=google/comet/comet:15/AP4A.241205.013/12621605:user/release-keys \
    DeviceProduct=$(DEVICE_CODENAME)

PRODUCT_RESTRICT_VENDOR_FILES := false

$(call inherit-product, $(VENDOR_PATH)/$(DEVICE_CODENAME)-vendor.mk)
