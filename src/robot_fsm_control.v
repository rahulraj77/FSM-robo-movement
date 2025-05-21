module robot_fsm_ctrl (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        move_fwd,
    input  wire        move_bwd,
    input  wire        turn_left,
    input  wire        turn_right,
    input  wire        obstacle,
    input  wire        error,
    input  wire        recover,
    output reg  [2:0]  state
);
`include "robot_fsm_defines.vh"

reg [2:0] next_state;

always @(*) begin
    case (state)
        ERROR: begin
            if (recover)
                next_state = RECOVER;
            else
                next_state = ERROR;
        end
        RECOVER: begin
            if (!error && !obstacle)
                next_state = IDLE;
            else if (error)
                next_state = ERROR;
            else if (obstacle)
                next_state = STOP;
            else
                next_state = RECOVER;
        end
        STOP: begin
            if (error)
                next_state = ERROR;
            else if (recover)
                next_state = RECOVER;
            else if (!obstacle) begin
                if (move_fwd)
                    next_state = FORWARD;
                else if (move_bwd)
                    next_state = BACKWARD;
                else if (turn_left)
                    next_state = LEFT;
                else if (turn_right)
                    next_state = RIGHT;
                else
                    next_state = state;
            end else
                next_state = STOP;
        end
        IDLE: begin
            if (error)
                next_state = ERROR;
            else if (obstacle)
                next_state = STOP;
            else if (move_fwd)
                next_state = FORWARD;
            else if (move_bwd)
                next_state = BACKWARD;
            else if (turn_left)
                next_state = LEFT;
            else if (turn_right)
                next_state = RIGHT;
            else
                next_state = IDLE;
        end
        FORWARD, BACKWARD, LEFT, RIGHT: begin
            if (error)
                next_state = ERROR;
            else if (obstacle)
                next_state = STOP;
            else if (move_fwd)
                next_state = FORWARD;
            else if (move_bwd)
                next_state = BACKWARD;
            else if (turn_left)
                next_state = LEFT;
            else if (turn_right)
                next_state = RIGHT;
            else
                next_state = state;
        end
        default: next_state = IDLE;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        state <= IDLE;
    else
        state <= next_state;
end

endmodule