#!/usr/bin/env python3
import gi
gi.require_version("FPrint", "2.0")
from gi.repository import FPrint

ctx = FPrint.Context()

for dev in ctx.get_devices():
    print(f"{dev} {dev.props.device_id}: Drive = ({dev.get_driver()})")
    dev.open_sync()
    dev.clear_storage_sync()
    print(f"[ok] All prints deleted for {dev.props.device_id}")
    dev.close_sync()
