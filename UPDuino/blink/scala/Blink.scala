/*
 * Blink FPGA up5k ultraplus upduino
 */

import chisel3._
import chisel3.Driver


class blink_core extends Module {
  val io = IO(new Bundle {
    val led1 = Output(UInt(1.W))
    val led2 = Output(UInt(1.W))
    val led3 = Output(UInt(1.W))
  })
  val CNT_MAX = (50000000 / 2 - 1).U;
  
  val cntReg = RegInit(0.U(32.W))
  val blkReg = RegInit(0.U(1.W))

  cntReg := cntReg + 1.U
  when(cntReg === CNT_MAX) {
    cntReg := 0.U
    blkReg := ~blkReg
  }
  io.led1 := blkReg
  io.led2 := blkReg
  io.led3 := blkReg
}

object blink extends App {
  chisel3.Driver.execute(Array[String](), () => new blink_core())
}
