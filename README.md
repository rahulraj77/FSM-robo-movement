# Project Title
Finite State Machine(FSM) for Robot Movement

# Theme
The chosen theme is **Robotics Control Systems**

## Brief Introduction

A Finite State Model **(FSM)** is a type of model used in robotics to regulate action via a list of pre-defined **states** and **transitions**. A state is a distinct action (an example: Idle, Moving Forward, Turning), and transitions depend on factors such as **sensor input** or **user input**. This method enables robots to make decisions with ease and respond in real-time, such as from "Moving Forward" to "Turning" when an obstacle is encountered — making FSM an ideal solution for efficient and predictable robot regulation.

## Expected Output

### Movement Control
FSM allows directional control: forward, back, left and right and state transitions should be triggered by inputs.

### Obstacle Handling
Sensors detect obstacles and trigger transitions to **STOP** state, to halt movement, or **TURN** state, to avoid collision.

### Error Recovery
FSM includes special reset or recovery states which helps to manage unexpected inputs, system faults or external noise.

# Block Diagram

![System-Block-Diagram](docs/Block-Diagram.png)