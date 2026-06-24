#
# SPDX-FileCopyrightText: 2021 The Android Open-Source Project
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, device/google/zumapro/aosp_common.mk)
$(call inherit-product, device/google/comet/device-comet.mk)

PRODUCT_NAME := aosp_comet
PRODUCT_DEVICE := comet
PRODUCT_MODEL := Pixel 9 Pro Fold
PRODUCT_BRAND := google
PRODUCT_MANUFACTURER := Google

PRODUCT_NAME_FOR_ATTESTATION := comet
PRODUCT_DEVICE_FOR_ATTESTATION := comet
PRODUCT_MODEL_FOR_ATTESTATION := Pixel 9 Pro Fold
PRODUCT_BRAND_FOR_ATTESTATION := google
PRODUCT_MANUFACTURER_FOR_ATTESTATION := Google
