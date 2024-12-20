//#############################################################################
//# Function: 2-Input Clock Or Gate                                           #
//# Copyright: OH Project Authors. ALl rights Reserved.                       #
//# License:  MIT (see LICENSE file in OH repository)                         #
//#############################################################################

module asic_clkor2 #(parameter PROP = "DEFAULT")   (
    input  a,
    input  b,
    output z,
    output z2
    );

   assign z = a | b;
   assign z2 = a | b;

endmodule
