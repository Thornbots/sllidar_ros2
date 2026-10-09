# sllidar_ros2

Follow [workspace rules](../AGENTS.md) and [CI](../docs/CI.md).
Vendored [Slamtec driver](README.md); keep the Thornbots diff small for upstream merges.

## Scope

Driver/SDK only. The robot launches `sllidar_node` directly from
`../thornbots_pkg/launch/auto.launch.py`; editing upstream launch files does
not change the robot. Frame/filter behavior belongs to `thornbots_pkg`,
scan odometry to `rf2o_laser_odometry`.
Container hotplug rules live in `../isaac_ros_common/docker/udev_rules/98-rplidar.rules`;
`scripts/rplidar.rules` is host-only. Intentional upstream diffs: A2M8
`scan_mode` Boost, that udev rule, `create_udev_rules.sh`'s package name, and
lint-only CMake/`package.xml` edits.

## Open

Serial enumeration and scan acceptance: [hardware status](../JAZZY_FLASH.md#hardware-status).
