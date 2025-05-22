module robot_fsm_tb;

    reg clk;
    reg rst_n;
    reg move_fwd;
    reg move_bwd;
    reg turn_left;
    reg turn_right;
    reg obstacle;
    reg error;
    reg recover;

    wire [2:0] state;
    wire motor_fwd;
    wire motor_bwd;
    wire motor_left;
    wire motor_right;
    wire motor_stop;

    robot_fsm uut (
        .clk(clk),
        .rst_n(rst_n),
        .move_fwd(move_fwd),
        .move_bwd(move_bwd),
        .turn_left(turn_left),
        .turn_right(turn_right),
        .obstacle(obstacle),
        .error(error),
        .recover(recover),
        .state(state),
        .motor_fwd(motor_fwd),
        .motor_bwd(motor_bwd),
        .motor_left(motor_left),
        .motor_right(motor_right),
        .motor_stop(motor_stop)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        move_fwd = 0;
        move_bwd = 0;
        turn_left = 0;
        turn_right = 0;
        obstacle = 0;
        error = 0;
        recover = 0;

        // Release reset
        #12;
        rst_n = 1;

        // Move Forward
        #10; move_fwd = 1;
        #10; move_fwd = 0;

        // Retain Forward (no input change)
        #20;

        // Turn Left (while moving forward)
        #10; turn_left = 1;
        #10; turn_left = 0;

        // Retain Left (no input change)
        #20;

        // Turn Right (should switch to right)
        #10; turn_right = 1;
        #10; turn_right = 0;

        // Retain Right (no input change)
        #20;

        // Move Backward
        #10; move_bwd = 1;
        #10; move_bwd = 0;

        // Retain Backward (no input change)
        #20;

        // Obstacle Detected (should STOP)
        #10; obstacle = 1;
        #10; obstacle = 0;

        // Should remain stopped until new command
        #10; move_fwd = 1;
        #10; move_fwd = 0;

        // Error occurs
        #10; error = 1;
        #10; error = 0;

        // Try to recover
        #10; recover = 1;
        #10; recover = 0;

        // End simulation
        #30;
        $finish;
    end

    initial begin
        $display("Time\tState\tFwd\tBwd\tLeft\tRight\tStop\tObstacle\tError\tRecover");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b",
            $time, state, motor_fwd, motor_bwd, motor_left, motor_right, motor_stop,
            obstacle, error, recover);
    end

endmodule