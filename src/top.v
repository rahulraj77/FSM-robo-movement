module robot_fsm (
    input  wire clk,
    input  wire rst_n,
    input  wire move_fwd,
    input  wire move_bwd,
    input  wire turn_left,
    input  wire turn_right,
    input  wire obstacle,
    input  wire error,
    input  wire recover,
    output wire [2:0] state,
    output wire motor_fwd,
    output wire motor_bwd,
    output wire motor_left,
    output wire motor_right,
    output wire motor_stop
);

    // Internal state wire
    wire [2:0] fsm_state;

    robot_fsm_ctrl u_ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .move_fwd(move_fwd),
        .move_bwd(move_bwd),
        .turn_left(turn_left),
        .turn_right(turn_right),
        .obstacle(obstacle),
        .error(error),
        .recover(recover),
        .state(fsm_state)
    );

    robot_fsm_outputs u_outputs (
        .state(fsm_state),
        .motor_fwd(motor_fwd),
        .motor_bwd(motor_bwd),
        .motor_left(motor_left),
        .motor_right(motor_right),
        .motor_stop(motor_stop)
    );

    assign state = fsm_state;

endmodule