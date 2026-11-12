# SLAMTEC LIDAR ROS2 Package

ROS2 node for SLAMTEC LIDAR

Visit following Website for more details about SLAMTEC LIDAR:

SLAMTEC LIDAR roswiki: <http://wiki.ros.org/rplidar>

SLAMTEC LIDAR HomePage: <http://www.slamtec.com/en/Lidar>

SLAMTEC LIDAR SDK: <https://github.com/Slamtec/rplidar_sdk>

SLAMTEC LIDAR Tutorial: <https://github.com/robopeak/rplidar_ros/wiki>

## Thornbots usage

This fork is built as part of the workspace inside the Isaac ROS Jazzy container; follow the
[workspace README](../README.md) instead of the standalone steps below. The robot launches
`sllidar_node` from [`thornbots_pkg/launch/auto.launch.py`](../thornbots_pkg/launch/auto.launch.py),
not from this package's launch files. The container's `/dev/rplidar` hotplug rule is
[`98-rplidar.rules`](../isaac_ros_common/docker/udev_rules/98-rplidar.rules);
`scripts/rplidar.rules` is only for a bare host.

## Supported SLAMTEC LIDAR

| Lidar Model |
| ---------------------- |
|RPLIDAR A1              |
|RPLIDAR A2              |
|RPLIDAR A3              |
|RPLIDAR C1              |
|RPLIDAR S1              |
|RPLIDAR S2              |
|RPLIDAR S3              |
|RPLIDAR S2E             |
|RPLIDAR T1              |

## How to install ROS2

[jazzy](https://docs.ros.org/en/jazzy/Installation.html),
[rolling](https://docs.ros.org/en/rolling/Installation.html)

## How to configure your ROS 2 environment

[Configuring your ROS 2 environment](https://docs.ros.org/en/jazzy/Tutorials/Beginner-CLI-Tools/Configuring-ROS2-Environment.html)

## How to Create a ROS2 workspace

[ROS2 Tutorials Creating a workspace](https://docs.ros.org/en/jazzy/Tutorials/Beginner-Client-Libraries/Creating-A-Workspace/Creating-A-Workspace.html)

1. example, choose the directory name ros2_ws, for "development workspace" :

   ```bash
   mkdir -p ~/ros2_ws/src
   cd ~/ros2_ws/src
   ```

## Compile & Install sllidar_ros2 package

1. Clone sllidar_ros2 package from github

   Ensure you're still in the ros2_ws/src directory before you clone:

   ```bash
   git clone https://github.com/Slamtec/sllidar_ros2.git
   ```

2. Build sllidar_ros2 package

   From the root of your workspace (ros2_ws), you can now build sllidar_ros2 package using the command:

   ```bash
   cd ~/ros2_ws/
   source /opt/ros/jazzy/setup.bash
   colcon build --symlink-install
   ```

   If `colcon` is not found, [install colcon](https://docs.ros.org/en/jazzy/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html#install-colcon).

3. Package environment setup

   ```bash
   source ~/ros2_ws/install/setup.bash
   ```

   To source the workspace in every new bash shell:

   ```bash
   echo 'source "$HOME/ros2_ws/install/setup.bash"' >> ~/.bashrc
   source ~/.bashrc
   ```

4. Create udev rules for rplidar

   sllidar_ros2 needs read/write access to the serial device. Install the udev rule, which
   also creates the `/dev/rplidar` symlink, then replug the lidar:

   ```bash
   bash ~/ros2_ws/src/sllidar_ros2/scripts/create_udev_rules.sh
   ```

   For a one-off test without the rule, `sudo chmod 666 /dev/ttyUSB0` grants access until the
   device is replugged.

## Run sllidar_ros2

### Run sllidar node and view in the rviz

The command for RPLIDAR A1 is :

```bash
ros2 launch sllidar_ros2 view_sllidar_a1_launch.py
```

The command for RPLIDAR A2M7 is :

```bash
ros2 launch sllidar_ros2 view_sllidar_a2m7_launch.py
```

The command for RPLIDAR A2M8 is :

```bash
ros2 launch sllidar_ros2 view_sllidar_a2m8_launch.py
```

The command for RPLIDAR A2M12 is :

```bash
ros2 launch sllidar_ros2 view_sllidar_a2m12_launch.py
```

The command for RPLIDAR A3 is :

```bash
ros2 launch sllidar_ros2 view_sllidar_a3_launch.py
```

The command for RPLIDAR C1 is :

```bash
ros2 launch sllidar_ros2 view_sllidar_c1_launch.py
```

The command for RPLIDAR S1 is :

```bash
ros2 launch sllidar_ros2 view_sllidar_s1_launch.py
```

The command for RPLIDAR S2 is :

```bash
ros2 launch sllidar_ros2 view_sllidar_s2_launch.py
```

The command for RPLIDAR S2E is :

```bash
ros2 launch sllidar_ros2 view_sllidar_s2e_launch.py
```

The command for RPLIDAR S3 is :

```bash
ros2 launch sllidar_ros2 view_sllidar_s3_launch.py
```

The command for RPLIDAR T1 is :

```bash
ros2 launch sllidar_ros2 view_sllidar_t1_launch.py
```

The command for RPLIDAR S1(TCP connection) is :

```bash
ros2 launch sllidar_ros2 view_sllidar_s1_tcp_launch.py
```

Notice: different lidar use different serial_baudrate.

## RPLIDAR frame

RPLIDAR frame must be broadcast as shown below.

![RPLIDAR A1 frame](rplidar_A1.png)
![RPLIDAR A2 frame](rplidar_A2.png)
