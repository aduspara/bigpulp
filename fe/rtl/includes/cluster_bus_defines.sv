// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

/*
 * cluster_bus_defines.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 * Pasquale Davide Schiavone <pschiavo@iss.ee.ethz.ch>
 * Andreas Kurth <akurth@iis.ee.ethz.ch>
 */

// CLUSTER BUS PARAMETRES

`define NB_SLAVE  4
`define NB_MASTER 3

`define NB_REGION 2

// MASTER PORT TO TCDM
`define MASTER_0_START_ADDR 32'h1000_0000
`define MASTER_0_END_ADDR   32'h101F_FFFF

// MASTER PORT TO PERIPHERAL INTERCONNECT
`define MASTER_1_START_ADDR 32'h1020_0000
`define MASTER_1_END_ADDR   32'h103F_FFFF

// MASTER PORT TO SOC
// This port is divided into two regions.  All addresses that are not in the
// cluster (i.e., that would go to one of the above master ports) go to the SoC.
// Region 0 ends before Master 0, and Region 1 begins after Master 1.
//
// As the effective end address of Region 0 and start address of Region 1 depend
// on the cluster ID, these addresses are set in the `cluster_bus_wrap` module.
`define MASTER_2_REGION_0_START_ADDR 32'h0000_0000
`define MASTER_2_REGION_1_END_ADDR   32'hFFFF_FFFF

`define TCDM_ASSIGN_MASTER(lhs, rhs)      \
    assign lhs.req       = rhs.req;       \
    assign lhs.add       = rhs.add;       \
    assign lhs.wen       = rhs.wen;       \
    assign lhs.wdata     = rhs.wdata;     \
    assign lhs.be        = rhs.be;        \
                                          \
    assign rhs.gnt       = lhs.gnt;       \
    assign rhs.r_valid   = lhs.r_valid;   \
    assign rhs.r_opc     = lhs.r_opc;     \
    assign rhs.r_rdata   = lhs.r_rdata;

`define TCDM_ASSIGN_SLAVE(lhs, rhs)  `TCDM_ASSIGN_MASTER(rhs, lhs)
