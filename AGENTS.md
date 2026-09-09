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
- `scripts/rplidar.rules` and `scripts/hotplug-rplidar.sh`: added, adapted from
  Isaac ROS's RealSense hotplug pair. They give the lidar a stable `/dev/rplidar`
  symlink and mode 0666 so the container can open it without root.

## Scope

Driver and SDK only. Frame conventions, scan filtering, and anything consuming
`/scan` belong to `../thornbots_pkg`; odometry from scans belongs to
`../rf2o_laser_odometry`.

## Open

- **`scripts/create_udev_rules.sh` runs `colcon_cd rplidar_ros2`**, which is the
  old upstream package name and does not exist here. The script fails at that
  line, so it has never installed anything; the rules must be copied by hand.
  Should be `colcon_cd sllidar_ros2`.
- **The udev rule and hotplug script exist twice and have diverged.**
  `../isaac_ros_common/docker/udev_rules/98-rplidar.rules` still passes
  `-M '%M' -m '%m'`; this copy dropped them. Neither copy is installed by any
  Dockerfile. Pick one as authoritative before relying on hotplug.
- **`hotplug-rplidar.sh`'s `add` branch is dead as currently invoked.** Without
  `-M`/`-m` it would `mknod` with empty major/minor, but it only reaches that
  call when the device node is missing, which udev has already created. Confirm
  whether the script is needed at all or whether the `SYMLINK`/`MODE` rule is
  doing the whole job.
