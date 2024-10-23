# Physical Design_2024
## TABLE OF CONTENTS
1. [GCC COMPILATION OF C PROGRAM](#gcc-compilation-of-c-program)
2. [RISC V COMPILATION OF C PROGRAM](#risc-v-compilation-of-c-program)
3. [SPIKE SIMULATION](#spike-simulation)
4. [RISC-V INSTRUCTION SET](#risc-v-instruction-set)
5. [ENCODING INSTRUCTIONS](#encoding-instructions)
6. [FUNCTIONAL SIMULATION OF RISC-V](#functional-simulation-of-risc-v)
7. [CUSTOM REAL-LIFE APPLICATION IMPLEMENTATION](#custom-real-life-application-implementation)<br/>
8. [RISC-V MYTH WORKSHOP](#risc-v-myth-workshop)<br/>
9. [SINGLE STAGE PROCESSOR](#single-stage-processor)<br/>
10. [5-STAGE PIPELINE PROCESSOR](#5-stage-pipeline-processor)<br/>
11. [SIMULATION OF RISCV CORE USING IVERILOG](#simulation-of-riscv-core-using-iverilog)<br/>
12. [BABYSOC SIMULATION-PRE-SYNTHESIS](#babysoc-simulation-pre-synthesis)<br/>
13. [VSD WORKSHOP-RTL DESIGN USING VERILOG WITH SKY130 TECHNOLOGY](#vsd-workshop-rtl-design-using-verilog-with-sky130-technology)<br/>
14. [BABYSOC SIMULATION-POST SYNTHESIS](#babysoc-simulation-post-synthesis)<br/>
[REFERENCES](#references)
## GCC COMPILATION OF C PROGRAM
Shown below are a series of steps to compile a C program using GCC.
### Step 1
Open the terminal. Make sure you're in the home directory. Open any editor and type a new file "file_name.c" to type the C program. Here the gedit editor is used.<br/>
i. **CODE SNIPPET:**
```c
#include <studio.h>
int main()
{
int i, n=10,sum=0;
for(i=1;i<=n;i++)
sum+=1;
printf("Sum from 1 to %d is %d \n",n,sum);
return 0;
}
```
### Step 2
Save the program. Compile the code using GCC compiler by using the command below.
```
gcc file_name.c
```
### OUTPUT
The output can be observed by opening the .out(output file). By default, the compiler creates the file by the name "a.out" in the same directory.<br/>
It can be changed by using the following command.
```
gcc -o file_name.out file_name.c
```
The image of the C code along with outputs is shown below.<br/>
The output is shown for n being 10,100 and 1000 respectively and the result is stored in "result.out" file.
![Screenshot from 2024-08-07 10-16-01](https://github.com/user-attachments/assets/914592b1-80c8-4b5f-a14f-9b406c6fff14)

## RISC V COMPILATION OF C PROGRAM
Shown below are the series of steps to compile a C program using RISC-V.
### Step 1
i. **CODE SNIPPET:**
```c
#include <studio.h>
int main()
{
int i, n=10,sum=0;
for(i=1;i<=n;i++)
sum+=1;
printf("Sum from 1 to %d is %d \n",n,sum);
return 0;
}
```
### Step 2
The program is compiled using RISC-V Compiler.
* The contents of the C file are shown using the "concatenate and display" command. It is seen directly in the terminal window.
  ```
  cat filename.c
  ```
* An object file(.o) is created. An object file is the output of the RISC-Compiler. It is created using the following command:
  ```
  riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o filename.o filename.c
  ls -ltr filename.o
  ```
#### Explanation:
* riscv64-unknown-elf-gcc : calls the RISC-V Compiler for 64 bit architecture.
* o1: Defines the optimization level.
* mabi=lp64: indicates 64 bit long pointer type for Application Binary Interface.
* march=rv64i: Indicates the architecture and instruction set i.e 64 bit RISC-V.

The image is shown below:
![1](https://github.com/user-attachments/assets/307b26b1-9268-4934-888c-ff600f4784cb)

### Step 3
The generated executable file is run and the output is seen in the terminal window using the command:
```
riscv64-unknown-elf-objdump -d filename.o
```
Here. '-d' stands for disassembling the object file. Since it generates a lengthy output,we use the following command. This gives us the  lengthy disassembled code in a much more presenatable manner.
```
riscv64-unknown-elf-objdump -d filename.o | less
```
The picture is shown below: <br/>
![Screenshot from 2024-08-07 10-26-54](https://github.com/user-attachments/assets/d619fc6c-8b28-4317-8778-7693fdd0a8dd)

### OUTPUT
* The output can be analyzed by navigating to the "main" section of the code. The number of instructions can be calculated by either counting each and every instruction within the block or by finding the difference between the addresses of the first instruction of the section(in focus) and first instruction of the next section and dividing by 4. Here we are dividing by 4 because the memory is byte-addressable.

The picture is shown below:
![Screenshot from 2024-08-07 10-22-03](https://github.com/user-attachments/assets/31912676-5035-42e2-a2b0-ebfd720b5805)
***As seen, the output turns out to be 15 instructions***

* Now the same process can be repeated for different optimization level as shown:
  ```
  riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o filename.o filename.c
  ls -ltr filename.o
  ```
  The picture is shown below:
  ![Screenshot from 2024-08-07 10-25-57](https://github.com/user-attachments/assets/f6301acf-7826-4bf7-9f32-2ad1b111baa0)
***As seen, the output turns out to be 12 instructions***
### COMPARISON
The calculation of both optimizations are shown below:
![Screenshot from 2024-08-07 10-30-02](https://github.com/user-attachments/assets/e2d3869d-8f0b-43cd-a29c-7a59c4942828)
From the picture, we can observe:
* O1: It enables a basic level of optimization which involves short compilation time. It optimizes the code without any major agressive changes.The reduction of code size is moderate( In our example, it turns out to be 15).
* Ofast: It enables an aggressive level of optimization which sometimes may involve breaking strict standards. It gives us maximum performance but at the cost of precision and correctness issues. The code size is further reduced( In our example, it turns out to be 12).
## SPIKE SIMULATION
* In the previous section, we had compiled our code using the RISC-V compiler. Now we will be debugging it using spike. Spike is a functional simulator built on the RISC-V Instruction Set Architecture which creates an environment to test and run RISC-V programs.
The code can be debugged using spike using the following command
```
spike pk filename.o
```
Here,pk stands for Proxy kernal which provides services for the simulator.
The code is run using both GCC compiler and Spike.The picture is shown below:
![VirtualBox_ASIC1_08_08_2024_11_38_53](https://github.com/user-attachments/assets/8a2fa439-1242-4bf2-8f45-c4b956b0bec9)
***Note that the output of both runs are same.***
* The code can be analysed and debugged using the command:
```
spike -d pk filename.o
```
Here, d indicates an iteractive debugging interface which allows for execution by setting breakpoints.
* Once the debugging mode is open, we can control the execution by the following command:
```
until pc 0 <start_addr> <end_addr>
```
The picture is shown below:
![2](https://github.com/user-attachments/assets/8311e137-ed6d-4c86-9b06-f58e3481cb3d)
***The execution is run from address 0(starting address) until the PC hits 100b0(end address).***
* The contents of the register before and after each instruction can be analyzed by the set of commands as shown in the picture below:
![3](https://github.com/user-attachments/assets/efba6f37-3b77-4496-8db6-6b5bfbe0027c)
* We can also see the contents of the stack pointer in a similar way as shown in the picture below:
![Screenshot from 2024-08-08 11-50-10](https://github.com/user-attachments/assets/65206173-ba52-4704-ab2a-074a7903491b)
***As seen in the picture, the difference between the contents of SP before and after the instruction is shown to be hexadecimal value of 10.***
## RISC-V INSTRUCTION SET
RISC-V is an open standard instruction set architecture aimed at helping professionals to collaborate and enable a new era of processors. It enables people to develop new processors for specific applications. It is open source and follows the principles of reduced instruction set.
### Instructions
The machine is programmed in such a way that it understands only certain formats. Hence, it is important to understand them. RISC-V basically has 6 types of instructions which are:
1. R-Type <br/>
   <img width="496" alt="image" src="https://github.com/user-attachments/assets/0c883c1e-9107-4df5-9f79-5dc57c15fef6"> <br/>
   These are the Register type operations. They are mainly used for arithmetic and logical operations. There is no immediate integer data involved.  Bits 0 to 6 are opcode 
   (operation code), used to identify the type of instruction. Bits 7 to 11 are the index of the rd register(destination register) which stores the result. rs1 and rs2 are 
   called source registers for inputs. Function 3 and Function 7 fields further help to specify the operation.
2. I-Type <br/>
   <img width="484" alt="image" src="https://github.com/user-attachments/assets/2391a512-3511-44f9-863e-b800aaff8706"> <br/>
   The I-type(Immediate Instruction type) involves an immediate data as one of the inputs. As an result, there is no rs2 field. Instead the upper 12 bits are assigned for 
   the immediate data. Function7 field is also eliminated.
3. S-Type <br/>
   <img width="484" alt="image" src="https://github.com/user-attachments/assets/77f684e1-f112-4cd6-adf5-1de8dc63079a"> <br/>
   These type of data is used to store information from a register to a memory location. Hence, there is no rd(destination) field. The immediate data of 12 bits is also 
   divided into two fields of upper 7 and lower 5 bits. There are two source registers (rs1 and rs2). The address where data is to be stored is calculated by adding the 
   value in the base address register (rs1) to the immediate value, which is formed by combining its two parts. The content of the second source register (rs2) is then 
   stored at this computed memory address.
4. B-Type <br/>
   <img width="487" alt="image" src="https://github.com/user-attachments/assets/a23a48e7-16ea-4eb3-8777-61038c2a454e"> <br/>
   B-type instructions are mainly used as branch instructions. It usually involves a condition based on which the branching takes place.It  does not include rd register and 
   funct7. It contains rs1, rs2, funct3 and immediate. The immediate is divided for efficient encoding.
5. U-Type <br/>
   <img width="487" alt="image" src="https://github.com/user-attachments/assets/a9449223-8ac9-44df-bfde-ddea63425df3"> <br/>
   It stands for Upper Immediate. It is used for operations that involve a large immediate integer value. The upper 20 bits 
   are reserved for the immediate data.There is no source register. It has only destination register and opcode fields.
6. J-Type <br/>
   <img width="480" alt="image" src="https://github.com/user-attachments/assets/64c1ba08-6f47-4297-8e9d-caa2f89fd296"><br/>
   This is similar to the U-type instruction. It also has only immediate data, destination and opcode fields. It is used 
   for unconditional jump statements. It is used to jump to a target address which is calculated relative to the current 
   program counter.
## ENCODING INSTRUCTIONS
1. ADD r8,r9,r10<br/>
   Type: R-type<br/>
   opcode: 0110011<br/>
   rs1: 01001<br/>
   rs2: 01010<br/>
   rd: 01000<br/>
   func3: 000<br/>
   func7: 0000000<br/>
   32 bit pattern: 0000000_01010_01001_000_01000_0110011<br/>
2. SUB r10,r8,r9<br/>
   Type: R-type<br/>
   opcode: 0110011<br/>
   rs1: 01000<br/>
   rs2: 01001<br/>
   rd: 01010<br/>
   func3: 000<br/>
   func7: 0100000<br/>
   32 bit pattern: 0100000_01001_01000_000_01010_0110011<br/>
3. AND r9,r8,r10<br/>
   Type: R-type<br/>
   opcode: 0110011<br/>
   rs1: 01000<br/>
   rs2: 01010<br/>
   rd: 01001<br/>
   func3:111<br/>
   func7: 0000000<br/>
   32 bit pattern: 0000000_01010_01000_111_01001_0110011<br/>
4. OR r8,r9,r5<br/>
   Type: R-type<br/>
   opcode: 0110011<br/>
   rs1: 01001<br/>
   rs2: 00101<br/>
   rd: 01000<br/>
   func3: 110<br/>
   func7: 0000000<br/>
   32 bit pattern: 0000000_00101_01001_110_01000_0110011<br/>
5. XOR r8,r8,r4<br/>
   Type: R-type<br/>
   opcode: 0110011<br/>
   rs1: 01000<br/>
   rs2: 00100<br/>
   rd: 01000<br/>
   func3: 100<br/>
   func7: 0000000<br/>
   32 bit pattern: 0000000_00100_01000_100_01000_0110011<br/>
6. SLT r0,r1,r4<br/>
   Type: R-type<br/>
   opcode: 0110011<br/>
   rs1: 00001<br/>
   rs2:00100<br/>
   rd: 00000<br/>
   func3: 010<br/>
   func7: 0000000<br/>
   32 bit pattern: 0000000_00100_00001_010_00000_0110011<br/>
7. ADDi r2,r2,5<br/>
   Type: I-type<br/>
   opcode: 0110011<br/>
   rs1: 00010<br/>
   rd: 00010<br/>
   func3: 000<br/>
   imm[11:0]: 000000000101<br/>
   32 bit pattern: 000000000101_00010_000_00010_0010011<br/>
8. SW r2,r0,4<br/>
   Type: S-type<br/>
   opcode: 0100011<br/>
   rs1: 00000<br/>
   rs2: 00010<br/>
   func3: 010<br/>
   imm[4:0]: 00100<br/>
   imm[11:5]: 0000000<br/>
   32 bit pattern: 0000000_00010_00000_010_00100_0100011<br/>
9. SRL r6,r1,r1<br/>
   Type: R-type<br/>
   opcode: 0110011<br/>
   rs1: 00001<br/>
   rs2: 00001<br/>
   rd: 00110<br/>
   func3: 101<br/>
   func7: 0000000<br/>
   32 bit pattern: 0000000_00001_00001_00110_0110011<br/>
10. BNE r0,r0,20<br/>
    Type: B-type<br/>
    opcode: 1100011<br/>
    rs1: 00000<br/>
    rs2: 00000<br/>
    func3: 001<br/>
    imm[4:1]: 0101<br/>
    imm[11]: 0<br/>
    imm[12]: 0<br/>
    imm[10:5]: 000000<br/>
    32 bit pattern: 0_000000_00000_001_0101_0_1100011<br/>
11. BEQ r0,r0,15<br/>
    Type: B-type<br/>
    opcode: 1100011<br/>
    rs1: 00000<br/>
    rs2: 00000<br/>
    func3: 000<br/>
    imm[4:1]: 0111<br/>
    imm[11]: 1<br/>
    imm[12]: 0<br/>
    imm[10:5]: 000000<br/>
    32 bit pattern: 0_000000_00000_000_0111_1_1100011<br/>
12. LW r3,501,r2<br/>
    Type: I-type<br/>
    opcode: 0000011<br/>
    rs1: 00010<br/>
    rd: 00011<br/>
    func3: 010<br/>
    imm[11:0]: 000011111101_00010_010_00011_0000011<br/>
13. SLL r5,r1,r1<br/>
    Type: R-type<br/>
    opcode: 0110011<br/>
    rs1: 00001<br/>
    rs2: 00001<br/>
    rd: 00101<br/>
    func3: 001<br/>
    func7: 0000000<br/>
    32 bit pattern: 0000000_00001_00001_001_00101_0110011<br/>
## FUNCTIONAL SIMULATION OF RISC-V
The steps to be followed are:
* Make your own directory and navigate to that directory using the commands below. This is used to create a workspace for your files.
```
mkdir <name>
cd <name>
```
* Create file for design code and testbench using touch command as shown below:
```
touch design_name.v testbench.v
```
<img width="689" alt="image" src="https://github.com/user-attachments/assets/99470fb3-0bd4-404c-bda9-ede5d8abe66b"><br/>
* Use the verilog code from the reference library.
* For simulation, we run the following command:
```
iverilog -o output_file design_name.v testbench.v
./output_file
```
* To view the waveform, use:
```
gtkwave vcd_file.vcd
```
This is shown in the picture below:
![lab2](https://github.com/user-attachments/assets/d66eeb16-c051-4f8e-aa8a-0bade4d1fdf5)


Now let us go over the instructions given in the verilog file. As seen , they are hard coded.These instructions are "hard-coded" because their values or operations are explicitly defined in the source code and cannot be changed without modifying the code itself. They are not dynamically configurable. Hence there is a difference seen between the standard RISC-V instructions and hard-coded ISA.
![lab1](https://github.com/user-attachments/assets/bf1a9dc1-e419-4f8f-a212-b65ee9b4bb92)

The differences are noted below:

| Operation | Standard RISCV ISA | Hardcoded ISA |
|:---------:|:------------------:|:-------------:|
| ADD R6, R2, R1 | 32'h00110333 | 32'h02208300 |
| SUB R7, R1, R2 | 32'h402083b3	| 32'h02209380 |
| AND R8, R1, R3 | 32'h0030f433	| 32'h0230a400 |
| OR R9, R2, R5	 | 32'h005164b3	| 32'h02513480 |
| XOR R10, R1, R4| 32'h0040c533	| 32'h0240c500 |
| SLT R1, R2, R4 | 32'h0045a0b3	| 32'h02415580 |
| ADDI R12, R4, 5| 32'h0052a023	| 32'h00520600 |
| SW R3, R1, 2	 | 32'h0030a123	| 32'h00209181 |
| LW R13, R1, 2	 | 32'h0020a683	| 32'h00208681 |
| BEQ R0, R0, 15 | 32'h00000f63	| 32'h00f00002 |
| ADD R14, R2, R2 | 32'h00c2c333 | 32'h00210700 |
| BNE R0, R1, 20 | 32'hfef3e03b | 32'h01409002 |
| ADDI R12, R4, 5 | 32'h0052a023 | 32'h00520601 |
| SLL R15, R1, R2 | 32'h002097b3 | 32'h00208783 |
| SRL R16, R14, R2 | 32'h0030a123 | 32'h00271803 |

The waveforms are shown below:
1. ADD R6, R2, R1
   ![1](https://github.com/user-attachments/assets/fb697392-5e23-4b4e-9e54-bb4cdb6be800)
2. SUB R7, R1, R2
   ![2](https://github.com/user-attachments/assets/dcbc9b02-9f03-42ef-8fff-1af424708cb4)
3. AND R8, R1, R3
   ![3](https://github.com/user-attachments/assets/2c40ebe5-e844-4e3d-a133-32d581638866)
4. OR R9, R2, R5
   ![4](https://github.com/user-attachments/assets/55bd035c-5421-4b8c-8c8f-e3a5791d0b77)
5. XOR R10, R1, R4
    ![5](https://github.com/user-attachments/assets/5325c368-a9c2-4573-a14a-1ed428da57fb)
6. SLT R1, R2, R4
    ![6](https://github.com/user-attachments/assets/5ac39acb-515f-498b-a9f6-afe3fc6383e4)
7. ADDI R12, R4, 5
    ![7](https://github.com/user-attachments/assets/e65360e0-2f25-4b82-90d6-6ee1597ac7b9)
8. SW R3, R1, 2
    ![8](https://github.com/user-attachments/assets/635f24d6-46f7-4362-aef1-2b1d266d35de)
9. LW R13, R1, 2
    ![9](https://github.com/user-attachments/assets/63155331-ddf2-453c-b3db-753b35ca1f7d)
10. BEQ R0, R0, 15
    ![10](https://github.com/user-attachments/assets/1b9906a2-b635-4d5c-94b4-07943e4ee980)
11. ADD R14, R2, R2
    ![11](https://github.com/user-attachments/assets/70a96f91-4ebf-4147-bd31-2ab9ecfac08f)

## CUSTOM REAL-LIFE APPLICATION IMPLEMENTATION
### AUTOMATIC TEMPERATURE CONTROLLER
As the name suggests, automatic temperature controller is a simple design which regulates the temperature of a room by increasing/decreasing the temperature by heating/cooling mechanism until it reaches a specified target temperature. The  current room temperature can be read using a sensor.
The C code for the design is shown below:
``` c
#include <stdio.h>

int main() {
    int target_temp;
    int current_temp;

    printf("Enter the target room temperature: ");
    scanf("%d", &target_temp);
    printf("Enter the current room temperature: ");
    scanf("%d", &current_temp);

    while (1) {
        if (current_temp < target_temp) {
            while (current_temp < target_temp) {
                current_temp++;
                printf("Heating... Current Temperature: %d°C\n", current_temp);
                for (long i = 0; i < 100000000; i++); //delay
            }
            printf("Heater OFF. Target Temperature %d°C reached.\n", current_temp);
            break;
        } else if (current_temp > target_temp) {
            while (current_temp > target_temp) {
                current_temp--;
                printf("Cooling... Current Temperature: %d°C\n", current_temp);
                for (long i = 0; i < 100000000; i++); //delay
            }
            printf("Cooler OFF. Target Temperature %d°C reached.\n", current_temp);
            break;
        } else {
            printf("Target temperature reached: %d°C\n", current_temp);
            break;
        }
    }

    return 0;
}
```
* This code can be compiled using GCC and sample test results can be seen as shown below:
![app1](https://github.com/user-attachments/assets/7b7c7715-403c-41e3-9f1c-5f71cd9946b2)
* The same code can be compiled using RISC-V compiler and sample test results can be seen as shown below:
![app2](https://github.com/user-attachments/assets/aa11e1fe-e075-4b67-adae-abef373e95e2)

***From the snapshots of both compilation(GCC and RISC-V), we can see that the outputs are same.***

## RISC-V MYTH WORKSHOP
### TL-Verilog in Makerchip IDE
* Makerchip is a free tool used to design circuits. It can be used on your browser to code, compile, simulate and debug designs.
* Transaction Verilog or TL-Verilog is an extension to Verilog HDL. It has simpler syntaxes and provides a higher level of abstraction which makes coding easy.
### Logic gates
* Logic gates are the fundamental building blocks of digital circuits. They are very instrumental in design of all combinational and sequential circuits. The common gates with their truth table are shown below:
<img width="551" alt="image" src="https://github.com/user-attachments/assets/dbd91fc7-7b53-4591-8443-0a551bceb91a"> <br/>
### Basic combinational circuits in Makerchip
1. Pythagorean example
   Let us see a code that finds the hypotenuse( pythagorean distance between two points).
   ```
   \m4_TLV_version 1d: tl-x.org
   \SV
   `include "sqrt32.v";
   
   m4_makerchip_module
   \TLV
   
   // Stimulus
   
   // DUT (Design Under Test)
   |calc
      
         @1
            $aa_sq[7:0] = $aa[3:0] ** 2;
            $bb_sq[7:0] = $bb[3:0] ** 2;
         @2
            $cc_sq[8:0] = $aa_sq + $bb_sq;
         @3
            $cc[4:0] = sqrt($cc_sq);
     \SV
     endmodule
    ```
The picture is shown below:
![WhatsApp Image 2024-08-17 at 22 55 31_e77c5e76](https://github.com/user-attachments/assets/b6725f7f-4b72-496e-be0a-385e52a74365)
2. Inverter
```
$out = ! $in1;
```
![WhatsApp Image 2024-08-17 at 23 33 15_d39fceee](https://github.com/user-attachments/assets/edc55890-ce85-42c7-a6f4-57a0483c6e70)
3. And gate
```
$out = $in1 && $in2;
```
![WhatsApp Image 2024-08-17 at 23 34 56_01681869](https://github.com/user-attachments/assets/96ec4814-2c99-458f-9f46-30c9ec607555)
4. OR gate
```
$out = $in1 || $in2;
```
![WhatsApp Image 2024-08-17 at 23 35 45_e1d8c035](https://github.com/user-attachments/assets/75f88810-d8e8-4b09-a57a-c7f0d7f044ec)
5. XOR gate
```
$out = $in1 ^ $in2;
```
![WhatsApp Image 2024-08-17 at 23 40 50_81dd1b69](https://github.com/user-attachments/assets/3cd4ef22-1e1e-441f-bd4a-71483457088b)
6. Using vectors
```
$out[4:0] = $in1[3:0] + $in2[3:0] ;
```
![WhatsApp Image 2024-08-17 at 23 43 30_b6d2e6ae](https://github.com/user-attachments/assets/4510c662-05d4-4fde-9012-72831c6efeab)
7. Multiplexer
```
$out = $sel ? $in1 : $in2;
```
![WhatsApp Image 2024-08-17 at 23 46 06_b77d3926](https://github.com/user-attachments/assets/bb004dfe-d94f-48e0-8d58-8bd5efaecaec)
```
$out[7:0] = $sel ? $in1[7:0] : $in2[7:0] ;
```
![WhatsApp Image 2024-08-17 at 23 47 45_4a125a72](https://github.com/user-attachments/assets/d6dc2adc-29e4-48bf-b42c-4c58bbce8bba)

8. Basic Calculator
Below shown is a basic calculator which performs addition, subtraction, multiplication and division. The inputs are given random values. There is an operand select line which chooses 1 out of 4 operations.
<img width="430" alt="image" src="https://github.com/user-attachments/assets/64233cc1-f057-49c7-aaf1-5289df98e107"> <br/>
![WhatsApp Image 2024-08-17 at 23 55 14_eedb6eb1](https://github.com/user-attachments/assets/124c6276-db16-4c14-95a8-3d68046be19b)

### Basic sequential circuits in Makerchip
1. Fibonacci series <br/>
<img width="316" alt="image" src="https://github.com/user-attachments/assets/e4b02c17-e9b6-46fb-9697-42b9b48cef4e"> <br/>
![WhatsApp Image 2024-08-18 at 00 05 25_7d888ff3](https://github.com/user-attachments/assets/dc660d9d-c3fe-4a68-961c-9f8276f34bf7)
2. Counter <br/>
<img width="191" alt="image" src="https://github.com/user-attachments/assets/bc5df02c-64d2-4f34-b62d-787778901186"> <br/>
![WhatsApp Image 2024-08-18 at 00 07 47_3caad1b4](https://github.com/user-attachments/assets/4a65ac05-68f7-4659-b381-71e2f28e3ed1)
3. Sequential Calculator
We will be extending our earlier calculator with one of the inputs being the earlier output( feedback loop). <br/>
<img width="465" alt="image" src="https://github.com/user-attachments/assets/21e135bd-92cd-4660-8f33-72ac314393f0"><br/>
![WhatsApp Image 2024-08-18 at 00 19 49_a2e0038b](https://github.com/user-attachments/assets/1118dead-83ce-46ec-a56b-8c9c7425811f)

### CONCEPT OF PIPELINING
Pipelining refers to the technique of dividing the execution of an instruction into several stages.This allows multiple instructions to be processed simultaneously, improving the overall throughput of the processor.
We'll illustrate the concept using the example of Pythagorean distance calculation which we used earlier.
* Below shown is the case of the entire set of instructions being exceuted in a single stage. <br/>
![WhatsApp Image 2024-08-18 at 12 18 00_33014522](https://github.com/user-attachments/assets/05409387-244a-4788-8956-99c31e35c2d4) <br/>
* Now we divide our code into 3 stages with appropriate time stamps. <br/>
![WhatsApp Image 2024-08-18 at 12 18 35_d93618a7](https://github.com/user-attachments/assets/9f279826-528d-471e-99cf-71f956f67dd3) <br/>
* We can also have a 5 stage pipeline with intermediate stages also being considered as shown. <br/>
![WhatsApp Image 2024-08-18 at 12 19 17_f9ba0631](https://github.com/user-attachments/assets/ea8892d5-c703-44a7-8cb0-9665f3978391)<br/>
* Below shown is a case when the value of a is taken from the stage-4 and given back to stage-0.
![WhatsApp Image 2024-08-18 at 12 20 00_318f6076](https://github.com/user-attachments/assets/867f1dbf-6847-45e1-82a6-3f3ec428324e)
* The same can be extended to n-stages(example 12) as shown.<br/>
![WhatsApp Image 2024-08-18 at 12 20 54_938eef29](https://github.com/user-attachments/assets/4746e1a4-021b-4a14-a7c0-e93da3fabbd0)<br/>
* The code can be extended to find total distance of points using pipelining as shown.<br/>
![WhatsApp Image 2024-08-18 at 15 04 19_c15d4c1a](https://github.com/user-attachments/assets/17b28daa-d754-4fe4-90b3-f367f93ee7a7)<br/>

Let us now see the working of a calculator integrated with counter with stages.
* Here the calculator and counter functionality are in a single stage. <br/>
<img width="473" alt="image" src="https://github.com/user-attachments/assets/6b064866-fe9c-4805-9d7e-eae742d66273"><br/>
![WhatsApp Image 2024-08-18 at 12 35 57_9a3c4381](https://github.com/user-attachments/assets/276a409d-c742-4ba8-9a12-f49ec22cc131)<br/>
* We can extend the code to a 2 cycle pipeline. We add a valid signal which along with reset forces the operation-decidiing mux to force an output value of 0.<br/>
<img width="416" alt="image" src="https://github.com/user-attachments/assets/c63b812e-4ea0-47ed-9299-c6eda8df4686"><br/>
![WhatsApp Image 2024-08-18 at 12 56 07_5adad01c](https://github.com/user-attachments/assets/a4a27907-9f54-4906-b2e2-d3414fb9987c)<br/>
* The code can be further modified by changing the valid logic to a valid_or_reset signal logic. This signal decides the validity of the design.
<img width="413" alt="image" src="https://github.com/user-attachments/assets/67a4b1f8-7957-4c26-91a1-d0b8aca66ded"> <br/>
The code is shown below. For authenticity check of design, the clock signal is modified as clk_arun.
```
\m4_TLV_version 1d: tl-x.org
\SV
   // This code can be found in: https://github.com/stevehoover/RISC-V_MYTH_Workshop
   
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/RISC-V_MYTH_Workshop/bd1f186fde018ff9e3fd80597b7397a1c862cf15/tlv_lib/calculator_shell_lib.tlv'])

\SV
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)

\TLV   
   |calc
      @0
         $reset = *reset;
         $clk_arun = *clk;
      @1
         $val1 [31:0] = >>2$out [31:0];
         $val2 [31:0] = $rand2[3:0];
         
         $valid = $reset ? 1'b0 : >>1$valid + 1'b1 ;
         $valid_or_reset = $valid || $reset;
         
      ?$vaild_or_reset
         @1   
            $sum [31:0] = $val1 + $val2;
            $diff[31:0] = $val1 - $val2;
            $prod[31:0] = $val1 * $val2;
            $quot[31:0] = $val1 / $val2;
            
         @2   
            $out [31:0] = $reset ? 32'b0 :
                          ($op[1:0] == 2'b00) ? $sum :
                          ($op[1:0] == 2'b01) ? $diff :
                          ($op[1:0] == 2'b10) ? $prod :
                                                $quot ;
            
            

      // Macro instantiations for calculator visualization(disabled by default).
      // Uncomment to enable visualisation, and also,
      // NOTE: If visualization is enabled, $op must be defined to the proper width using the expression below.
      //       (Any signals other than $rand1, $rand2 that are not explicitly assigned will result in strange errors.)
      //       You can, however, safely use these specific random signals as described in the videos:
      //  o $rand1[3:0]
      //  o $rand2[3:0]
      //  o $op[x:0]
      
   //m4+cal_viz(@3) // Arg: Pipeline stage represented by viz, should be atleast equal to last stage of CALCULATOR logic.

   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
   

  \SV
   endmodule
 ```
<img width="929" alt="image" src="https://github.com/user-attachments/assets/b9ea7a64-aad4-4b3c-bb20-f94aabecfdc1"><br/>

### 3D distance calculation
The distance calculation code can be extended to 3 dimensions by adding an extra coordinate value and making the appropriate changes as shown.
![WhatsApp Image 2024-08-18 at 15 30 12_531ba253](https://github.com/user-attachments/assets/6ba5097b-337e-49ed-9c9f-31035d9f2954)<br/>

## SINGLE STAGE PROCESSOR
We shall now look at how a processor's functionality can be implemented in a single stage. <br/>
<img width="541" alt="image" src="https://github.com/user-attachments/assets/4ffb667f-56bc-4d1c-a7fb-b08317070637"><br/>
We will be designing the processor in steps of blocks as shown below.
1. Program Counter<br/>
 Program counter (or PC) holds the address of the next instruction to be executed in a program. It plays a crucial role in controlling the flow of a program by keeping track of where the processor is in the sequence of instructions. <br/>
 <img width="530" alt="image" src="https://github.com/user-attachments/assets/758d37fb-2642-491f-84a8-8d692041c323"><br/>
 ![WhatsApp Image 2024-08-20 at 00 56 53_19e2e44d](https://github.com/user-attachments/assets/2bd4057a-0f20-4d78-b377-bb57575cbb67)<br/>
2. Fetch<br/>
The instruction fetch unit (IFU) takes care of program instructions to be fetched from memory, and executed, in an appropriate order. The IFU reads the address stored in the Program Counter (PC) and retrieves the corresponding instruction from memory. The efficiency of the IFU directly impacts the performance of the CPU. If the IFU can quickly and accurately fetch instructions, the rest of the pipeline can operate at maximum efficiency.<br/>
<img width="266" alt="image" src="https://github.com/user-attachments/assets/789e3c6b-87f9-4470-87c5-f7010ef9e5da"><br/>
![WhatsApp Image 2024-08-20 at 00 59 46_4b3d398c](https://github.com/user-attachments/assets/c153ab7a-e598-455c-86bc-c81725db1871)<br/>
3. Decode<br/>
The Instruction Decode (ID) stage is a crucial part of the CPU's pipeline where the fetched instruction is interpreted, and the necessary control signals are generated to direct the subsequent stages of execution. <br/>
<img width="532" alt="image" src="https://github.com/user-attachments/assets/f2c936fd-0801-4df6-84cd-360134a2c43b"><br/>
There are basically 6 types of instructions: R-type(Register),I-type(Immediate),S-type(Store),B-type(Branch),U-type(Upper Immediate),J-type(Jump).<br/>
<img width="583" alt="image" src="https://github.com/user-attachments/assets/80188248-ab28-4922-a8e5-e263ab3df96d"><br/>
![WhatsApp Image 2024-08-20 at 01 00 56_44a78b42](https://github.com/user-attachments/assets/b98e49f5-38a3-4673-9241-ef10ac963163)<br/>
The immediate data is decoded accordingly as shown: <br/>
<img width="571" alt="image" src="https://github.com/user-attachments/assets/7532fe61-b542-40a3-894a-d881b3b56ed4"><br/>
![WhatsApp Image 2024-08-20 at 01 02 00_b22ae7fa](https://github.com/user-attachments/assets/cda8763d-6640-4d81-a2e5-72d03f6ef040)<br/>
Other important fields like rs1,rs2,rd,func3,func7 are also decoded.<br/>
<img width="568" alt="image" src="https://github.com/user-attachments/assets/a7d0720c-839a-43ff-a86e-67ee76b050ed"><br/>
![WhatsApp Image 2024-08-20 at 01 03 30_f1bed109](https://github.com/user-attachments/assets/3cdc8ac6-9c35-4964-8a6a-1c4e6ea0f896)<br/>
![WhatsApp Image 2024-08-20 at 01 04 44_5d0d417e](https://github.com/user-attachments/assets/5132b719-0c13-4dad-a9b7-b99f1d62b2c8)<br/>
The instructions marked in red below can also be decoded and added to the stage. To ignore warnings, we use `BOGUS_USE directive. <br/>
<img width="479" alt="image" src="https://github.com/user-attachments/assets/090dfd11-1666-4a5c-b48c-ad2cf4c15d5f"><br/>
![WhatsApp Image 2024-08-20 at 01 07 02_f7903f11](https://github.com/user-attachments/assets/cac7b2c4-2ee7-4538-84d2-5e072f6d43f1)<br/>
4. Register file <br/>
The register file consists of a set of registers used to hold temporary data and operands for instructions. It acts as a fast storage area where the processor can quickly read and write data, which is essential for efficient execution of instructions. <br/>
<img width="563" alt="image" src="https://github.com/user-attachments/assets/c2f942bb-99a5-4264-9ccd-a4683daba38d"><br/>
![WhatsApp Image 2024-08-20 at 01 09 23_b0be82ca](https://github.com/user-attachments/assets/4465cf8e-05e6-4384-886c-6552ee3d4a1a)<br/>
5. ALU <br/>
ALU is responsible for performing arithmetic and logical operations on the data provided by the instruction. The inputs for the ALU block comes from the register file. Based on the opcode(which decides the operation), the result is computed. <br/>
<img width="572" alt="image" src="https://github.com/user-attachments/assets/8f8db678-ddbd-48eb-a38f-445e05f91446"><br/>
![WhatsApp Image 2024-08-20 at 01 15 06_300d0148](https://github.com/user-attachments/assets/79af6bca-50d5-440d-b89e-a4eb906cd019)<br/>
![WhatsApp Image 2024-08-20 at 01 19 42_01ccd776](https://github.com/user-attachments/assets/bb0fe32d-4470-4fa2-90f8-97fd3f11bf95)<br/>
6. Writeback/ Register file write <br/>
Once the result is computed, the output is written back to a register file. This helps us save the output if and when it is required for further instructions/operations. <br/>
<img width="544" alt="image" src="https://github.com/user-attachments/assets/93db6d48-994a-4127-bc6d-aa687deb0693"><br/>
![WhatsApp Image 2024-08-20 at 01 23 10_64c603b3](https://github.com/user-attachments/assets/c3cca216-0b3a-4d0a-b7fb-ee59533e4995)<br/>
7. Branch instructions<br/>
Branch instructions in RISC-V are used to alter the flow of execution based on the result of a comparison. These instructions allow for conditional execution, loops, and decision-making within programs. They are handled differently since they can alter the PC contents. <br/>
<img width="549" alt="image" src="https://github.com/user-attachments/assets/0c5a8f09-298f-4170-8863-2db9a37c254d"><br/>
![WhatsApp Image 2024-08-20 at 01 34 51_70775ebe](https://github.com/user-attachments/assets/b6630542-0fea-440f-81eb-a9641234638c)<br/>
8. TESTBENCH<br/>
To verify the working, we can add a testbench command to check if the simulation has passed or not. <br/>
```
*passed = |cpu/xreg[10]>>5$value == (1+2+3+4+5+6+7+8+9);
```
![WhatsApp Image 2024-08-20 at 01 37 31_8629a791](https://github.com/user-attachments/assets/f41cb395-f3da-4432-a443-ad4eb5fcac2f) <br/>
As seen, the sum of numbers 1 to 9 is calculated to be 45 (2D in hexadecimal). The log file also shows a confirmation by simulation passed message.

## 5-STAGE PIPELINE PROCESSOR
The above single stage processor can be extended to a 5 stage pipeline. <br/>
* A 3- cycle valid signal is created. There is an additional start signal which signifies the first high bit of valid signal. So valid is 0 for reset and 1 for start. Otherwise, it is assigned the 3-cycle looped value. <br/>
<img width="458" alt="image" src="https://github.com/user-attachments/assets/5f2d216e-c5dd-47f6-8b0a-06b97c6d6203"><br/>
![WhatsApp Image 2024-08-20 at 01 50 28_05a397e4](https://github.com/user-attachments/assets/2d9bb594-6e0e-491e-95fd-ade2c39b06d2)<br/>
* To take care of invalid cases, we introduce a valid_taken_br signal. Accordingly, the PC mux is also modified.<br/>
![WhatsApp Image 2024-08-20 at 18 10 20_5d6db4d5](https://github.com/user-attachments/assets/1ab714ff-d50c-4cad-85de-805ef5bc8d06)<br/>
* The logic is then distributed across stages as shown.<br/>
<img width="449" alt="image" src="https://github.com/user-attachments/assets/3fd990bb-385e-44d0-9675-fef73d9e9c96"><br/>
* Register File Bypass (also known as register file forwarding or data forwarding) is a technique used in pipelined processors to handle data hazards and improve performance by allowing instructions to use the result of an operation before it has been written back to the register file. A common hazard is Read After Write (RAW) Hazard which occurs when an instruction needs to read a register that is yet to be updated by a previous instruction. <br/>
<img width="428" alt="image" src="https://github.com/user-attachments/assets/25038c25-76e6-41a6-84e0-9bc240faf404"><br/>
![WhatsApp Image 2024-08-20 at 18 23 47_e4173a4f](https://github.com/user-attachments/assets/6ed02393-a8d9-436b-b5e6-ad3416469606)<br/>
* The branch instruction is now corrected to account for the 3-cycle value based on the non-existence of a valid signal in the previous two cycles. The PC is incremented every cycle. <br/>
<img width="494" alt="image" src="https://github.com/user-attachments/assets/b25fea0a-60b7-4381-acc5-9aad2652bd67"><br/>
![WhatsApp Image 2024-08-20 at 18 10 20_a4e3bf61](https://github.com/user-attachments/assets/f7825424-3009-427e-84c2-6760f5ced9a9)<br/>
* The decode unit is completed to fit all instructions.The ones marked in red are already done. Load instructions are treated as same so the is_load signal is based only on the opcode. <br/>
<img width="330" alt="image" src="https://github.com/user-attachments/assets/be65e014-8b5b-455c-8285-ddb784dd9ae5"><br/>
![WhatsApp Image 2024-08-20 at 19 05 48_6d42dad9](https://github.com/user-attachments/assets/eabce9c8-661f-4cfd-8655-a99161530852)<br/>
* Similarly, the ALU is also completed. The SLT(set less than) and SLTI( set less than immediate) share a common term with SLTIU( Set less than immediate unsigned) hence intermediate signals are used. <br/>
![WhatsApp Image 2024-08-20 at 19 25 06_c23691ea](https://github.com/user-attachments/assets/19ca93a7-6202-426e-97f3-539eae5f750e)<br/>
* The load and store instructions are used to transfer data between memory and registers. These instructions are essential for handling data in programs, as they enable reading from and writing to memory locations. <br/>
<img width="491" alt="image" src="https://github.com/user-attachments/assets/acb91edf-2a11-4c48-9494-be1e23c7dc7a"><br/>
![WhatsApp Image 2024-08-20 at 19 35 10_31e08c48](https://github.com/user-attachments/assets/7de91bc8-d27c-421c-bab5-a302aceaf86c)<br/>
* The ALU is used to compute the address for load/store instructions. Later, the register file portion is also updated.<br/>
<img width="491" alt="image" src="https://github.com/user-attachments/assets/c4fcad7f-dd47-4043-8387-364634023c08"><br/>
![WhatsApp Image 2024-08-20 at 19 37 41_1d2d40c3](https://github.com/user-attachments/assets/92e572f2-8cb7-4a91-8365-bad35e270420)<br/>
![WhatsApp Image 2024-08-20 at 19 41 13_66cfd8ec](https://github.com/user-attachments/assets/94039cdf-e58e-4881-be9a-f42fb3692aff)<br/>
* The loading of data from memory is enabled by uncommenting the m4+dmem(@4) line. The interface signals are also connected.<br/>
<img width="260" alt="image" src="https://github.com/user-attachments/assets/7bfd352d-90b1-4c2a-bae2-d56d0500bc2b"><br/>
![WhatsApp Image 2024-08-20 at 19 58 05_5820f4f7](https://github.com/user-attachments/assets/b74f54f3-d41f-4218-9c02-7ac77c59d4d6)<br/>
* We modify the test program to store the result in register r15.<br/>
![WhatsApp Image 2024-08-20 at 19 54 06_4f6a5b44](https://github.com/user-attachments/assets/a86f6bb3-ddcc-416d-8ef4-bcc4b3fe7920)<br/>
* We add the jump feature to the processor. There are two jumps- JAL(Jump and Link) and JALR( Jump and Link Register). JAL does the computation relative to the PC while JALR does the computation relative to a register. <br/>
<img width="490" alt="image" src="https://github.com/user-attachments/assets/d8e6eb63-c416-4af5-9378-0b588e77cd17"><br/>
![WhatsApp Image 2024-08-20 at 20 00 32_e1d6c24a](https://github.com/user-attachments/assets/e6165bff-bca4-4654-9661-f79f1322f842)<br/>
* The PC is also modified accordingly. <br/>
![WhatsApp Image 2024-08-20 at 22 09 18_d98830dc](https://github.com/user-attachments/assets/818980c4-8718-4093-afe2-ee0af8637d94)<br/>
The entire design can be seen below: <br/>
<img width="958" alt="image" src="https://github.com/user-attachments/assets/3ade5b73-729b-4981-b20d-caec5f0e59e5"><br/>
The waveforms for the important signals are as follows:
* reset and clock<br/>
![WhatsApp Image 2024-08-21 at 10 56 19_2a79ce47](https://github.com/user-attachments/assets/1057ab7a-5529-4335-9e85-7795e93b6adf)<br/>
For authenticity check, the clock is named as clk_arun.<br/>
* Final result <br/>
<img width="109" alt="image" src="https://github.com/user-attachments/assets/46e52332-7644-4af7-ac6d-6346c0fe24f6"><br/>
<img width="525" alt="image" src="https://github.com/user-attachments/assets/0577b3c9-f458-4417-8757-6322aeb9107d"><br/>
It can be seen that the result of sum of numbers 1 to 9 is 45( 2D in hexadecimal) and is correct. The result is stored in Reg-15(as mentioned in our test code) which can be seen from the visualization window.
## SIMULATION OF RISCV CORE USING IVERILOG
The designed core in MakerChip IDE is in TL-Verilog language. It is to be converted to Verilog HDL. This is done with the help of the sandpiper-saas compiler. Pre-synthesis simulation was carried out using the GTKWave simulator. <br/>
**NOTE: All codes (.tlv,.v,tb.v) are included as separated files in the same repository.**
### STEPS
* Installing packages
```
sudo apt install make python python3 python3-pip git iverilog gtkwave docker.io
sudo chmod 666 /var/run/docker.sock
```
* Installing sandpiper
```
sudo apt-get install python3-venv
python3 -m venv .venv
source ~/.venv/bin/activate
pip3 install pyyaml click sandpiper-saas
```
* Clone the reference repository given.
```
git clone https://github.com/manili/VSDBabySoC.git
```
![sand3](https://github.com/user-attachments/assets/1a258d72-91da-4794-a79e-78a6cf912bec)<br/>
* Write your TLV code instead of the existing code and save it with .tlv extension.
* Run the compiler to convert the code into .v file
```
sandpiper-saas -i ./src/module/pgm.tlv -o rvmyth.v --bestsv --noline -p verilog --outdir ./src/module/
```
<img width="472" alt="image" src="https://github.com/user-attachments/assets/ee06d1c9-b24a-4c8d-a2fa-f629b64d5f87"><br/>

* Write the testbench file and simulate.
```
iverilog -o output/pre_synth_sim.out -DPRE_SYNTH_SIM src/module/testbench.v -I src/include -I src/module
```
* Run the .out file from output directory.
```
cd output
./pre_synth_sim.out
```
<img width="733" alt="image" src="https://github.com/user-attachments/assets/5c0ab1fa-9885-4701-b73e-357e0166ff20"><br/>
* A VCD file is generated. Run it using gtkwave to observe waveform.
```
gtkwave pre_synth_sim.vcd
```
<img width="514" alt="image" src="https://github.com/user-attachments/assets/6b7f7fe4-e704-47ee-843e-76aa83298c82"> <br/>
As observed, there is a 10 bit output which has the value 2D ( Sum of 1 to 9 in hexadecimal). There is also a clock signal (clk_arun) and reset(reset) associated with the core. The CPU result just verifies the same with the ALU operation. <br/>
For convienance, the graphs obtained from the earlier lab (MakerChip IDE) is added below. <br/>
![WhatsApp Image 2024-08-21 at 10 56 19_2a79ce47](https://github.com/user-attachments/assets/1057ab7a-5529-4335-9e85-7795e93b6adf)<br/>
<img width="525" alt="image" src="https://github.com/user-attachments/assets/0577b3c9-f458-4417-8757-6322aeb9107d"><br/>
It can be seen that the result is 2D in both graphs. Hence we can say that the designed core is functionally correct.
## BABYSOC SIMULATION-PRE-SYNTHESIS
SoC is a single chip that integrates all components of a computer or other electronic system. SOCs are commonly used in mobile devices, embedded systems, and increasingly in other areas of electronics. VSDBabySoC is a similar chip modelled on RISC-V which is able to perform some operations. It is generally used to design and test simple functionalities. It consists of:
* RVMYTH core is a simple RISCV-based CPU, which was designed earlier in this course.(refer earlier labs). It was  created from scratch using the TLV Verilog. The core was designed to add numbers from 1 to 9 and generate the sum output.
* A phase-locked loop or PLL is a control system that generates an output signal whose phase is related to the phase of an input signal.
* A digital-to-analog converter or DAC is a system that converts a digital signal into an analog signal.The DAC module gets the 10 bit digital output from the rvmyth core and generate the corresponding analog output signal 'OUT'.
<img width="610" alt="image" src="https://github.com/user-attachments/assets/07cb353c-b4b4-4ce7-bf04-45fb07c207e4"><br/>
The steps are as shown below: <br/>
### Installing tools: <br/>
* OpenSTA (Open Static Timing Analyzer) is an open-source software tool used for static timing analysis (STA) in digital integrated circuit (IC) design. It helps in validating the timing performance of a circuit without requiring simulation of the entire design. It can be installed using
```
git clone https://github.com/The-OpenROAD-Project/OpenSTA.git
cd OpenSTA
mkdir build
cd build
cmake ..
make -j20
sudo make install
```
![Screenshot from 2024-09-02 18-22-45](https://github.com/user-attachments/assets/a2553a97-0028-4dcf-88b5-ee2153558b18)<br/>
![Screenshot from 2024-09-02 18-23-17](https://github.com/user-attachments/assets/e3d171e2-4844-45cd-8aa1-e8023f424ffa)<br/>
* Yosys is an open-source framework for Verilog RTL synthesis. It is widely used in digital design workflows to convert high-level Verilog descriptions of digital circuits into gate-level representations that can be used for further implementation in FPGAs, ASICs, or for formal verification. It can be installed using:
```
sudo apt-get update
 git clone https://github.com/YosysHQ/yosys.git
 cd yosys
 sudo apt install make (If make is not installed please install it) 
 sudo apt-get install build-essential clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev
 make config-gcc
 make -j20
 sudo make install
```
![Screenshot from 2024-08-30 09-06-41](https://github.com/user-attachments/assets/c34608ce-0a0b-41b4-b745-bfde37096974)<br/>
![Screenshot from 2024-08-30 09-32-32](https://github.com/user-attachments/assets/fc5aa08f-7416-43dc-a417-f553ddddac28)<br/>
* Icarus Verilog (or Iverilog) is an open-source Verilog simulation and synthesis tool. It is widely used in digital design for simulating and verifying Verilog hardware descriptions.Icarus Verilog also supports synthesis, though its synthesis capabilities are limited. It can be instaled using:
```
sudo apt-get install iverilog
```
![Screenshot from 2024-09-02 18-29-18](https://github.com/user-attachments/assets/ffb11308-5c70-4226-8726-3dea2bd7af43)<br/>
* GTKWave is an open-source waveform viewer that is widely used in digital design to view and analyze simulation results. It is primarily used to generate waveform from dump files, such as VCD (Value Change Dump), LXT, or FST files. GTKWave provides a graphical interface to observe how signals in a digital design change over time. It can be installed using:
```
sudo apt install gtkwave
```
![Screenshot from 2024-09-02 18-29-32](https://github.com/user-attachments/assets/82cab9ae-31c4-4ef8-8b11-de41252387c9) <br/>
### GENERATING VCD FILE <br/>

* The next step is to download all the files required for simulation. For this, we clone the reference github repository.
```
git clone https://github.com/manili/VSDBabySoC.git
```
* We replace the .tlv file with our core code. We can also use the earlier generated .v files.
* We have to generate the vcd dump file for the gtkwave platform using the following steps:
```
cd VSDBabySoC
iverilog -o output/pre_synth_sim.out -DPRE_SYNTH_SIM src/module/testbench.v -I src/include -I src/module
cd output
./pre_synth_sim.out
gtkwave pre_synth_sim.vcd
```
![Screenshot from 2024-09-02 18-34-17](https://github.com/user-attachments/assets/343f6edd-dc26-465d-8295-efe9a445aad9)<br/>
### Waveforms
The waveforms generated from gtkwave are shown below: <br/>
![Screenshot from 2024-09-02 21-14-09](https://github.com/user-attachments/assets/1100c3c7-8e3c-4232-94cd-8dec8d641378)<br/>
![Screenshot from 2024-09-02 09-41-03](https://github.com/user-attachments/assets/31bfa046-d6c1-4802-96be-5fa458abdfe6)<br/>
The following observations can be made:
1. Custom Clock signal
2. Reset signal
3. Analog signal output from DAC module
4. Sum of numbers 1 to 9 which is 2D. This value is reflected across output of ALU unit from CPU stage, the 10 bit output from designed core(RV_TO_DAC) and 10 bit wire D.
The analog output is analogous to the 10 bit output from the core.<br/>
The timestamps of the project done is attached below:<br/>
![image](https://github.com/user-attachments/assets/751e3971-97ff-482e-98c9-ea78ed8a373c)
## VSD WORKSHOP-RTL DESIGN USING VERILOG WITH SKY130 TECHNOLOGY
### Installing Tools
* Iverilog, gtkwave,OpenSTA and yosys were installed as part of earlier labs. (refer above)
* Ngspice: Ngspice is an open source spice simulator for electronic circuits comprising of JFETs, bipolar and MOS transistors, passive elements like R, L, or C, diodes, transmission lines and other devices, all interconnected in a netlist. The user can add their circuits as a netlist, and the output is one or more graphs of currents, voltages and other electrical quantities or is saved in a data file. It can be installed using the following commands:
```
# Dependency for ngspice:
sudo apt-get install build-essential
sudo apt-get install libxaw7-dev

# ngspice installation:
tar -zxvf ngspice-40.tar.gz
cd ngspice-40
mkdir release
cd release
../configure  --with-x --with-readline=yes --disable-debug
make
sudo make install
```
![image](https://github.com/user-attachments/assets/68d2e095-4fb1-41a1-bd1a-ee94eda18e94)
* Magic: Magic is an electronic design automation (EDA) layout tool for very-large-scale integration (VLSI) integrated circuit developed at UCB. The main difference between Magic and other VLSI design tools is its use of "corner-stitched" geometry, in which all layout is represented as a stack of planes, and each plane consists entirely of "tiles" (rectangles). Magic is primarily famous for writing the scripting interpreter language Tcl. The steps to install is given below:
```
sudo apt-get install m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev mesa-common-dev libglu1-mesa-dev libncurses-dev
git clone https://github.com/RTimothyEdwards/magic
cd magic
./configure
make
sudo make install
```
![Screenshot from 2024-10-19 10-39-30](https://github.com/user-attachments/assets/a565d1d3-94df-4f38-8bb6-9f0fec11b561)
* OpenLane: OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, KLayout and a number of custom scripts for design exploration and optimization. It also provides a number of custom scripts for design exploration and optimization. The flow performs all ASIC implementation steps from RTL all the way down to GDSII. The steps are :
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential python3 python3-venv python3-pip make git
sudo apt install apt-transport-https ca-certificates curl software-properties-common
# docker installation:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world

sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot

# Check for installation
sudo docker run hello-world
```
![image](https://github.com/user-attachments/assets/37055316-6539-455d-a09d-edde90eee225)<br/>
OpenLane can be installed using:
```
cd $HOME
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make
make test
```
### Day 1: Introduction to Verilog RTL Design and Synthesis
#### Introduction to Open source simulator
* A simulator is a software tool that can be used to check the functionality of a circuit design before it is implemented in hardware. It does this by simulating the behavior of the design in software, using a Hardware Description Language (HDL) such as Verilog or VHDL.
* To verify the correctness of the RTL design with the specification, a testbench is written in HDL and simulated using the open-source simulator, Icarus Verilog. he testbench generates stimulus signals that are applied to the RTL design, and the simulator monitors the output signals to ensure that they are correct.
* The simulator monitors changes in the input signals. When an input signal changes, the simulator re-evaluates the RTL design and updates the output signals. The simulator records the changes in the input and output signals in a file called a Value Change Dump (VCD) file.
* Gtkwave is used to open the VCD file and debug the working using waveforms.
![Screenshot from 2024-10-21 10-26-22](https://github.com/user-attachments/assets/c2f1dd76-7a79-4708-9e61-e7247960e6e2)
Steps:
* We clone the required files from the github repository given.
```
git clone https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git
```
An overview of files inside the directory is shown below: <br/>
![Screenshot from 2024-10-19 17-09-47](https://github.com/user-attachments/assets/8bb52edf-320d-4774-b871-57fdd46176d4)<br/>
The standard cell library is a collection of well defined and appropriately characterized logic gates that can be used to implement a digital design. Timing data of standard cells is provided in the Liberty format.

The lib directory contains the library file sky130_fd_sc_hd__tt_025C_1v80.lib. Libraries in the SKY130 PDK are named using the following scheme:<br/>
<Process_name><Library_Source_Abbreviation><Library_type_abbreviation>[_<Library_name] <br/>

sky130 - Process Technology of the PDK sky130<br/>
fd - SkyWater Foundry<br/>
sc - Digital standard cells<br/>
hd - High density<br/>
tt - Typical Timing<br/>
025C - 25 degree celsius Temperature<br/>
1v80 - 1.8V Supply Voltage<br/>

### Basic simulation demo
Simulation is done to check the functionality of our designed module. Let us see the code first. We are using a file called good_mux.v given to us in the directory. The RTL is shown below:
```
// Verilog Code for 2:1 Mux

/*
All verilog code starts with module, ends with endmodule and within them the logic is written. 
For RTL design portlist should be mentioned in the module and it should have atleast one input port and one output port.
In this design there are two data input ports, one select line input port and one output port. 
*/

module good_mux (input i0 , input i1 , input sel , output reg y);
always @ (*) // Whenever any one of the input changes execute the code enclosed between begin ... end
begin
	if(sel) //If sel = 1 then output y follows i1 else output y follows i0 
		y <= i1;
	else 
		y <= i0;
end
endmodule
```
The testbench for the code is also shown.
```
`timescale 1ns / 1ps // defines the time units and time precision for simulation.
module tb_good_mux; // AS mentioned earlier testbench doesnot have input and output ports
	// Inputs
	reg i0,i1,sel;
	// Outputs
	wire y;

        // Instantiate the Unit Under Test (UUT)
	good_mux uut (
		.sel(sel),
		.i0(i0),
		.i1(i1),
		.y(y)
	);

	initial begin
	$dumpfile("tb_good_mux.vcd"); //This system task specifies the name of the VCD file where simulation waveform data will be written
	$dumpvars(0,tb_good_mux); //This system task is used to specify which signals within a module should be included in the VCD file for waveform dumping.
	// Initialize Inputs
	sel = 0;
	i0 = 0;
	i1 = 0;
	#300 $finish; //Terminate the simulation after 300ns
	end

always #75 sel = ~sel;  //Toggle the value of the select line after 75ns
always #10 i0 = ~i0;   //Toggle the value of the select line after 10ns
always #55 i1 = ~i1;  //Toggle the value of the select line after 55ns
endmodule
```
This is simulated using iverilog and waveform is seen using gtkwave as shown below. <br/>
![image](https://github.com/user-attachments/assets/dc2cdeb8-60f4-4267-9920-92162fe07b07)<br/>
![image](https://github.com/user-attachments/assets/47b0dce3-d0df-414e-b10c-dfcac11d1097)<br/>
As seen from the waveform, it clearly defines the behaviour of a 2:1 multiplexer.
#### Introduction to Yosys and Logic synthesis.
Synthesis is the process that converts RTL into a technology-specific gate-level netlist, optimized for a set of pre-defined constraints. Yosys is a tool used to convert the RTL from the netlist. A netlist is a file that represents the gates and flip-flops required to implement the design in hardware and the ineterconnections between them which is a result of the synthesis process. Yosys is provided with both the design and its corresponding .lib file, and its task is to generate the netlist.<br/>
![image](https://github.com/user-attachments/assets/ae22451d-1b74-4545-81ed-0cd6450521ad)<br/>
The .lib file is a library of standard cells that can be used to implement any logic function. It includes different versions of the same standard cell, such as low speed, high speed etc. We have two kinds of cells- fast and slow.
* Faster cells are used when the onus is to achieve high performance but at the cost of power.
* Slower cells are used in portable systems where power is a major concern at the cost of speed. <br/>
The steps to synthesize are:
* Invoke yosys- the tool for snthesizing.
```
yosys
```
* Read the liberty files into the current working directory.
```
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
* Read verilog file.
```
read_verilog good_mux.v 
```
![image](https://github.com/user-attachments/assets/7ea69957-6e2c-4477-ad42-08de76ca797a)
* Synthesize the file. We specify the module to be the top module using -top.
```
synth -top good_mux
```
![Screenshot from 2024-10-19 17-51-22](https://github.com/user-attachments/assets/aa74c29f-62e8-4710-abce-79246ec2583c)

* Generate the netlist. This command uses the ABC tool for technology mapping of yosys's internal gate library to a target architecture. The -lib switch liberty generate netlists for the specified cell library using the liberty file format. The show command is then used to view the synthesized diagram.
```
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```
![Screenshot from 2024-10-19 17-53-36](https://github.com/user-attachments/assets/38a16c74-92d4-47c8-891f-fc813f983231)
* Write the netlist into a verilog file. This netlist contains information about the nets,wires and gates used. The -noattr switch skips the attributes from included in the output netlist.
```
write_verilog -noattr good_mux_netlist.v
```
![Screenshot from 2024-10-19 17-57-29](https://github.com/user-attachments/assets/24d0d8c9-2d4c-45ce-8a9c-a19699a46fc6)
![Screenshot from 2024-10-19 18-09-44](https://github.com/user-attachments/assets/ee290993-e238-4e13-8fe4-67ffe39da051)

### Day 2: Timing libs, Hierarchical vs Flat Synthesis and Efficient flop coding styles
* .lib file: It is a Liberty format library file that describes the characteristics of digital cells in a standard cell library. This file is essential for synthesis and timing analysis, as it contains information about Cell descriptions, timing information,power consumption,logical and electrical paramaters.
* One of the fundamental parameter stored within .lib files comprises PVT parameters, where P signifies Process, V represents Voltage, and T denotes Temperature. The variations in these parameters can cause significant changes in the performance of circuits.
* Process Variation: During the manufacturing process, there may be some deviations in the transistor characteristics, causing non-uniformity across the semiconductor wafer. Critical parameters like oxide thickness, dopant concentration, and transistor dimensions experience alterations.
* Voltage Variation: Voltage regulators might exhibit variability in their output voltage over time, inducing fluctuations in current and impacting the operational speed of circuits.
* Temperature Variation: The functionality of a semiconductor device is sensitive to changes in temperature, particularly at the internal junctions of the chip.
![Screenshot from 2024-10-20 14-32-08](https://github.com/user-attachments/assets/8f8d1b70-4436-49ac-b62a-ac13c6542bc7)
#### Hiererchical Synthesis and Flat Synthesis
Hierarchical synthesis is breaking a comples modules into smaller, more manageable sub-modules or blocks. Each of these sub-modules can be synthesized or designed independently before being integrated into the larger system.
Let us consider the following example:<br/>
![image](https://github.com/user-attachments/assets/431abb7d-c50f-4363-834b-d9e33ccdf5b5)<br/>
The module multiple_modules instantiates two sub_modules where the sub_module1 implements the AND gate and sub_module2 implements the OR gate which are integrated in the multiple_modules.
The commands are:
```
yosys
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog 
read_verilog multiple_modules.v 
synth -top multiple_modules
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
show multiple_modules
write_verilog multiple_modules_hier.v
```
![Screenshot from 2024-10-20 14-41-24](https://github.com/user-attachments/assets/0242a119-9bdf-4cd2-9b28-30b4f2eb2d20)
![Screenshot from 2024-10-20 14-41-45](https://github.com/user-attachments/assets/30b4d8f2-0e49-4901-be50-8c070d08aa55)
![Screenshot from 2024-10-20 14-43-26](https://github.com/user-attachments/assets/3e839256-b1fe-4a1e-814c-a25f5845fe41)
![image](https://github.com/user-attachments/assets/6a1de80b-7ca7-40ec-83d6-a4d056110352)<br/>
Flattening the hierarchy means simplifying the hierarchical structure of a design by collapsing or merging lower-level modules or blocks into a single, unified representation. The commands are:
```
yosys
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog 
read_verilog multiple_modules.v 
synth -top multiple_modules
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
flatten
show multiple_modules
write_verilog multiple_modules_hier.v
```
![Screenshot from 2024-10-20 14-51-35](https://github.com/user-attachments/assets/6b856b1f-f1f7-4e71-a427-3b5274776040)
![Screenshot from 2024-10-20 14-55-09](https://github.com/user-attachments/assets/c4349c89-7feb-4326-93c9-d4a8aaa6220f)
The flatten command breaks the hierarchy and makes the design into a single module by creating AND and OR gates for the logics inferred by the submodule which is shown in the images above. <br/>
The comparison between the two can be seen below:
![Screenshot from 2024-10-20 14-52-50](https://github.com/user-attachments/assets/ed1dce37-ac6f-46e2-86ad-4f7ba87038bd)
#### Synthesising a Submodule:
Sub-module synthesis refers to the process of synthesizing a portion of a larger digital design, focusing on specific modules or components rather than the entire design. This approach is often used in larger designs to improve manageability, reduce complexity, and optimize the synthesis process.
```
yosys
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog multiple_modules.v 
synth -top sub_module
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
show
```
![Screenshot from 2024-10-20 14-57-14](https://github.com/user-attachments/assets/4d23ac22-25e6-49d9-a286-8550d4ced7f4)

#### Various Flops Coding Styles and optimization
A flip-flop is a fundamental sequential synchronous electronic circuit that is capable of storing information. A single flip-flop can store 1- bit of information and several flip-flops can be grouped together to form registers and memory that can store multiple bits of information. 
Need for flipflops:
* In any electronic circuit there will always be an propagation delay. These delays may cause glitches in the output which may cause the output state to change when it is not supposed to. In order to avoid the glitches a D flip-flop can be connected at the output so that the output will change only at the rising or falling edge of the clock.
Steps:
```
iverilog rtl_design.v testbench.v
./a.out
gtkwave testbench.vcd
```
```
yosys
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib  
read_verilog <module_name.v> 
synth -top <top_module_name>
dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
show
write_verilog -noattr <netlist_name.v>
```
* Here dfflibmap is used to enable technology mapping of dflipflops.
#### Different Types of Flipflops:
1. D flip-flop with Asynchronous reset<br/>
This flipflop has the reset as higher priority than clock.
```
module dff_asyncres ( input clk ,  input async_reset , input d , output reg q );
always @ (posedge clk , posedge async_reset)
begin
	if(async_reset)
		q <= 1'b0;
	else	
		q <= d;
end
endmodule
```
![image](https://github.com/user-attachments/assets/53311df9-76d2-4c46-b75f-046a0adb242e)
![Screenshot from 2024-10-20 15-06-51](https://github.com/user-attachments/assets/f50a4e47-b85d-4fb4-bcf1-2f707d2ff243)
![Screenshot from 2024-10-20 15-30-54](https://github.com/user-attachments/assets/790c0c58-88f5-4d11-a804-7d0d1d94c644)
![Screenshot from 2024-10-20 15-31-07](https://github.com/user-attachments/assets/738765e6-8e4d-499e-8407-a88565446112)
![Screenshot from 2024-10-20 15-33-07](https://github.com/user-attachments/assets/98077210-00b7-486e-8a41-a3b809a71542)
2. D flip-flop with synchronous reset<br/>
This flipflop has the clock as higher priority than reset.
```
module dff_syncres ( input clk , input async_reset , input sync_reset , input d , output reg q );
always @ (posedge clk )
begin
	if (sync_reset)
		q <= 1'b0;
	else	
		q <= d;
end
endmodule
```
![image](https://github.com/user-attachments/assets/4dfd92e1-8526-40f0-af36-469705705ad1)
![Screenshot from 2024-10-20 15-27-52](https://github.com/user-attachments/assets/84a992b1-5232-4586-b7cf-2770348c34bb)
![Screenshot from 2024-10-20 15-36-29](https://github.com/user-attachments/assets/6a1ec9f3-fce3-4de1-bf18-2733e2f68cb0)
![Screenshot from 2024-10-20 15-37-09](https://github.com/user-attachments/assets/f03a8cf5-9730-452c-ba51-dad238d2b873)
3. D flip-flop with Asynchronous set<br/>
A D flip-flop with asynchronous set combines the functionality of a D flip-flop with the ability to set its state asynchronously. This means that the flip-flop's stored value can be set to 1 or high state regardless of the clock signal's state.
```
module dff_async_set ( input clk ,  input async_set , input d , output reg q );
always @ (posedge clk , posedge async_set)
begin
	if(async_set)
		q <= 1'b1;
	else	
		q <= d;
end
endmodule
```
![image](https://github.com/user-attachments/assets/68635d23-9cb2-4370-bec3-35c77c78cc9c)
![image](https://github.com/user-attachments/assets/9edd3cb5-d1ec-43b6-84fd-96f9b62441e0)
![image](https://github.com/user-attachments/assets/77c65a81-eaf0-4a8e-a3d3-6399f0e563bb)
![Screenshot from 2024-10-20 15-35-20](https://github.com/user-attachments/assets/81ad531e-0f2a-4bd5-9108-0581a99c837f)
![Screenshot from 2024-10-20 15-35-45](https://github.com/user-attachments/assets/f219f164-64be-4caf-b640-f71caa1764be)
4. D flip-flop with Asynchronous and Synchronous reset<br/>
A D flip-flop with both asynchronous and synchronous reset that combines the features of a D flip-flop with the ability to reset its state using either an asynchronous reset input or a synchronous reset input. 
```
module dff_asyncres_syncres ( input clk , input async_reset , input sync_reset , input d , output reg q );
always @ (posedge clk , posedge async_reset)
begin
	if(async_reset)
		q <= 1'b0;
	else if (sync_reset)
		q <= 1'b0;
	else	
		q <= d;
end
endmodule
```
![image](https://github.com/user-attachments/assets/4a472a56-fef3-4f66-bd5a-4d7c80e36a50)
![image](https://github.com/user-attachments/assets/9baa1ff9-6eb1-4ab4-8816-cb62a5763afe)
![image](https://github.com/user-attachments/assets/40fe7e9e-46ec-4809-be5d-fd1acfff00a5)
![image](https://github.com/user-attachments/assets/d3d5e187-8a41-472b-8597-2fffeb796c1f)
![image](https://github.com/user-attachments/assets/22f85380-7a73-4240-b60b-3bf81647c0fa)
#### Optimization
1. Example 1:<br/>
The code is shown below:
```
module mul2 (input [2:0] a, output [3:0] y);
	assign y = a * 2;
endmodule
```
![Screenshot from 2024-10-20 15-49-04](https://github.com/user-attachments/assets/1c8397b5-926b-4ae1-b005-b006f5e76d26)
![Screenshot from 2024-10-20 15-50-07](https://github.com/user-attachments/assets/472a1961-44f7-4a21-b90b-f0efe61a3cca)
As seen,the code doesn't need any hardware and it only needs the proper wiring of the input bits to the output and grounding the bit y0.
2. Example 2:<br/>
The code is shown below:
```
module mult8 (input [2:0] a , output [5:0] y);
	assign y = a * 9;
endmodule
```
![Screenshot from 2024-10-20 15-56-12](https://github.com/user-attachments/assets/8889c567-83ab-4e9a-a0e7-1bb94c3551af)
In this design, the 3-bit number a is multiplied by 9 which can be re-written as 8a+a. This is nothing but left shifting a by 3 bits.Consider that a = a2 a1 a0. (8a) results in a2 a1 a0 0 0 0. (9a)=(8a)+a = a2 a1 a0 a2 a1 a0 = aa(in 6 bit format). Hence in this case no hardware realization is required.
### Day - 3 : Combinational and Sequential Optimisations
Optimisations are done inorder to achieve designs that are efficient in terms of area, power, and performance. There are two types:
#### Combinational circuit optimization
1. Constant Propagation (Direct Optimisation)<br/>
Consider the example: <br/>
![image](https://github.com/user-attachments/assets/b992a367-ef8b-45c6-a6bf-dcab5c510911)
The circuit can be optimized using De-Morgan's theorem as shown:<br/>
![image](https://github.com/user-attachments/assets/250016d3-ce3d-49fb-99ab-aea3ca139422)
2. Boolean Logic Optimisation
Consider the example shown:
```
assign y = a?(b?c:(c?a:0)):(!c);
```
This will create a mux as shown.<br/>
![image](https://github.com/user-attachments/assets/35386db5-41b4-41e9-b2c9-51cf5692f374)
It can be optimized as : <br/>
![image](https://github.com/user-attachments/assets/31b31355-4aba-4a4c-8028-bcdf6c5f85a1)
#### Sequential circuit optimization
It is of two types:
1. Basic Techniques<br/>
   a. Sequential Constant Propagation
2. Advanced Techniques<br/>
   a.State Optimisation<br/>
   b.Retiming<br/>
   c.Sequential Logic Cloning<br/>

1. Sequential Constant Propagation<br/>
The D flip-flop shown in the figure is positive edge triggered with asynchronous reset and the data input D is always tied to the ground (i.e, low state or logic 0). When reset is applied the output of the flop becomes low and if reset it deasserted the output of the flop still remains low. Hence the output Y to be always in high state (logic 1 or VDD). Hence the optimised version of this circuit is connecting the output port Y directly to VDD i.e., the supply voltage. <br/>
![image](https://github.com/user-attachments/assets/54face00-ea96-47d6-a0f9-16cecb771a24)<br/>
2. State Optimisation<br/>
State optimization refers to the process of minimizing the number of unused states in a digital circuit's state machine.
3. Sequential Logic Cloning<br/>
Sequential logic cloning is used to replicate or clone a portion of a sequential logic circuit while maintaining its functionality and behavior. <br/>
![image](https://github.com/user-attachments/assets/0e7a57f2-48e6-4da3-afac-9a9f8493c1b9) <br/>
Consider flop A has large positive slack. Since B and C are placed far, there will be routing delay. To avoid this flop A and the combinational logic 2 is replicated or cloned in the paths of B and C as shown in the figure below. <br/>
![image](https://github.com/user-attachments/assets/026268d8-1437-4913-bdd0-9a4904c3e88e)
4. Retiming<br/>
Retiming used to improve the performance interms of better timing characteristics by repositioning the registers (flip-flops) within the circuit without altering its functionality.The placement of these registers can significantly impact the circuit's overall performance, including its critical path delay, clock frequency, and power consumption. Consider the diagram shown below:<br/>
![image](https://github.com/user-attachments/assets/063cb748-01df-4035-8561-44cc33591d19)<br/>
Here the propagation delay/maximum frequency of the circuit depends on the combinational circuit delay.(Assuming Flop C has no setup time). As seen, the maximum operating frequency will be minimum(200,500) which is 200MHz.<br/>
This can be optimized by retiming the circuit such that the delays between the flops change as shown. The maximum operating frequency is also increased.<br/>
![image](https://github.com/user-attachments/assets/89ba9741-c153-4429-8023-7c181da9e071)<br/>
#### Combinational Optimization labs:
The flow is as shown: <br/>
```
yosys
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib  
read_verilog <module_name.v> 
synth -top <top_module_name>
# flatten # Use if multiple modules are present
opt_clean -purge
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
show
write_verilog -noattr <netlist_name.v>
```
* opt_clean is used to remove unused cells and wires. The -purge switch removes internal nets if they have a public name.
1. Example 1:<br/>
The code is as shown:
```
module opt_check (input a , input b , output y);
	assign y = a?b:0;
endmodule
```
![Screenshot from 2024-10-20 19-09-32](https://github.com/user-attachments/assets/45eaec76-ba81-4f54-aa8e-d2497a8b2603)
![Screenshot from 2024-10-20 19-25-51](https://github.com/user-attachments/assets/7f196c04-f127-4d0e-a55a-218a103a22f2)
![Screenshot from 2024-10-20 19-26-52](https://github.com/user-attachments/assets/084d644a-b5ca-410c-b688-ee604298fa16)
2. Example 2:<br/>
The code is as shown:
```
module opt_check2 (input a , input b , output y);
	assign y = a?1:b;
endmodule
```
![image](https://github.com/user-attachments/assets/3b35304b-bfdc-4e8f-a6d2-d862b3f4152d)
![Screenshot from 2024-10-20 19-28-22](https://github.com/user-attachments/assets/cf3ef552-fa55-4f42-93be-4e53299879ec)
![Screenshot from 2024-10-20 19-29-37](https://github.com/user-attachments/assets/1b64012c-6adc-48a3-9eac-0e9930c28223)
3. Example 3:<br/>
The code is shown below:
```
module opt_check3 (input a , input b, input c , output y);
	assign y = a?(c?b:0):0;
endmodule
```
![Screenshot from 2024-10-20 19-31-20](https://github.com/user-attachments/assets/2e392673-436e-40f9-9654-992ec3c5d338)
![Screenshot from 2024-10-20 19-31-42](https://github.com/user-attachments/assets/dea7fba9-6b58-40cb-97cd-6630d6c806ea)
![Screenshot from 2024-10-20 19-33-20](https://github.com/user-attachments/assets/35cb407e-37fc-4bd1-a07b-9454e19af817)
4. Example 4:<br/>
The code is shown below:
```
module opt_check4 (input a , input b , input c , output y);
 assign y = a?(b?(a & c ):c):(!c);
 endmodule
```
![Screenshot from 2024-10-20 20-04-25](https://github.com/user-attachments/assets/29e9d8e7-385a-4fb9-a8b3-17286ca5ee55)
![Screenshot from 2024-10-20 20-05-40](https://github.com/user-attachments/assets/2a7a538f-5641-49a8-920f-9ce4f88f45f3)
![Screenshot from 2024-10-20 20-06-12](https://github.com/user-attachments/assets/d84fc9cc-ba1d-4743-8f86-59668f05640c)
5. Example 5:<br/>
The code is shown below:
```
module sub_module1(input a , input b , output y);
 assign y = a & b;
endmodule


module sub_module2(input a , input b , output y);
 assign y = a^b;
endmodule


module multiple_module_opt(input a , input b , input c , input d , output y);
wire n1,n2,n3;

sub_module1 U1 (.a(a) , .b(1'b1) , .y(n1));
sub_module2 U2 (.a(n1), .b(1'b0) , .y(n2));
sub_module2 U3 (.a(b), .b(d) , .y(n3));

assign y = c | (b & n1); 


endmodule
```
![image](https://github.com/user-attachments/assets/e3c05d5e-0d5f-465c-a20f-1b31cd7352e0)
![image](https://github.com/user-attachments/assets/2f1d2f1c-56f2-4400-9338-c85d2e5d0f68)
![image](https://github.com/user-attachments/assets/27daae0f-8ab1-4a65-a54f-38243d2a8e07)

6. Example 6:<br/>
The code is shown below:
```
module sub_module(input a , input b , output y);
 assign y = a & b;
endmodule



module multiple_module_opt2(input a , input b , input c , input d , output y);
wire n1,n2,n3;

sub_module U1 (.a(a) , .b(1'b0) , .y(n1));
sub_module U2 (.a(b), .b(c) , .y(n2));
sub_module U3 (.a(n2), .b(d) , .y(n3));
sub_module U4 (.a(n3), .b(n1) , .y(y));


endmodule
```
![image](https://github.com/user-attachments/assets/3a13f173-fa0f-42f2-aa8e-ddf448ef92b0)
![image](https://github.com/user-attachments/assets/67a9f0dd-6538-462c-9bc2-483f6e789348)
![image](https://github.com/user-attachments/assets/44a3dad4-17f5-40b6-93f6-8746e12a9dad)
#### Sequential Optimization labs:
The commands are similar to earlier labs. Here we first show the simulation using iverilog and gtkwave. Then we optimize the synthesis using yosys.
1. Example 1:<br/>
The code is shown below:
```
module dff_const1(input clk, input reset, output reg q);
always @(posedge clk, posedge reset)
begin
	if(reset)
		q <= 1'b0;
	else
		q <= 1'b1;
end

endmodule
```
![image](https://github.com/user-attachments/assets/12a42f8b-4e30-48c6-b08b-fdba1c706974)
![image](https://github.com/user-attachments/assets/6a0571cf-e3f6-4d7c-a3b3-d6a1732f7cb9)
![Screenshot from 2024-10-20 21-51-01](https://github.com/user-attachments/assets/22710977-07a7-4788-90de-978a47881e68)
![Screenshot from 2024-10-20 21-52-05](https://github.com/user-attachments/assets/b8e800a3-36e3-4df4-8eaf-f1ee95e4453a)
2. Example 2:<br/>
The code is shown below:
```
module dff_const2(input clk, input reset, output reg q);
always @(posedge clk, posedge reset)
begin
	if(reset)
		q <= 1'b1;
	else
		q <= 1'b1;
end
endmodule
```
![Screenshot from 2024-10-20 21-44-32](https://github.com/user-attachments/assets/28f20731-13c8-49a2-8ae9-30c4af710ae8)
![image](https://github.com/user-attachments/assets/3e8be070-a902-4b33-ab00-472661c6d5fb)
![Screenshot from 2024-10-20 21-53-20](https://github.com/user-attachments/assets/4320f6a7-2612-4e62-8017-e67ce1854a3c)
![Screenshot from 2024-10-20 21-54-04](https://github.com/user-attachments/assets/12b4fe25-042d-41fb-9bf2-5cbe9457296b)
* COMPARISON: The above designs can be compared and differences can be observed with the diagram below. <br/>
![Screenshot from 2024-10-20 21-48-18](https://github.com/user-attachments/assets/1d8dd1ec-def7-4518-9550-7bb2b3ca6273)
3. Example 3:<br/>
The code is shown below:
```
module dff_const3(input clk, input reset, output reg q);
reg q1;

always @(posedge clk, posedge reset)
begin
	if(reset)
	begin
		q <= 1'b1;
		q1 <= 1'b0;
	end
	else
	begin
		q1 <= 1'b1;
		q <= q1;
	end
end

endmodule
```
![image](https://github.com/user-attachments/assets/3556dc41-20ed-4696-a41a-5d0b577c6bbe)
![image](https://github.com/user-attachments/assets/cadfc355-18e0-4a16-835e-c9337e8d8d48)
![Screenshot from 2024-10-20 21-58-26](https://github.com/user-attachments/assets/c21cc704-875e-467e-81ce-89707ee9ac8a)
![Screenshot from 2024-10-20 21-59-00](https://github.com/user-attachments/assets/ded296d5-4275-4500-b52e-25743d8942b3)
4. Example 4:<br/>
The code is shown below:
```
module dff_const4(input clk, input reset, output reg q);
reg q1;

always @(posedge clk, posedge reset)
begin
	if(reset)
	begin
		q <= 1'b1;
		q1 <= 1'b1;
	end
	else
	begin
		q1 <= 1'b1;
		q <= q1;
	end
end

endmodule
```
![Screenshot from 2024-10-20 22-02-10](https://github.com/user-attachments/assets/03173bc5-25e9-456a-808a-ab40c0f2c637)
![Screenshot from 2024-10-20 22-00-39](https://github.com/user-attachments/assets/9df1463b-ebb8-4635-ad25-edb52b904097)
![Screenshot from 2024-10-20 22-01-05](https://github.com/user-attachments/assets/5a7e4495-6efd-40ba-8635-317789db82e6)
5. Example 5:<br/>
The code is shown below:
```
module dff_const5(input clk, input reset, output reg q);
reg q1;

always @(posedge clk, posedge reset)
begin
	if(reset)
	begin
		q <= 1'b0;
		q1 <= 1'b0;
	end
	else
	begin
		q1 <= 1'b1;
		q <= q1;
	end
end

endmodule
```
![image](https://github.com/user-attachments/assets/b5d5877b-eeb9-42cd-ad1f-ed7f09f69f8a)
![Screenshot from 2024-10-20 22-04-13](https://github.com/user-attachments/assets/cbdd62d0-f4d6-4978-af6c-c2d445e75040)
#### Optimization of unused states:
In verilog, especially sequential circuits, there are optimizations which involve the reduction of flops. Here each flop correspond to a state. <br/>
1. Example 1:<br/>
The code is shown below:
```
module counter_opt (input clk , input reset , output q);
reg [2:0] count;
assign q = count[0];

always @(posedge clk ,posedge reset)
begin
	if(reset)
		count <= 3'b000;
	else
		count <= count + 1;
end

endmodule
```
The commands and steps are similar to the earlier labs.
![Screenshot from 2024-10-20 22-15-31](https://github.com/user-attachments/assets/b2a1284a-3f98-4012-9ac8-6b12498f90de)
![Screenshot from 2024-10-20 22-16-46](https://github.com/user-attachments/assets/4ffaaf29-bb20-4eb2-a7aa-b705b89c4e24)
As seen, there is only one flop inferred. <br/>
2. Example 2:<br/>
The code is shown below:
```
module counter_opt (input clk , input reset , output q);
reg [2:0] count;
assign q = (count[2:0] == 3'b100);

always @(posedge clk ,posedge reset)
begin
	if(reset)
		count <= 3'b000;
	else
		count <= count + 1;
end

endmodule
```
![Screenshot from 2024-10-20 22-19-48](https://github.com/user-attachments/assets/539f8789-bc91-41fd-bb4b-72e0e1591178)
![Screenshot from 2024-10-20 22-21-03](https://github.com/user-attachments/assets/44d3a00b-caeb-4649-85f6-0f0471737ba1)
Here we can see that there are three flops inferred.<br/>
### Day 4: Gate Level Simulation (GLS), Blocking Vs Non-blocking assignment and Synthesis-Simulation Mismatch
* Gate Level Simulation helps ensure that the synthesized version of the design matches the specification both in terms of functionality and timing. It helps in debugging.The GLS flow is similar to the testbench flow except that gate level verilog models are also used. It is necessary to mention the gatelevel verilog models to iverilog to make the iverilog understand about the standard cell given in the library.<br/>
![image](https://github.com/user-attachments/assets/e3236b09-7f57-43de-a799-f1d47c7f2383)<br/>
* Synthesis-simulation mismatch refers to the differences between the behavior of a digital circuit as simulated at the Register Transfer Level (RTL) and its behavior after being synthesized to gate-level netlists. Synthesis-simulation mismatch can occur because of the following reasons: <br/>
1. Missing Sensitivity List: <br/>
Consider the below code:<br/>
```
module mux(
	input i0,i1,s,
	output reg y
)
	always @(sel) begin
		if(sel)
			y = i1;
		else
			y = i0;
	end
endmodule
```
Here the always block is sensitive only to select line. Hence if the inputs change, there won't be any effect on the output till there is a change in the select line.<br/>
The corrected code would be:<br/>
```
module mux(
	input i0,i1,s,
	output reg y
)
	always @(*) begin //* - It considers changes in all the input signals. So always is evaluated whenever any signal changes.
		if(sel)
			y = i1;
		else
			y = i0;
	end
endmodule
```
2. Blocking and Non-Blocking Statements in Verilog:<br/>
* Blocking assignments are denoted using the "=" operator. When a blocking assignment is executed, it directly assigns the right-hand side value to the left-hand side variable immediately within the current simulation cycle.
* Non-blocking assignments are denoted using the "<=" operator. When a non-blocking assignment is encountered, the right-hand side value is scheduled to be assigned to the left-hand side variable at the end of the current simulation cycle. <br/>
Consider the example shown below:<br/>
```
module code(
	input clk,reset,d,
	output reg q
)
	reg q0;
	always @(posedge clk, posedge reset) begin
		if(reset) begin
			q=1'b0;
			q0=1'b0;
		end
		else begin
			q = q0; //Line 1
			q0=d; // Line 2
		end
	end
endmodule
```
Since blocking assignmnet is used,both the lines will be executed sequentially. First line 1 will be executed creating a flip-flop whose input is q0 and output is q. Then line 2 will be executed which creates a second flip-flop whose input is d and output is q0.<br/>
![image](https://github.com/user-attachments/assets/985896b4-5d9d-4cff-a045-521f588b84c2)<br/>
Now let us see another example: <br/>
```
module code(
	input clk,reset,d,
	output reg q
)
	reg q0;
	always @(posedge clk, posedge reset) begin
		if(reset) begin
			q=1'b0;
			q0=1'b0;
		end
		else begin
			q0 = d; //Line 1
			q=q0; // Line 2
		end
	end
endmodule
```
Since , blocking assignment is used line 1 and line 2 will be executed sequentially. First line 1 will be executed which creates a D flip-flop with the input d and output q0, then line 2 is executed. Since q0 is already defined assigning q0 to q creates wire . Hence only flip-flop is inferred instead of two. <br/>
![image](https://github.com/user-attachments/assets/df3fe35a-68b9-4e1b-9481-033fb5f5ecf1)<br>
#### Labs:
The steps are:
* Simulation:
```
iverilog <rtl_name.v> <tb_name.v>
./a.out
gtkwave <dump_file_name.vcd>
```
* Synthesis:
```
yosys
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib  
read_verilog <module_name.v> 
synth -top <top_module_name>
# opt_clean -purge # If optimisation has to be done
# dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib # if sequential circuit is used 
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
show
write_verilog -noattr <netlist_name.v>
```
* GLS:
```
iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v <netlist_name.v> <tb_name.v>
./a.out
gtkwave <dump_file_name.vcd>
```
1. Example 1: <br/>
The code is shown below:
```
module ternary_operator_mux (input i0 , input i1 , input sel , output y);
	assign y = sel?i1:i0;
endmodule
```
![image](https://github.com/user-attachments/assets/31fe4556-5153-4a9a-8cee-172c0786a1da)
![image](https://github.com/user-attachments/assets/e082d587-ebed-4c00-acac-57d97549bacd)
![Screenshot from 2024-10-20 22-43-22](https://github.com/user-attachments/assets/c6f85807-a934-4009-8121-12303aa899c6)
![Screenshot from 2024-10-20 22-45-18](https://github.com/user-attachments/assets/3319dfd4-303a-4b6e-9211-c2289f4d9291) <br/>
The comparison for debugging can be seen below. The GLS waveform can be differentiated by noticing the extra wires and UUTs.<br/>
![Screenshot from 2024-10-20 22-49-53](https://github.com/user-attachments/assets/91f8b76c-818d-4cd6-8f6d-04c3edf25f18)<br/>
As seen there is no mismatch.<br/>
2. Example 2: <br/>
The code is shown below:
```
module bad_mux (input i0 , input i1 , input sel , output reg y);
always @ (sel)
begin
	if(sel)
		y <= i1;
	else 
		y <= i0;
end
endmodule
```
![image](https://github.com/user-attachments/assets/1e6c1658-ca5a-477b-9d8b-51cc29d2e50f)
![image](https://github.com/user-attachments/assets/f61d0979-7084-4350-a800-939e909a445d)
![Screenshot from 2024-10-20 22-53-32](https://github.com/user-attachments/assets/ac627e72-b412-4425-9aa6-c6ccb6d72865)
![Screenshot from 2024-10-20 22-54-24](https://github.com/user-attachments/assets/e38bd0a4-f4cf-4180-b5d3-6554e4bd4ebb)
The comparison for debugging can be seen below. The GLS waveform can be differentiated by noticing the extra wires and UUTs.<br/>
![Screenshot from 2024-10-20 22-57-21](https://github.com/user-attachments/assets/d37ebf7a-f095-4ba4-8f82-a30b31f29299)<br/>
Here, there is a mismatch.<br/>
3. Example 3: <br/>
The code is shown below:
```
module blocking_caveat (input a , input b , input  c, output reg d); 
reg x;
always @ (*)
begin
	d = x & c; //Line 1
	x = a | b; //Line 2
end
endmodule
```
![image](https://github.com/user-attachments/assets/31e43dca-c6ee-4af7-8941-c89157a803b5)
![image](https://github.com/user-attachments/assets/b1f02288-cf53-46bc-927c-b676bde098e7)
![Screenshot from 2024-10-20 23-00-56](https://github.com/user-attachments/assets/9a50f53e-4fda-47fc-934b-156a8b6fd441)
![Screenshot from 2024-10-20 23-02-09](https://github.com/user-attachments/assets/293c0d09-1948-462d-bce0-3ea0ea4a52d8)<br/>
The comparison for debugging can be seen below. The GLS waveform can be differentiated by noticing the extra wires and UUTs.<br/>
![Screenshot from 2024-10-20 23-04-42](https://github.com/user-attachments/assets/b3cd33eb-838d-4324-b260-8c13710e53a1)<br/>
Here, there is a mismatch.<br/>

## BABYSOC SIMULATION-POST SYNTHESIS
In this section, we will be seeing the synthesis and simulation of the BabySoC which we had designed earlier(Refer 12: BabySoC Simulation- Pre-synthesis). In the referred lab, we had generated a .v file from .tlv file using sandpiper and simulated it using iverilog and gtkwave. The waveform is obtained as shown in the repository. <br/>
Now we will be synthesizing the same .v file using yosys, generating a netlist and simulate it using iverilog and gtkwave with the aim of obtaining the same waveform.<br/>
The steps are as follows:<br/>
* We launch yosys using the command in the terminal.
* Read the liberty file of sky130 which contains the cells to map to. Along with this, we also read the liberty file of DAC and PLL blocks.
```
yosys
read_liberty -lib <sky130_lib_path>
read_liberty -lib <avsddac.lib>
read_liberty -lib <avsdpll.lib>
```
![Screenshot from 2024-10-23 18-54-12](https://github.com/user-attachments/assets/a0f8296a-273c-464e-a5ea-21d9b90b7526)<br/>


* Read the verilog files to synthesize. You can read mutliple files and set the top module.
```
read_verilog <file_name>
synth -top <module_name>
```
![Screenshot from 2024-10-23 18-54-39](https://github.com/user-attachments/assets/3fef09a3-e38b-4e4a-a8bf-0e2c2bfa8c01)<br/>
![Screenshot from 2024-10-23 18-54-48](https://github.com/user-attachments/assets/eea18a45-93ff-4c73-be7e-802a48e3bc03)<br/>
* We then map the fliflop libraries using the command:
```
dfflibmap -liberty <path>
```
![Screenshot from 2024-10-23 18-55-19](https://github.com/user-attachments/assets/b4751caf-6368-413e-b775-9fe10c3e2361)<br/>
* The cells are then mapped using the command:
```
abc -liberty <path>
```
* The show command along with the top module gives us the diagram as shown below:
![Screenshot from 2024-10-23 18-57-38](https://github.com/user-attachments/assets/5ecd117b-18a8-4a44-bfac-707457cca114)<br/>
* The netlist is generated using the command:
```
write_verilog -noattr <file_name_synth.v>
```
This netlist is used to do the post-synthesis simulation using iverilog. The synthesized netlist is added as a file in the same repository with the name vsdbabysoc.synth.v.
* The next series of steps involve simulating the netlist using iverilog. For this, we will need to include the files needed(.lib files, .vh files, .v files etc). The commands are as shown below:
```
mkdir -p output/post_synth_sim && iverilog -o output/post_synth_sim/post_synth_sim.out -DPOST_SYNTH_SIM -DFUNCTIONAL -DUNIT_DELAY=#1     -I src/module/include -I src/module -I src/gls_model     src/module/testbench.v && cd output/post_synth_sim && ./post_synth_sim.out
gtkwave post_synth_sim.vcd
```
![Screenshot from 2024-10-23 18-50-15](https://github.com/user-attachments/assets/853a4390-f53a-471e-a075-0dd3f712b94c)<br/>

Here, the POST_SYNTH_SIM directive is enabled and given to the testbench which includes all the files and simulates the sythesized netlist to generate the .vcd file. The waveform is shown below(for atleast 20 cycles). Note that mapped standard cells:<br/>
![Screenshot from 2024-10-23 18-49-14](https://github.com/user-attachments/assets/e1163def-74b1-4a39-af80-66e763163c47)<br/>
A better view of the analog continous values(due to DAC) in the waveform is shown below:
![Screenshot from 2024-10-23 18-49-36](https://github.com/user-attachments/assets/7cc1a5c1-1c20-4fb6-91a4-8a684852c61d)<br/>

Let us compare it with the waveform obtained in the pre-synthesis simulation. For easy comparison, the waveform from the earlier lab is attached below.<br/>
The following can be noted: <br/>
![Screenshot from 2024-09-02 21-14-09](https://github.com/user-attachments/assets/1100c3c7-8e3c-4232-94cd-8dec8d641378)<br/>
![Screenshot from 2024-09-02 09-41-03](https://github.com/user-attachments/assets/31bfa046-d6c1-4802-96be-5fa458abdfe6)<br/>
1. Custom Clock signal<br/>
2. Reset signal<br/>
3. Analog signal output from DAC module<br/>
4. Sum of numbers 1 to 9 which is 2D. This value is reflected across output of ALU unit from CPU stage, the 10 bit output from designed core(RV_TO_DAC) and 10 bit wire D.<br/>
The analog output is analogous to the 10 bit output from the core.<br/>
**Note that both the waveforms are exactly similar to each other. The post-synthesis waveform can be identified by the wires and UUTs created. The mapped standard cells can also be seen. This similarity is what we had expected and can now confirm that our designed BabySoC is working and functionally correct**
## REFERENCES
* https://forgefunder.com/~kunal/riscv_workshop.vdi
* https://riscv.org/technical/specifications/
* https://fraserinnovations.com/risc-v/risc-v-instruction-set-explanation/
* https://github.com/vinayrayapati/rv32i
* https://github.com/stevehoover/RISC-V_MYTH_Workshop/blob/master/risc-v_shell.tlv
* https://github.com/Subhasis-Sahu/SFAL-VSD
* https://github.com/shivanishah269/risc-v-core/tree/master/FPGA_Implementation
* https://github.com/manili/VSDBabySoC.git
* https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git
  



  
