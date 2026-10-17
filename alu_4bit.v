module alu_4bit (
    input wire [3:0] a,
    input wire [3:0] b,
    input wire [2:0] alu_sel,
    output reg [3:0] alu_out,
    output wire zero,
    output wire negative,
    output wire overflow
);

    reg overflow_reg;

    always @(*) begin
        alu_out = 4'b0000;
        overflow_reg = 1'b0;
        case (alu_sel)
            3'b000: begin
                alu_out = a + b;
                overflow_reg = (~(a[3] ^ b[3])) & (a[3] ^ alu_out[3]);
            end
            3'b001: begin
                alu_out = a - b;
                overflow_reg = (a[3] ^ b[3]) & (a[3] ^ alu_out[3]);
            end
            3'b010: alu_out = a & b;
            3'b011: alu_out = a | b;
            3'b100: alu_out = a ^ b;
            3'b101: alu_out = a << 1;
            3'b110: alu_out = a >> 1;
            3'b111: alu_out = (a < b) ? 4'b0001 : 4'b0000;
            default: alu_out = 4'b0000;
        endcase
    end

    assign zero = (alu_out == 4'b0000);
    assign negative = alu_out[3];
    assign overflow = overflow_reg;
endmodule
