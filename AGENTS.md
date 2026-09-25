# sllidar_ros2: agent notes

Vendored fork of [Slamtec/sllidar_ros2](https://github.com/Slamtec/sllidar_ros2),
the RPLIDAR driver. Upstream's `README.md` documents the node, its parameters,
and the supported models. Almost everything here is upstream code, so keep the
Thornbots diff small: it has to survive the next merge from Slamtec.

## How the Sentry actually uses it

Not through this package's own launch files. `thornbots_pkg`'s `auto.launch.py`
runs `sllidar_node` directly under `real_hardware:=true`, with `frame_id=lidar`
and `scan` remapped to `scan_raw` — `thornbots_pkg`'s `lidar_self_filter` node
owns the final `/scan`. Port and baud come from the `lidar_serial_port`
(`/dev/ttyUSB0`) and `lidar_baudrate` (115200) launch args.

The `launch/sllidar_*_launch.py` files are upstream's, kept only for bringing a
bare lidar up by hand. Changing one does not affect the robot.

**This package is shadowed by `/workspaces/ros2_ws`** (`Dockerfile.thornbots`
LAYER 5 copies this directory in at build time). Once it's built locally, an
edit under `src/sllidar_ros2` is live under `dexec.sh` but _not_ in the user's
terminal, which resolves to the image-baked snapshot. Before trusting any
result: `../isaac_ros_common/scripts/dexec.sh -- ros2 pkg prefix sllidar_ros2`
(`/workspaces/isaac_ros-dev/…` = your edit is live).

## Thornbots changes to upstream

- `launch/sllidar_a2m8_launch.py`: `scan_mode` default `Sensitivity` → `Boost`.
- `scripts/rplidar.rules`: rewritten to match on the USB subsystem and set mode
  0666 / group `plugdev`, so a non-root user can open the lidar. Host-side only.
  The container's copy, with the hotplug hook, is authoritative and lives in
  `../isaac_ros_common/docker/udev_rules/98-rplidar.rules`.
- `scripts/create_udev_rules.sh`: `colcon_cd rplidar_ros2` → `sllidar_ros2`.

## Scope

Driver and SDK only. Frame conventions, scan filtering, and anything consuming
`/scan` belong to `../thornbots_pkg`; odometry from scans belongs to
`../rf2o_laser_odometry`.

## Open

- **Jazzy needs `CMAKE_CXX_STANDARD 17`** (it is 14). Kernel 6.8 on
  JetPack 7.2 may enumerate the USB serial port differently.
  `../JAZZY_PLAN.md`.

## Committing

This package is a submodule of `thornbots_workspace`, on branch `main`. Commit
and push here first, then bump this gitlink in `../` — one logical change, one
bump, never a gitlink pointing at an unpushed commit. Full rule in
`../CLAUDE.md` § Packages.
