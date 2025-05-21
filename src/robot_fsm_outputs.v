module robot_fsm_outputs (
    input  wire [2:0] state,
    output reg        motor_fwd,
    output reg        motor_bwd,
    output reg        motor_left,
    output reg        motor_right,
    output reg        motor_stop
);
`include "robot_fsm_defines.vh"

always @(*) begin
    motor_fwd   = 0;
    motor_bwd   = 0;
    motor_left  = 0;
    motor_right = 0;
    motor_stop  = 0;
    case (state)
        FORWARD:   motor_fwd   = 1;
        BACKWARD:  motor_bwd   = 1;
        LEFT:      motor_left  = 1;
        RIGHT:     motor_right = 1;
        STOP:      motor_stop  = 1;
        ERROR:     motor_stop  = 1;
        default:   motor_stop  = 1; // IDLE, RECOVER: stop motors
    endcase
end

endmodule