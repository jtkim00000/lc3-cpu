# LC-3 CPU
This is a personal project where I built an RTL implementation of the LC-3 from scratch in Verilog solo.

## Table of Contents
- [Overview](#architecture)
- [Architecture](#architecture)
  - [Instruction Set](#instructionset)
  - [CPU](#cpu)
  - [Memory](#memory)
- [Microarchitecture](#microarchitecture)
  - [ALU](#alu)
  - [Register File](#registerfile)
  - [BEN](#ben)
  - [SRAM](#sram)
  - [Control](#control)
  - [Other](#other)
    - [Multiplexers](#muxes)
    - [Registers](#registers)
    - [SEXT/ZEXT](#ext)
- [Simulation](#simulation)
  - [Test Program](#testprogram)

## Overview
Little Computer 3, or LC-3, is primarily an instruction set architecture (ISA) designed as an educational tool for computer architecture and assembly language programming, developed by Dr. Yale Patt and Dr. Sanjay Patel.

This project is an RTL implementation of the LC-3 CPU, built from scratch in Verilog, including a full 16-bit datapath, microprogrammed control unit, and 64K x 16 SRAM with a ready signal. 

14 instructions of the LC-3 ISA were implemented and verified through a combination of module-level testbenches and a full integration test using a machine code program.

## Architecture

### Instruction Set

Each instruction in the LC-3 ISA is 16 bits wide. Bits [15:12] specify the opcode of the instruction (specifies which operation should be done). Bits [11:0] specify further information that is needed to perform the operation.

The following instructions were implemented in this project.

### CPU

### Memory

LC-3 consists of an static random access memory (SRAM) with a 16-bit address space, corresponding to 2^16 locations, each containing 16 bit addressability. 

## Microarchitecture

### ALU

### Register File

### BEN

### SRAM

### Control

### Other

#### Multiplexers

#### Registers

#### SEXT/ZEXT

## Simulation

### Test Program

