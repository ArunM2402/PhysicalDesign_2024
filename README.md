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
15. [STATIC TIMING ANALYSIS OF VSDBABYSOC](#static-timing-analysis-of-vsdbabysoc)<br/>
16. [SYNTHESIZE BABYSOC DESIGN USING DIFFERENT PVT CORNER LIBRARY FILES](#synthesize-babysoc-design-using-different-pvt-corner-library-files)<br/>
17. [VSD WORKSHOP-ADVANCED PHYSICAL DESIGN USING OpenLANE-SKY130 ](#vsd-workshop-advanced-physical-design-using-openlane-sky130)<br/>
18. [OPENROAD PHYSICAL DESIGN-VSDBABYSOC](#openroad-physical-design-vsdbabysoc)<br/>
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
## STATIC TIMING ANALYSIS OF VSDBABYSOC
Static Timing Analysis(or STA) refers to a method used in digital circuit design to verify the timing performance of a circuit without needing to simulate its behavior dynamically. It analyzes the timing characteristics of a circuit by examining its structure and the delays associated with its components, such as gates and interconnects. For understanding the basics of STA, we have referred to the below two courses conducted by Prof. Kunal Ghosh on Udemy:<br/>
1. VSD - Static Timing Analysis - I<br/>
2. VSD - Static Timing Analysis - II<br/>
Some key points/ topics from the course are listed below:<br/>
### Setup Time
Setup time is the minimum duration before the clock edge during which a data input must remain stable to ensure it is correctly sampled by a flip-flop or latch. This timing constraint is critical because if the data changes too close to the clock edge, the flip-flop may not reliably capture the data, leading to potential errors in circuit operation. 
### Hold Time
Hold time is the minimum period after the clock edge that a data input must remain stable for the flip-flop to correctly latch the input value. This requirement is crucial because if the data changes too soon after the clock edge, the flip-flop might capture an incorrect value, resulting in malfunctioning circuit behavior. 
### Setup Slack
Setup slack is the difference between the available time for a signal to stabilize before the clock edge and the required setup time. It is calculated by subtracting the required time (which includes setup time) from the arrival time of the signal at the flip-flop. Positive setup slack indicates that the signal arrives with sufficient time to meet the setup requirement, while negative slack signifies a timing violation, suggesting that the design may fail to operate correctly at the intended clock frequency.
### Hold Slack
Hold slack is the difference between the time a data signal must remain stable after the clock edge and the actual arrival time of that signal. It is calculated by subtracting the required time (which incorporates hold time) from the arrival time. Positive hold slack indicates that the hold time constraint is satisfied, meaning the signal remains stable long enough after the clock edge, while negative slack indicates a hold time violation, which can lead to incorrect data being latched in the flip-flop.<br/>
![image](https://github.com/user-attachments/assets/efef0ab7-7adb-4b2b-a681-5fc912c6ebc4)<br/>
Launch Flop: The launch flop is the flip-flop that sends out the data at the clock edge. When the clock transitions (usually from low to high), the launch flop captures its input data and begins propagating this data to the next stage in the circuit.<br/>
Capture Flop: The capture flop is the flip-flop that receives the data from the launch flop. It samples the incoming data at the next clock edge, which occurs after the launch flop has already sent its data out. The timing between the launch and capture flops is critical for ensuring that the data is stable and meets setup and hold time requirements.<br/>
### Types of Setup/Hold Analysis<br/>
1. Reg2Reg Analysis <br/>
Reg2Reg (Register to Register) analysis evaluates the timing between two flip-flops to ensure that data output from one register arrives at the input of another within the required setup and hold times. This analysis is critical for confirming reliable data transfer and preventing timing violations that could lead to incorrect data being latched.<br/>
2. In2Reg Analysis <br/>
In2Reg (Input to Register) analysis focuses on the timing between an external input signal and a flip-flop. It verifies that the input data stabilizes before the clock edge (setup time) and remains stable afterward (hold time), ensuring the flip-flop can accurately sample the input without data corruption. <br/>
3. Reg2Out Analysis <br/>
Reg2Out (Register to Output) analysis examines the timing from a flip-flop to an output pin. It ensures that the data driven from the flip-flop meets the necessary timing constraints for external outputs, confirming that the output is valid and stable when needed. <br/>
4. In2Out Analysis <br/>
In2Out (Input to Output) analysis assesses the timing from an external input directly to an output pin. It ensures that the input data is stable and meets setup and hold time requirements relative to the output timing constraints, maintaining accurate data flow in the circuit. <br/>
5. Clock Gating <br/>
Clock gating is a power-saving technique used in digital circuits to reduce dynamic power consumption by selectively disabling the clock signal to certain components when they are not in use. By preventing unnecessary clock transitions in inactive parts of a circuit, clock gating minimizes switching activity and conserves energy, making it especially important in battery-powered and energy-efficient designs. <br/>
6. Recovery/Removal Analysis <br/>
Recovery and removal analysis are timing checks performed on flip-flops to ensure reliable operation during data transitions. Recovery time refers to the minimum time after the clock edge that the data must be stable before it can change again, ensuring that the flip-flop can correctly capture the new data. Removal time is the minimum time after the clock edge that the data must remain stable to ensure it is latched properly. Both analyses are crucial for preventing timing violations that could lead to incorrect data capture. <br/>
7. Data-to-Data Analysis <br/>
Data-to-Data analysis assesses the timing relationships between data signals within a circuit. This analysis ensures that the timing constraints are met when data changes occur at different points in the circuit, verifying that the data paths do not violate setup and hold times between various data signals. It is essential for maintaining data integrity across combinational and sequential logic. <br/>
8. Latch (Time Borrow/Time Given) <br/>
In the context of latches, time borrow refers to a situation where a latch is allowed to take extra time to hold data, which can help accommodate timing violations in a circuit. Conversely, time given refers to the time that a latch can release data before the next capture event, allowing for flexibility in timing analysis. Both concepts are important for optimizing latch designs and ensuring reliable data capture without violating timing constraints. <br/>
### Slew/ Transition Analysis
1. Data (Max/Min) <br/>
Max slew refers to the maximum allowable rise or fall time that a data signal can have while still meeting timing requirements. If the slew rate exceeds this maximum, it may result in timing violations due to insufficient time for subsequent components to sample the signal accurately. Conversely, Min slew refers to the minimum allowable rise or fall time, ensuring that the signal does not change too quickly, which could lead to issues like ringing or reflections in the circuit. <br/>
2. Clock (Max/Min) <br/>
Max slew indicates the maximum rise or fall time for the clock signal that still allows the circuit to function correctly; exceeding this can lead to setup and hold time violations at flip-flops. On the other hand, Min slew denotes the minimum rise or fall time, ensuring that the clock signal transitions do not happen too abruptly, which could cause glitches or unintended behavior in synchronous circuits. <br/>
### Load Analysis
1. Fanout(Max/Min) <br/>
Max fanout refers to the maximum number of inputs that a gate output can effectively drive without degrading signal integrity or timing performance. Exceeding this limit can lead to increased delay and potential timing violations due to excessive loading. Min fanout, while less commonly discussed, typically indicates the minimum number of inputs that need to be driven for the circuit to function properly; insufficient fanout can affect logic levels and overall circuit reliability. <br/>
2. Capacitance(Max/Min) <br/>
Max capacitance is the maximum allowable capacitance that can be connected to a gate output while still meeting timing and performance requirements. High capacitance can slow down signal transitions, leading to longer delays. Min capacitance typically denotes the minimum capacitive load necessary to ensure stable operation and proper voltage levels; too little capacitance can lead to unstable signals and noise susceptibility. <br/>
### Clock Analysis
1. Skew <br/>
Clock skew refers to the difference in arrival times of the clock signal at various components in a synchronous circuit. It can occur due to variations in the physical layout, routing, or clock distribution network. Skew can lead to timing issues if the difference exceeds the allowable setup and hold time requirements for flip-flops, potentially causing data corruption. Minimizing skew is essential for ensuring that all components receive the clock signal simultaneously, thus maintaining the integrity and reliability of data transfers in the circuit. <br/>
2. Pulse Width <br/>
Pulse width analysis examines the duration of the clock signal's high and low states. Pulse width must meet specific timing requirements to ensure that flip-flops can correctly sample input data. The minimum pulse width is the shortest duration that the clock signal must remain high or low for reliable operation; if it falls below this threshold, it may lead to incorrect data capture. Conversely, the maximum pulse width can determine the limits for clock frequency and the overall performance of the circuit. Properly managing pulse width is critical for the effective operation of synchronous designs. <br/>
### ACTIVITY: To perform STA analysis on the synthesized design(from earlier lab). The design is to operating at 11.55ns. For setup uncertainty and clock transition we assume 5% of clock period. For hold uncertainty and data transition we assume 8% of clock period.
The procedure is as follows: <br/>
* OpenSTA tool is used for this lab. The tool was already installed as part of the earlier labs.
* The liberty file used is sky130_fd_sc_hd__tt_025C_1v80.lib.
* We launch STA using the following command:
```
cd /home/arunp24/VSDbabysoc/src/script/
sta
```
* Due to lack of the proper PLL and DAC liberty files for complete/correct STA, we should consider the output port of the PLL (PLL.CLK) as the clock and analyze the timing of the design.
* We use a configuration file to set the libraries and read the verilog file. The configuration file also reads the constraints file(.sdc).
```
read_liberty -min ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_liberty -max ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_liberty -min ../lib/avsdpll.lib
read_liberty -max ../lib/avsdpll.lib
read_liberty -min ../lib/avsddac.lib
read_liberty -max ../lib/avsddac.lib
read_verilog ../module/vsdbabysoc.synth.v
link_design vsdbabysoc
read_sdc ../sdc/vsdbabysoc_synthesis.sdc
report_checks -path_delay max -format full  # for finding the setup analysis 
report_checks -path_delay min -format full  # for finding the hold analysis 
```
![Screenshot from 2024-10-28 15-16-17](https://github.com/user-attachments/assets/83083365-1406-4f5c-8298-772e2d85722a)

* We first use a basic SDC file to check for unconstrained setup and hold slack
```
set_units -time ns
create_clock [get_pins {pll/CLK}] -name clk -period 11.55
```
The setup slack is shown below:<br/>
![Screenshot from 2024-10-28 14-58-11](https://github.com/user-attachments/assets/21f6047c-f403-429d-a8f9-de597dd45ac5)
The hold slack is shown below:<br/>
![Screenshot from 2024-10-28 14-58-19](https://github.com/user-attachments/assets/d40ced4e-1b71-4d72-965e-319ea87ac031)
Note: The entire terminal screen has been attached to confirm the authencity of completing the lab. Please check for keywords- setup and hold in the report to differentiate between setup and hold slacks.<br/>
As seen, the slack is violated. This can be fixed by optimizing the logic and reducing propagation delay, inserting buffers or increasing the time period(lowering the clock frequency) of the design. <br/>
* Now we use a SDC file which incorporates the constraints given i.e For setup uncertainty and clock transition we assume 5% of clock period. For hold uncertainty and data transition we assume 8% of clock period.\
```
# Create clock with new period
create_clock [get_pins pll/CLK] -name clk -period 11.55 -waveform {0 5.775} 

# Set loads
set_load -pin_load 0.5 [get_ports OUT] 
set_load -min -pin_load 0.5 [get_ports OUT] 

# Set clock latency
set_clock_latency 1 [get_clocks clk] 
set_clock_latency -source 2 [get_clocks clk] 

# Set clock uncertainty
set_clock_uncertainty 0.5775 [get_clocks clk]  ; # 5% of clock period for setup
set_clock_uncertainty -hold 0.924 [get_clocks clk] ; # 8% of clock period for hold

# Set maximum delay
set_max_delay 11.55 -from [get_pins dac/OUT] -to [get_ports OUT] 

# Set input delay for VCO_IN
set_input_delay -clock clk -max 4 [get_ports VCO_IN] 
set_input_delay -clock clk -min 1 [get_ports VCO_IN] 

# Set input delay for ENb_VCO
set_input_delay -clock clk -max 4 [get_ports ENb_VCO] 
set_input_delay -clock clk -min 1 [get_ports ENb_VCO] 

# Set input delay for ENb_CP
set_input_delay -clock clk -max 4 [get_ports ENb_CP] 
set_input_delay -clock clk -min 1 [get_ports ENb_CP] 

# Set input transition for VCO_IN
set_input_transition -max 0.5775 [get_ports VCO_IN] ; # 5% of clock
set_input_transition -min 0.1155 [get_ports VCO_IN] ; # adjust if needed

# Set input transition for ENb_VCO
set_input_transition -max 0.5775 [get_ports ENb_VCO] ; # 5% of clock
set_input_transition -min 0.1155 [get_ports ENb_VCO] ; # adjust if needed

# Set input transition for ENb_CP
set_input_transition -max 0.924 [get_ports ENb_CP] ; # 5% of clock
set_input_transition -min 0.924 [get_ports ENb_CP] ; # adjust if needed
```
* We run the same configuration file and the slacks are noted.
* The setup slack is shown below:<br/>
![Screenshot from 2024-10-28 14-54-57](https://github.com/user-attachments/assets/82866c48-8885-493f-bce7-39e3753686d0)
* The hold slack is shown below:<br/>
![Screenshot from 2024-10-28 14-55-05](https://github.com/user-attachments/assets/06104dcb-ed1f-4263-a786-9333dadbd694)
Note: The entire terminal screen has been attached to confirm the authencity of completing the lab. Please check for keywords- setup and hold in the report to differentiate between setup and hold slacks.<br/>
As seen, the slack is violated. This can be fixed by optimizing the logic and reducing propagation delay, inserting buffers or increasing the time period(lowering the clock frequency) of the design. <br/>
All files and reports mentioned in this lab are uploaded to the same repository. Please refer above.

## SYNTHESIZE BABYSOC DESIGN USING DIFFERENT PVT CORNER LIBRARY FILES
In this lab, we will be checking for the worst setup/hold slacks using different PVT Corner library files.<br/>
* PVT (Process, Voltage, Temperature) are the three key factors that impact the performance and behavior of integrated circuits in VLSI design. Here is a summary of how each of these factors affects circuit design:<br/>
1. Process (P): <br/>
Process variation refers to deviations in the semiconductor fabrication process, such as variations in impurity concentration, oxide thickness, and transistor dimensions.
These process variations can cause changes in transistor parameters like threshold voltage, mobility, and current drive, which in turn impact the circuit delay and performance.
Circuits designed with a "fast" process will have lower delays, while "slow" process corners will have higher delays. <br/>
2. Voltage (V): <br/>
The supply voltage of the chip can deviate from the optimal value during operation due to factors like noise, IR drop, and voltage regulator variations.
Higher supply voltage leads to increased current and faster charging/discharging of capacitances, resulting in lower delays. Lower voltage has the opposite effect. <br/>
3. Temperature (T): <br/>
The operating temperature of the chip can vary widely depending on the environment and power dissipation within the chip.
Higher temperatures generally decrease carrier mobility, leading to increased delays. <br/>
* We must ensure that our design is functioning properly for all PVT corners. For this, we use STA using the following procedure.<br/>
* We run the script shown below. This script reads in all the library files one by one from the specified directory and is used on our VSDBabySoC design. The constraints file from the earlier lab is also read(clock-11.55 ns with 5% uncertainity for setup and 8% uncertainity for hold).<br/>
```
set list_of_lib_files(1) "sky130_fd_sc_hd__tt_025C_1v80.lib"
set list_of_lib_files(2) "sky130_fd_sc_hd__ff_100C_1v65.lib"
set list_of_lib_files(3) "sky130_fd_sc_hd__ff_100C_1v95.lib"
set list_of_lib_files(4) "sky130_fd_sc_hd__ff_n40C_1v56.lib"
set list_of_lib_files(5) "sky130_fd_sc_hd__ff_n40C_1v65.lib"
set list_of_lib_files(6) "sky130_fd_sc_hd__ff_n40C_1v76.lib"
set list_of_lib_files(7) "sky130_fd_sc_hd__ss_100C_1v40.lib"
set list_of_lib_files(8) "sky130_fd_sc_hd__ss_100C_1v60.lib"
set list_of_lib_files(9) "sky130_fd_sc_hd__ss_n40C_1v28.lib"
set list_of_lib_files(10) "sky130_fd_sc_hd__ss_n40C_1v35.lib"
set list_of_lib_files(11) "sky130_fd_sc_hd__ss_n40C_1v40.lib"
set list_of_lib_files(12) "sky130_fd_sc_hd__ss_n40C_1v44.lib"
set list_of_lib_files(13) "sky130_fd_sc_hd__ss_n40C_1v76.lib"

for {set i 1} {$i <= [array size list_of_lib_files]} {incr i} {
read_liberty /home/arunp24/SFAL-VSD/skywater-pdk-libs-sky130_fd_sc_hd/timing/$list_of_lib_files($i)
read_liberty -min ../lib/avsdpll.lib
read_liberty -max ../lib/avsdpll.lib
read_liberty -min ../lib/avsddac.lib
read_liberty -max ../lib/avsddac.lib
read_verilog /home/arunp24/VSDBabySoC/src/module/vsdbabysoc.synth.v
link_design vsdbabysoc

read_sdc /home/arunp24/VSDBabySoC/src/sdc/vsdbabysoc_synth1.sdc

report_checks -path_delay min_max -fields {nets cap slew input_pins fanout} -digits {4} > /home/arunp24/VSDBabySoC/output/sta/new_reports/min_max_$list_of_lib_files($i).txt

exec echo "$list_of_lib_files($i)" >> /home/arunp24/VSDBabySoC/output/sta/new_reports/sta_worst_max_slack.txt
report_worst_slack -max -digits {4} >> /home/arunp24/VSDBabySoC/output/sta/new_reports/sta_worst_max_slack.txt

exec echo "$list_of_lib_files($i)" >> /home/arunp24/VSDBabySoC/output/sta/new_reports/sta_worst_min_slack.txt
report_worst_slack -min -digits {4} >> /home/arunp24/VSDBabySoC/output/sta/new_reports/sta_worst_min_slack.txt

}
```
* The script generates reports for each library file. A table comprising of the worst setup and hold slacks from the reports is shown below: <br/>
![image](https://github.com/user-attachments/assets/26a57487-ddd4-4d64-b2f8-f2ef4b240b6d) <br/>
* From the table, we have plotted the below graphs:<br/>
### GRAPH FOR WORST SETUP SLACK
![worst_setup_slack](https://github.com/user-attachments/assets/dc2facee-ec8e-4129-974e-773230040c5b)
### GRAPH FOR WORST HOLD SLACK
![worst_hold_slack](https://github.com/user-attachments/assets/29cf2a8d-0a52-40b8-bbab-f8ad9f0029a2)
From the graphs we can infer: <br/>
1) Worst setup slack - sky130_fd_sc_hd__ss_n40C_1v28 PVT Corner library file<br/>
2) Worst hold slack - sky130_fd_sc_hd__ff_100C_1v95 PVT Corner library file<br/>

## VSD WORKSHOP-ADVANCED PHYSICAL DESIGN USING OpenLANE-SKY130 
### Theory
Package: <br/>
* In any embedded board we have seen, the part of the board we consider as the chip is only the PACKAGE of the chip which is nothing but a protective layer or packet bound over the actual chip and the actual manufatured chip is usually present at the center of a package wherein, the connections from package is fed to the chip by WIRE BOUND method which is none other than basic wired connection.
![image](https://github.com/user-attachments/assets/57b0bd39-9916-4028-85cb-e20f9c507ec3)<br/>
![image](https://github.com/user-attachments/assets/16e10f23-cf48-431e-bc6d-6d69ac1137f0)<br/>
* Now, taking a look inside the chip, all the signals from the external world to the chip and vice versa is passed through PADS. The area bound by the pads is CORE where all the digital logic of the chip is placed. Both the core and pads make up the DIE which is the basic manufacturing unit in regards to semiconductor chips.
* FOUNDRY is the place where the semiconductor chips are manufactured.
ISA (Intruction Set Architecture) <br/>
* A C program which has to be run on a specific hardware layout which is the interior of a chip in your laptop, there is certain flow to be followed.
* Initially, this particular C program is compiled in it's assembly language program which is nothing but RISC-V ISA (Reduced Instruction Set Compting - V Intruction Set Architecture).
* Following this, the assembly language program is then converted to machine language program which is the binary language logic 0 and 1 which is understood by the hardware of the computer.
* Directly after this, we've to implement this RISC-V specification using some RTL (a Hardware Description Language). Finally, from the RTL to Layout it is a standard PnR or RTL to GDSII flow.
![image](https://github.com/user-attachments/assets/a737d5e9-561d-4d91-af8b-39a4bc043ad0) <br/>
* For an application software to be run on a hardware there are several processes taking place. To begin with, the apps enters into a block called system software and it converts the application program to binary language. There are 
 various layers in system software in which the major layers or components are OS (Operating System), Compiler and Assembler.
![image](https://github.com/user-attachments/assets/f4cb8c6b-030e-4737-9e93-3cdfc93c7900) <br/>
### Open Source Implementation
For open-source ASIC design implemantation, we require the following enablers to be readily available as open-source versions. They are:-
1. RTL Designs <br/>
2. EDA Tools <br/>
3. PDK Data <br/>
![image](https://github.com/user-attachments/assets/9241f680-b230-402e-ae1f-273bb651e42a) <br/>
The main objective of the ASIC Design Flow is to take the design from the RTL (Register Transfer Level) all the way to the GDSII, which is the format used for the final fabrication layout. <br/>
![image](https://github.com/user-attachments/assets/3027d708-4e74-4e5e-a8be-70928dea9bd0) <br/>
Synthesis is the process of convertion or translation of design RTL into circuits made out of Standard Cell Libraries (SCL). <br/>
![image](https://github.com/user-attachments/assets/4f6e96ac-9dfb-48c2-8563-3a84b99e7f6c) <br/>
In FloorPlanning, the chip is divided between different system blocks and I/O padding is done. Power Planning typically uses upper metal layers for power distribution since thay are thicker than lower metal layers and so have lower resistance and PP is done to avoid electron migration and IR drops. <br/>
![image](https://github.com/user-attachments/assets/c5460ab0-9ef6-4add-86d7-3f19f524b21f) <br/>
Placement refers to careful and considerate placement of cells on the chip floorplan. This is followed by CTS( Clock tree synthesis) and routing where delivering clock to all components without any jitter.
![image](https://github.com/user-attachments/assets/c75ee9ed-c542-4c57-8ea8-2d9feb50da16) <br/>
Routing refers to interconnecting the blocks. Once routing is done, it does sign off checks which are DRC(Design Rule Check), LVS (Layout Vs. Schematic) and STA(Static Timing Analysis). <br/>
![image](https://github.com/user-attachments/assets/8ff21f6a-fe55-4fb4-bf60-fbd31202a542)
### Day 1:Inception of open-source EDA, OpenLANE and Sky130 PDK
1. Run 'picorv32a' design synthesis using OpenLANE flow <br/>
We first invoke openlane from the working directory.
```
# Change directory to openlane flow directory
cd Desktop/work/tools/openlane_working_dir/openlane

# alias docker='docker run -it -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) efabless/openlane:v0.21'
# Since we have aliased the long command to 'docker' we can invoke the OpenLANE flow docker sub-system by just running this command
docker
```
![Screenshot from 2024-11-15 05-49-14](https://github.com/user-attachments/assets/03ac535a-d0c1-41f1-af62-5d19ddbc402a)
```
# Now that we have entered the OpenLANE flow contained docker sub-system we can invoke the OpenLANE flow in the Interactive mode using the following command
./flow.tcl -interactive

# Now that OpenLANE flow is open we have to input the required packages for proper functionality of the OpenLANE flow
package require openlane 0.9

# Now the OpenLANE flow is ready to run any design and initially we have to prep the design creating some necessary files and directories for running a specific design which in our case is 'picorv32a'
prep -design picorv32a

# Now that the design is prepped and ready, we can run synthesis using following command
run_synthesis

# Exit from OpenLANE flow
exit

# Exit from OpenLANE flow docker sub-system
exit
```
![Screenshot from 2024-11-15 05-49-25](https://github.com/user-attachments/assets/06ce24ad-351f-49a6-ba28-b90c8c8225e0)
![Screenshot from 2024-11-15 05-49-39](https://github.com/user-attachments/assets/dfcc7c68-346e-4edf-8e79-d1dc553bbd0f)
2. Calculation of Flop Ratio <br/>
The synthesis reports are checked and flop ratio is calculated by the formula : <br/> 
```
Flop Ratio = Number of D flip flops/ Number of total cells
Percentage = Flop Ratio * 100 
```
![Screenshot from 2024-11-15 05-49-50](https://github.com/user-attachments/assets/34084607-2cc9-49de-8728-3854484dd39a)
![Screenshot from 2024-11-15 05-49-58](https://github.com/user-attachments/assets/26548794-ea8d-4ffc-b810-39357dfe5f86)
![Screenshot from 2024-11-15 05-50-05](https://github.com/user-attachments/assets/1fcb1ce4-9cd4-4100-95c6-1d74e2b71df4)
Substituting we get, 1613/14876 = 0.1084 = 10.84%
### Day 2: Good floorplan vs bad floorplan and introduction to library cells
Here, we try to design the floorplan of the picrorv32a design using openflow. The commands are :
```
# Change directory to openlane flow directory
cd Desktop/work/tools/openlane_working_dir/openlane

# alias docker='docker run -it -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) efabless/openlane:v0.21'
# Since we have aliased the long command to 'docker' we can invoke the OpenLANE flow docker sub-system by just running this command
docker
# Now that we have entered the OpenLANE flow contained docker sub-system we can invoke the OpenLANE flow in the Interactive mode using the following command
./flow.tcl -interactive

# Now that OpenLANE flow is open we have to input the required packages for proper functionality of the OpenLANE flow
package require openlane 0.9

# Now the OpenLANE flow is ready to run any design and initially we have to prep the design creating some necessary files and directories for running a specific design which in our case is 'picorv32a'
prep -design picorv32a

# Now that the design is prepped and ready, we can run synthesis using following command
run_synthesis

# Now we can run floorplan
run_floorplan
```
![Screenshot from 2024-11-15 05-50-17](https://github.com/user-attachments/assets/fb8d37d2-4546-4391-b6c8-901852928944)
![Screenshot from 2024-11-15 05-50-27](https://github.com/user-attachments/assets/5a90470b-5e20-4e7f-b71a-8d63f064ccc2)
We then calculate the die area using:
```
Area of die in microns = Die width in microns * Die height in microns
```
![Screenshot from 2024-11-15 05-50-34](https://github.com/user-attachments/assets/48f6ff64-a70c-4cf8-97c7-6950ae3a705d)
![Screenshot from 2024-11-15 05-50-43](https://github.com/user-attachments/assets/3cf92357-68c1-49a8-ab89-7a0ebd2a9d90)
From the def file we can see,
```
1000 Unit distance = 1 micron
Die width in unit distance = 660685
Die height in unit distance = 671405
After converting into microns,
Area = 660.685 * 671.405 = 443587.212425 sq. microns
```
We can use magic tool to open and explore the floorplan.
```
# Change directory to path containing generated floorplan def
cd Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/runs/10-11_12-14/results/floorplan/

# Command to load the floorplan def in magic tool
magic -T /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def read picorv32a.floorplan.def &
```
![Screenshot from 2024-11-15 05-50-52](https://github.com/user-attachments/assets/90db1bbb-96b2-4cfe-9868-359aee17384e)
![Screenshot from 2024-11-15 05-51-02](https://github.com/user-attachments/assets/89d27af5-c089-423d-b4ba-a5addf8fabf0)
Different metal layers : <br/>
![Screenshot from 2024-11-15 05-51-14](https://github.com/user-attachments/assets/3cb33b69-3a98-4183-b17f-9b84db4d3ffd)
![Screenshot from 2024-11-15 05-51-23](https://github.com/user-attachments/assets/26ab042f-b3be-4474-a350-f318ccf70926)
Equidistant tap cells <br/>
![Screenshot from 2024-11-15 05-51-30](https://github.com/user-attachments/assets/7122c819-ada2-402f-aa92-6cb4943c6ada)
Standard Cells at the origin(unplaced) <br/>
![Screenshot from 2024-11-15 05-51-39](https://github.com/user-attachments/assets/c35c26d3-25e4-45c0-a966-42ff53cedeb5)
![Screenshot from 2024-11-15 05-51-43](https://github.com/user-attachments/assets/a572e3b4-e8a8-4ec1-8ed2-f343756b72d3)
Next we run congestion aware placement using:
```
# Congestion aware placement by default
run_placement
```
![Screenshot from 2024-11-15 05-51-51](https://github.com/user-attachments/assets/61b9a108-a81f-471f-b106-74d600622615)
![Screenshot from 2024-11-15 05-51-59](https://github.com/user-attachments/assets/71edf71b-b103-4f4e-96dd-b79efca4f358)
To explore the placement, we load in magic tool again.
```
# Change directory to path containing generated placement def
cd Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/runs/10-11_12-14/results/placement/

# Command to load the placement def in magic tool
magic -T /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def read picorv32a.placement.def &
```
![Screenshot from 2024-11-15 05-52-07](https://github.com/user-attachments/assets/94a41c25-937b-47af-b241-e07915d9553d)
![Screenshot from 2024-11-15 05-52-14](https://github.com/user-attachments/assets/e72047b1-90fa-471f-a189-d969eb344c62)
The standard cells are placed correctly now.
### Day 3: Design library cell using Magic Layout and ngspice characterization
In this lab, we will load the custom inverter layout in magic and explore. Spice extraction of inverter in magic will be done. Editing the spice model file for analysis through simulation. Analyse Post-layout ngspice simulations. Finally find DRC problems and fix them. <br/>
* Cloning the inverter
```
# Change directory to openlane
cd Desktop/work/tools/openlane_working_dir/openlane

# Clone the repository with custom inverter design
git clone https://github.com/nickson-jose/vsdstdcelldesign

# Change into repository directory
cd vsdstdcelldesign

# Copy magic tech file to the repo directory for easy access
cp /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech .

# Check contents whether everything is present
ls

# Command to open custom inverter layout in magic
magic -T sky130A.tech sky130_inv.mag &
```
![Screenshot from 2024-11-13 22-43-34](https://github.com/user-attachments/assets/e6e28eb8-c9f0-4dcd-aa9a-fe75481efc1f)
![Screenshot from 2024-11-13 22-49-15](https://github.com/user-attachments/assets/6d46377c-3757-4cd2-8a7b-5c8633ae47b5)
* We then load the custom inverter in magic for exploration. <br/>
![Screenshot from 2024-11-13 22-49-56](https://github.com/user-attachments/assets/556169e8-d7a5-4956-90b0-152f2388f153)
* We then perform spice extraction using tckon window using the following commands :
```
# Check current directory
pwd

# Extraction command to extract to .ext format
extract all

# Before converting ext to spice this command enable the parasitic extraction also
ext2spice cthresh 0 rthresh 0

# Converting to ext to spice
ext2spice
```
![Screenshot from 2024-11-13 22-53-47](https://github.com/user-attachments/assets/1440a506-e158-48fb-9d05-a0c09e057590)
* The generated file is shown below.<br/>
![Screenshot from 2024-11-13 22-54-33](https://github.com/user-attachments/assets/1f15cc74-d0eb-4d4b-9f44-c61257b4fb5b)
* The spice file has to be edited so as to be feasible for ngspice simulation. <br/>
![Screenshot from 2024-11-13 23-05-47](https://github.com/user-attachments/assets/1cb195c9-e542-414a-a8a1-dcf007053e02)
![image](https://github.com/user-attachments/assets/e3377019-3062-433d-ac62-3f8f4a0a3cda)
* Simulation is performed using ngspice commands
```
# Command to directly load spice file for simulation to ngspice
ngspice sky130_inv.spice

# Now that we have entered ngspice with the simulation spice file loaded we just have to load the plot
plot y vs time a
```
![Screenshot from 2024-11-13 23-14-35](https://github.com/user-attachments/assets/c96da838-e4f8-4d6d-bf4d-38be4a23a334)
![Screenshot from 2024-11-13 23-14-56](https://github.com/user-attachments/assets/71db5f3c-d577-44fc-95b7-fbd25bcc415b)
* Some important metrics can be calculated from the graph.
```
Rise time = Time taken for output to rise to 80% - Time taken for output to rise to 20%
Fall time = Time taken for output to fall to 20% - Time taken for output to rise to 80%
Rise Cell Delay = Time taken for output to rise to 50% - Time taken for input to fall to 50%
Fall Cell Delay = Time taken for output to fall to 50% - Time taken for input to rise to 50%

Rise time = 2.26 - 2.18 = 0.08ns
Fall time = 4.11 - 4.06 = 0.03ns
Rise Cell delay =2.23 - 2.16 = 0.07ns
Fall Cell delay = 4.1 - 4.03 = 0.07ns
```
The screenshot for how these values are obtained is shown below: <br/>
![Screenshot from 2024-11-13 23-32-41](https://github.com/user-attachments/assets/124c1ea3-36cf-4036-8ab4-51353efac06c)
* The next step is to identify DRC errors and fix them. The DRC check is done in adherence with sky130 periphery rules. The commands are shown:
```
# Change to home directory
cd

# Command to download the lab files
wget http://opencircuitdesign.com/open_pdks/archive/drc_tests.tgz

# Since lab file is compressed command to extract it
tar xfz drc_tests.tgz

# Change directory into the lab folder
cd drc_tests

# List all files and directories present in the current directory
ls -al

# Command to view .magicrc file
gvim .magicrc

# Command to open magic tool in better graphics
magic -d XR &
```
![Screenshot from 2024-11-13 23-34-17](https://github.com/user-attachments/assets/abccca70-436c-419a-b530-62c59622119e)
![Screenshot from 2024-11-13 23-46-14](https://github.com/user-attachments/assets/70db19b9-b150-4f33-bdf2-fef480872a1e)
* Once it is run, we get the following errors due to polysilicon rules. <br/>
![image](https://github.com/user-attachments/assets/ad8d7078-8e6c-4b92-922b-6edd74c82dd4) <br/>
![image](https://github.com/user-attachments/assets/5d79e435-ba55-4cab-a450-d693dd78e1db) <br/>
* The tech file is then updated to fix it. <br/>
```
# Loading updated tech file
tech load sky130A.tech

# Must re-run drc check to see updated drc errors
drc check

# Selecting region displaying the new errors and getting the error messages 
drc why
```
![image](https://github.com/user-attachments/assets/660daab5-df07-4b3f-ac6c-d53be09f628c) <br/>
### Day 4: Pre-layout timing analysis and importance of good clock tree
In this lab, we will try creating a custom inverter of our own. The commands are :
```
# Change directory to vsdstdcelldesign
cd Desktop/work/tools/openlane_working_dir/openlane/vsdstdcelldesign

# Command to open custom inverter layout in magic
magic -T sky130A.tech sky130_inv.mag &
```
![Screenshot from 2024-11-13 22-43-02](https://github.com/user-attachments/assets/b18080e1-0e9d-4145-92f4-705b5d8729d1)
* Before further procedure, we verify the track info of the design. <br/>
```
# Get syntax for grid command
help grid

# Set grid values accordingly
grid 0.46um 0.34um 0.23um 0.17um
```
![image](https://github.com/user-attachments/assets/fc94a8a5-0578-4ded-b512-3eb498e2e873) <br/>
![Screenshot from 2024-11-14 00-16-26](https://github.com/user-attachments/assets/d0be4309-f576-4411-9189-b3654a1f2e3e)
* Once done, we save it under the custom name. The name of my inverter is sky_130_arun_inv.mag.
```
# Command to save as
save sky_130_arun_inv.mag
```
![Screenshot from 2024-11-14 00-20-32](https://github.com/user-attachments/assets/cf88000b-532c-4307-abfd-0e07d1f013d7)
* We write a lef file using the tckon window.
```
# lef command
lef write
```
![Screenshot from 2024-11-14 00-25-07](https://github.com/user-attachments/assets/cb9a5372-8a46-4a62-a44c-b9cd2b82b433)
* We ensure that all files are present in our design(picorv32a) source directory.
```
# Copy lef file
cp sky_130_arun_inv.lef ~/Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/src/

# List and check whether it's copied
ls ~/Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/src/

# Copy lib files
cp libs/sky130_fd_sc_hd__* ~/Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/src/

# List and check whether it's copied
ls ~/Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/src/
```
![Screenshot from 2024-11-14 00-27-01](https://github.com/user-attachments/assets/c167e498-05f5-4818-93ea-8633b8c989bc)
* The config.tcl file is modified to include our custom inverter.
```
set ::env(LIB_SYNTH) "$::env(OPENLANE_ROOT)/designs/picorv32a/src/sky130_fd_sc_hd__typical.lib"
set ::env(LIB_FASTEST) "$::env(OPENLANE_ROOT)/designs/picorv32a/src/sky130_fd_sc_hd__fast.lib"
set ::env(LIB_SLOWEST) "$::env(OPENLANE_ROOT)/designs/picorv32a/src/sky130_fd_sc_hd__slow.lib"
set ::env(LIB_TYPICAL) "$::env(OPENLANE_ROOT)/designs/picorv32a/src/sky130_fd_sc_hd__typical.lib"

set ::env(EXTRA_LEFS) [glob $::env(OPENLANE_ROOT)/designs/$::env(DESIGN_NAME)/src/*.lef]
```
![Screenshot from 2024-11-14 00-33-20](https://github.com/user-attachments/assets/5069edd6-93b4-4029-ad6b-95cb9181736f)
* To synthesize our cell, we use openLane.
```
# Change directory to openlane flow directory
cd Desktop/work/tools/openlane_working_dir/openlane

# alias docker='docker run -it -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) efabless/openlane:v0.21'
# Since we have aliased the long command to 'docker' we can invoke the OpenLANE flow docker sub-system by just running this command
docker
# Now that we have entered the OpenLANE flow contained docker sub-system we can invoke the OpenLANE flow in the Interactive mode using the following command
./flow.tcl -interactive

# Now that OpenLANE flow is open we have to input the required packages for proper functionality of the OpenLANE flow
package require openlane 0.9

# Now the OpenLANE flow is ready to run any design and initially we have to prep the design creating some necessary files and directories for running a specific design which in our case is 'picorv32a'
prep -design picorv32a

# Adiitional commands to include newly added lef to openlane flow
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs

# Now that the design is prepped and ready, we can run synthesis using following command
run_synthesis
```
![Screenshot from 2024-11-14 00-39-09](https://github.com/user-attachments/assets/9cff3dff-7546-4478-a9d8-a079b88d4a78)
*Notice the custom cell being used. <br/>
![Screenshot from 2024-11-14 00-53-15](https://github.com/user-attachments/assets/8c05aa99-3452-4ab3-8d92-30960742b996)
* We see that slack and timing violations exist. Hence we re-run it with improved parameters. <br/>
```
# Now once again we have to prep design so as to update variables
prep -design picorv32a -tag 13-11_19-21 -overwrite

# Addiitional commands to include newly added lef to openlane flow merged.lef
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs

# Command to display current value of variable SYNTH_STRATEGY
echo $::env(SYNTH_STRATEGY)

# Command to set new value for SYNTH_STRATEGY
set ::env(SYNTH_STRATEGY) "DELAY 3"

# Command to display current value of variable SYNTH_BUFFERING to check whether it's enabled
echo $::env(SYNTH_BUFFERING)

# Command to display current value of variable SYNTH_SIZING
echo $::env(SYNTH_SIZING)

# Command to set new value for SYNTH_SIZING
set ::env(SYNTH_SIZING) 1

# Command to display current value of variable SYNTH_DRIVING_CELL to check whether it's the proper cell or not
echo $::env(SYNTH_DRIVING_CELL)

# Now that the design is prepped and ready, we can run synthesis using following command
run_synthesis
```
![Screenshot from 2024-11-14 00-56-21](https://github.com/user-attachments/assets/cceb6c3c-9fd7-469a-873f-a9814710211e)
![Screenshot from 2024-11-14 00-58-43](https://github.com/user-attachments/assets/334972f6-cf87-4778-a186-0f56faff6e48)
![Screenshot from 2024-11-14 01-00-52](https://github.com/user-attachments/assets/f1a0a3d1-6447-4f9b-96f1-bf89744bb029)
![Screenshot from 2024-11-14 01-01-48](https://github.com/user-attachments/assets/0354cf63-ffd1-488e-9526-cb03334a394f)
We achieve a good design with 0 slack so no violations. However, this comes at the cost of area.<br/>
* After synthesis, the next step is floorplanning.
```
# Now we can run floorplan
run_floorplan
```
![Screenshot from 2024-11-14 01-02-26](https://github.com/user-attachments/assets/10032b49-48a8-438f-886a-f39389dba1eb)
We face the following error due to the source not being present in the expected format. Hence, we correct it using :
```
# Follwing commands are alltogather sourced in "run_floorplan" command
init_floorplan
place_io
tap_decap_or
```
![Screenshot from 2024-11-14 01-03-18](https://github.com/user-attachments/assets/852db198-453d-4362-b143-512b91ab4cca)
![Screenshot from 2024-11-14 01-03-58](https://github.com/user-attachments/assets/4a569e54-1cb3-45d8-9fb3-f07e51a63997)
* The next step is placement.
```
# Now we are ready to run placement
run_placement
```
![Screenshot from 2024-11-14 01-04-31](https://github.com/user-attachments/assets/40171684-70c2-46db-8d60-2429e9045baf)
* Let's have a look at the generated layout in magic tool.
![Screenshot from 2024-11-14 01-07-09](https://github.com/user-attachments/assets/4338bf68-5ff2-41eb-b199-5e3bbafb35b9)
![Screenshot from 2024-11-14 01-07-19](https://github.com/user-attachments/assets/0e842aec-99c6-4e9e-964e-166d085d9ead)
* Notice that the custom cell has been used.
![Screenshot from 2024-11-14 15-58-29](https://github.com/user-attachments/assets/5483e233-abb1-40e7-8c02-5c978b7b661c)
* You can view the internal layers of cells using the expand command in tckon window. <br/>
![Screenshot from 2024-11-14 15-59-20](https://github.com/user-attachments/assets/d60c43b6-b227-4459-b29a-16a3254eb330)
* Since we have a zero slack design (after significant improvements), let us do timing analysis on initial run of synthesis which has lots of violations and no parameters were added to improve timing by the following commands:
```
# Change directory to openlane flow directory
cd Desktop/work/tools/openlane_working_dir/openlane

# alias docker='docker run -it -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) efabless/openlane:v0.21'
# Since we have aliased the long command to 'docker' we can invoke the OpenLANE flow docker sub-system by just running this command
docker

# Now that we have entered the OpenLANE flow contained docker sub-system we can invoke the OpenLANE flow in the Interactive mode using the following command
./flow.tcl -interactive

# Now that OpenLANE flow is open we have to input the required packages for proper functionality of the OpenLANE flow
package require openlane 0.9

# Now the OpenLANE flow is ready to run any design and initially we have to prep the design creating some necessary files and directories for running a specific design which in our case is 'picorv32a'
prep -design picorv32a

# Adiitional commands to include newly added lef to openlane flow
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs

# Command to set new value for SYNTH_SIZING
set ::env(SYNTH_SIZING) 1

# Now that the design is prepped and ready, we can run synthesis using following command
run_synthesis
```
![Screenshot from 2024-11-15 01-23-54](https://github.com/user-attachments/assets/ca219bbd-261b-4dcf-a7c7-7e01fee120bd)
![Screenshot from 2024-11-15 01-25-34](https://github.com/user-attachments/assets/a3090b27-90c4-4c85-9f89-1aa5854ba5bd)
* We create a .conf file for STA. <br/>
![Screenshot from 2024-11-15 01-36-41](https://github.com/user-attachments/assets/f1a4bceb-b817-4725-96f7-c31710b7c24e)
* We also create a modified .sdc file based on the already existing one in the directory for analysis.
![Screenshot from 2024-11-15 01-42-37](https://github.com/user-attachments/assets/4aea1901-eaaf-4a3d-959f-7bf9339b8a3f)
* The next step is to run Static Timing Analysis. The commands are :
```
# Change directory to openlane
cd Desktop/work/tools/openlane_working_dir/openlane

# Command to invoke OpenSTA tool with script
sta pre_sta.conf
```
![Screenshot from 2024-11-15 01-44-27](https://github.com/user-attachments/assets/1ea2bf95-995a-4aaf-a117-db94a723914b)
![Screenshot from 2024-11-15 01-50-11](https://github.com/user-attachments/assets/d1897e23-7a2f-4996-9d47-7a67c6ff6bbe)
![Screenshot from 2024-11-15 01-50-31](https://github.com/user-attachments/assets/d39ad1d3-169b-455c-9050-d19b6ac7b461)
* The issue is due to fanout. We add parameters to reduce fanout and re-synthesize the design.
```
# Now the OpenLANE flow is ready to run any design and initially we have to prep the design creating some necessary files and directories for running a specific design which in our case is 'picorv32a'
prep -design picorv32a -tag 13-11_19-52 -overwrite

# Adiitional commands to include newly added lef to openlane flow
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs

# Command to set new value for SYNTH_SIZING
set ::env(SYNTH_SIZING) 1

# Command to set new value for SYNTH_MAX_FANOUT
set ::env(SYNTH_MAX_FANOUT) 4

# Command to display current value of variable SYNTH_DRIVING_CELL to check whether it's the proper cell or not
echo $::env(SYNTH_DRIVING_CELL)

# Now that the design is prepped and ready, we can run synthesis using following command
run_synthesis
```
![Screenshot from 2024-11-15 01-52-25](https://github.com/user-attachments/assets/f8c3f440-99ee-400c-a7f7-b2249b49d5aa)
![Screenshot from 2024-11-15 01-53-46](https://github.com/user-attachments/assets/0f6f599e-e8cd-46f8-b9e1-f5b593f010bd)
![Screenshot from 2024-11-15 01-54-33](https://github.com/user-attachments/assets/5bba3185-5ba8-4d3c-8ef3-0b5ebb29619a)
![Screenshot from 2024-11-15 01-55-24](https://github.com/user-attachments/assets/20c6fb8d-843f-4927-85be-9cc0447a5fd9)
![Screenshot from 2024-11-15 01-58-29](https://github.com/user-attachments/assets/8a661ae9-930f-4440-835c-d1732d05e07c)
* We perform some ECO fixes to remove all violations. 
* OR gate of drive strength 2 is driving 4 fanouts. So it is replaced.
```
# Reports all the connections to a net
report_net -connections _11672_

# Checking command syntax
help replace_cell

# Replacing cell
replace_cell _14510_ sky130_fd_sc_hd__or3_4

# Generating custom timing report
report_checks -fields {net cap slew input_pins} -digits 4
```
![Screenshot from 2024-11-15 02-01-15](https://github.com/user-attachments/assets/2a47114e-b19e-492d-af4f-f32cbd9b6665)
The slack is reduced. <br/>
* The process is continued.
```
# Reports all the connections to a net
report_net -connections _11675_

# Replacing cell
replace_cell _14514_ sky130_fd_sc_hd__or3_4

# Generating custom timing report
report_checks -fields {net cap slew input_pins} -digits 4
```
![Screenshot from 2024-11-15 02-01-53](https://github.com/user-attachments/assets/85d3f232-8f99-48e2-b587-381eac7af677)
The slack reduces further. <br/>
* The slack reduces further on being repeated further.
![Screenshot from 2024-11-15 02-02-29](https://github.com/user-attachments/assets/e531e4e6-1d9f-4f6d-8664-5de5570c3199)
![Screenshot from 2024-11-15 02-02-29](https://github.com/user-attachments/assets/6ea89c0c-d624-451f-8020-fac3f3743095)
* We can verify the replaced instance by looking at the report.
```
# Generating custom timing report
report_checks -from _30537_ -to _30440_ -through _14481_
```
![Screenshot from 2024-11-15 02-03-30](https://github.com/user-attachments/assets/4a03d5fc-470b-4cc3-98bc-364c213a83ec)
* We eplace the old netlist with the new netlist generated after timing ECO fix and implement the floorplan, placement and CTS.
```
# Change from home directory to synthesis results directory
cd Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/runs/12-11_23-00/results/synthesis/

# List contents of the directory
ls

# Copy and rename the netlist
cp picorv32a.synthesis.v picorv32a.synthesis_old.v

# List contents of the directory
ls
```
![Screenshot from 2024-11-15 02-07-06](https://github.com/user-attachments/assets/40288a2c-784e-4081-b5a0-a85a2baa31c8)
```
# Check syntax
help write_verilog

# Overwriting current synthesis netlist
write_verilog /home/vsduser/Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/runs/12-11_23-00/results/synthesis/picorv32a.synthesis.v

# Exit from OpenSTA since timing analysis is done
exit
```
![Screenshot from 2024-11-15 02-08-51](https://github.com/user-attachments/assets/72b49528-e7fe-4683-ab14-2f66552572e6)
* We check the file to verify whether instance _14506_ is replaced with sky130_fd_sc_hd__or4_4.
![Screenshot from 2024-11-15 02-11-15](https://github.com/user-attachments/assets/46847f61-7b6c-4215-a214-7415cbdff3d7)
* We load the design for placement and routing.
```
# Now once again we have to prep design so as to update variables
prep -design picorv32a -tag 14-11_19-52 -overwrite

# Addiitional commands to include newly added lef to openlane flow merged.lef
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs

# Command to set new value for SYNTH_STRATEGY
set ::env(SYNTH_STRATEGY) "DELAY 3"

# Command to set new value for SYNTH_SIZING
set ::env(SYNTH_SIZING) 1

# Now that the design is prepped and ready, we can run synthesis using following command
run_synthesis

# Follwing commands are alltogather sourced in "run_floorplan" command
init_floorplan
place_io
tap_decap_or

# Now we are ready to run placement
run_placement

# Incase getting error
unset ::env(LIB_CTS)

# With placement done we are now ready to run CTS
run_cts
```
![Screenshot from 2024-11-15 02-13-16](https://github.com/user-attachments/assets/b6f177a6-995a-4b1b-b26d-75e73fcece45)
![Screenshot from 2024-11-15 02-13-48](https://github.com/user-attachments/assets/4a4aaab3-a53a-4d3b-b13f-9cb9f5e25ac8)
![Screenshot from 2024-11-15 02-15-05](https://github.com/user-attachments/assets/4f70dc4b-71e8-4d1a-b634-30531f959c46)
![Screenshot from 2024-11-15 02-16-07](https://github.com/user-attachments/assets/2317267a-1f61-446c-b1a8-07be7ef26ebc)
* Post CTS, we run a timing analysis using OpenRoad.
```
# Command to run OpenROAD tool
openroad

# Reading lef file
read_lef /openLANE_flow/designs/picorv32a/runs/14-11_19-52/tmp/merged.lef

# Reading def file
read_def /openLANE_flow/designs/picorv32a/runs/14-11_19-52/results/cts/picorv32a.cts.def

# Creating an OpenROAD database to work with
write_db pico_cts.db

# Loading the created database in OpenROAD
read_db pico_cts.db

# Read netlist post CTS
read_verilog /openLANE_flow/designs/picorv32a/runs/14-11_19-52/results/synthesis/picorv32a.synthesis_cts.v

# Read library for design
read_liberty $::env(LIB_SYNTH_COMPLETE)

# Link design and library
link_design picorv32a

# Read in the custom sdc we created
read_sdc /openLANE_flow/designs/picorv32a/src/my_base.sdc

# Setting all cloks as propagated clocks
set_propagated_clock [all_clocks]

# Check syntax of 'report_checks' command
help report_checks

# Generating custom timing report
report_checks -path_delay min_max -fields {slew trans net cap input_pins} -format full_clock_expanded -digits 4

# Exit to OpenLANE flow
exit
```

![Screenshot from 2024-11-15 02-20-10](https://github.com/user-attachments/assets/87b3c9ba-d8c6-480e-8c13-81d1581fe28b)
![Screenshot from 2024-11-15 02-21-19](https://github.com/user-attachments/assets/3c99b656-1259-4dfb-ac8f-2991810b35ef)
![Screenshot from 2024-11-15 02-21-33](https://github.com/user-attachments/assets/dbef3fc2-00bf-4df6-ac2c-a345b75c1fe9)
![Screenshot from 2024-11-15 02-21-43](https://github.com/user-attachments/assets/dea870fd-0a47-477e-874d-769436cf8745)
* The next step is to explore post-CTS OpenROAD timing analysis by removing 'sky130_fd_sc_hd__clkbuf_1' cell from clock buffer list variable 'CTS_CLK_BUFFER_LIST'.
```
# Checking current value of 'CTS_CLK_BUFFER_LIST'
echo $::env(CTS_CLK_BUFFER_LIST)

# Removing 'sky130_fd_sc_hd__clkbuf_1' from the list
set ::env(CTS_CLK_BUFFER_LIST) [lreplace $::env(CTS_CLK_BUFFER_LIST) 0 0]

# Checking current value of 'CTS_CLK_BUFFER_LIST'
echo $::env(CTS_CLK_BUFFER_LIST)

# Checking current value of 'CURRENT_DEF'
echo $::env(CURRENT_DEF)

# Setting def as placement def
set ::env(CURRENT_DEF) /openLANE_flow/designs/picorv32a/runs/12-11_23-00/results/placement/picorv32a.placement.def

# Run CTS again
run_cts

# Checking current value of 'CTS_CLK_BUFFER_LIST'
echo $::env(CTS_CLK_BUFFER_LIST)

# Command to run OpenROAD tool
openroad

# Reading lef file
read_lef /openLANE_flow/designs/picorv32a/runs/12-11_23-00/tmp/merged.lef

# Reading def file
read_def /openLANE_flow/designs/picorv32a/runs/12-11_23-00/results/cts/picorv32a.cts.def

# Creating an OpenROAD database to work with
write_db pico_cts1.db

# Loading the created database in OpenROAD
read_db pico_cts.db

# Read netlist post CTS
read_verilog /openLANE_flow/designs/picorv32a/runs/14-11_19-52/results/synthesis/picorv32a.synthesis_cts.v

# Read library for design
read_liberty $::env(LIB_SYNTH_COMPLETE)

# Link design and library
link_design picorv32a

# Read in the custom sdc we created
read_sdc /openLANE_flow/designs/picorv32a/src/my_base.sdc

# Setting all cloks as propagated clocks
set_propagated_clock [all_clocks]

# Generating custom timing report
report_checks -path_delay min_max -fields {slew trans net cap input_pins} -format full_clock_expanded -digits 4

# Report hold skew
report_clock_skew -hold

# Report setup skew
report_clock_skew -setup

# Exit to OpenLANE flow
exit

# Checking current value of 'CTS_CLK_BUFFER_LIST'
echo $::env(CTS_CLK_BUFFER_LIST)

# Inserting 'sky130_fd_sc_hd__clkbuf_1' to first index of list
set ::env(CTS_CLK_BUFFER_LIST) [linsert $::env(CTS_CLK_BUFFER_LIST) 0 sky130_fd_sc_hd__clkbuf_1]

# Checking current value of 'CTS_CLK_BUFFER_LIST'
echo $::env(CTS_CLK_BUFFER_LIST)
```
![image](https://github.com/user-attachments/assets/e39e286e-2051-47bc-a5ec-88718a617d2a) <br/>
![image](https://github.com/user-attachments/assets/89c6452a-d10b-4679-a4d8-b45a551388d3) <br/>

### Day 5 : Final steps for RTL2GDS using tritonRoute and openSTA
Routing is the process of establishing a physical connection between two pins. Algorithms designed for routing take source and target pins and aim to find the most efficient path between them, ensuring a valid connection exists. Two popular ones are : <br/>
1. Maze Routing <br/>
2. Lee's algorithm <br/>
The maze routing algorithm is a fundamental method used in the field of electronic design automation and computer graphics for pathfinding and routing in grid-based spaces. It seeks to find a path between two points on a grid without crossing any obstacles. The algorithm explores all possible paths from the starting point until it finds the target or exhausts all possibilities. It operates similarly to breadth-first search (BFS), ensuring an optimal path if one exists, as it explores the nearest points first before moving further out. This method guarantees finding the shortest path if the grid allows it but can be computationally intensive for large grids due to its exhaustive nature. <br/>
Lee's algorithm is a specific implementation of the maze routing algorithm designed for finding the shortest path in a grid-like structure, commonly used in VLSI design and printed circuit board (PCB) routing. It works by expanding a wavefront from the starting cell in all four cardinal directions and marking each cell with the number of steps taken from the start. This continues until the target cell is reached or all possibilities are explored. The path is traced back from the target to the start to reconstruct the optimal route. Lee's algorithm is guaranteed to find the shortest path, but it can be slow and memory-intensive, especially for large grids, due to the need to store the entire grid state during exploration. <br/>
Design Rule Checking (DRC): <br/>
DRC is a crucial step in the verification process of integrated circuit (IC) design to ensure that a circuit layout complies with a set of predefined rules. These rules are established by the semiconductor fabrication process and include constraints like minimum spacing between components, width of wires, and layer overlap requirements. DRC helps detect potential manufacturing issues that could lead to defects, ensuring that the design can be reliably produced. Automated DRC tools scan the entire layout, flagging any violations for correction. This step is essential for maintaining the integrity and functionality of the IC before moving into the fabrication phase. <br/>
Power Distribution Network generation: <br/>
Power Distribution Network (PDN) generation is a critical process in IC and PCB design, ensuring the delivery of stable and sufficient power to all parts of a circuit. The PDN consists of a network of power supply paths, including metal layers, vias, and power rails, that distribute voltage from the main power source to the components. The generation process involves careful planning to minimize voltage drops (IR drop), manage noise, and meet current density requirements. Designers use various techniques such as grid-based structures, decoupling capacitors, and power mesh optimization to enhance the reliability of the PDN. PDN generation is supported by EDA tools that analyze and simulate the network's performance to ensure that it meets power integrity standards, allowing the final design to function without power-related issues during operation. <br/>
It is not part of the standard ASIC flow. It is done after CTS and post-CTS analysis. <br/>
Routing : <br/>
Routing in the context of electronic design refers to the process of creating the electrical connections between different components on an IC or PCB. The objective is to connect pins or terminals following a netlist while ensuring that the connections do not violate any design rules, such as spacing and width constraints. The routing process is divided into global routing, which plans rough paths between components, and detailed routing, which finalizes the exact path within specific metal layers. The goal is to minimize routing length, avoid congestion, and optimize for performance metrics like signal integrity and timing.
TritonRoute: <br/>
TritonRoute is an open-source detailed routing tool used in VLSI design as part of the OpenROAD project. It is designed to handle the detailed routing phase of the physical design flow, where precise metal connections between components are created following global routing. TritonRoute ensures that all routing paths comply with design rules such as minimum spacing, wire width, and via placement set by the semiconductor fabrication process. It is capable of handling advanced technology node requirements and optimizes for objectives like minimizing routing congestion and IR drop. TritonRoute is widely used in academia and industry for its accessibility and robust capabilities, contributing to the democratization of electronic design automation (EDA). <br/>
Let us go over the lab now.
* We generate a PDN and go over the PDN layout.
```
# Change directory to openlane flow directory
cd Desktop/work/tools/openlane_working_dir/openlane

# alias docker='docker run -it -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) efabless/openlane:v0.21'
# Since we have aliased the long command to 'docker' we can invoke the OpenLANE flow docker sub-system by just running this command
docker
# Now that we have entered the OpenLANE flow contained docker sub-system we can invoke the OpenLANE flow in the Interactive mode using the following command
./flow.tcl -interactive

# Now that OpenLANE flow is open we have to input the required packages for proper functionality of the OpenLANE flow
package require openlane 0.9

# Now the OpenLANE flow is ready to run any design and initially we have to prep the design creating some necessary files and directories for running a specific design which in our case is 'picorv32a'
prep -design picorv32a

# Addiitional commands to include newly added lef to openlane flow merged.lef
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs

# Command to set new value for SYNTH_STRATEGY
set ::env(SYNTH_STRATEGY) "DELAY 3"

# Command to set new value for SYNTH_SIZING
set ::env(SYNTH_SIZING) 1

# Now that the design is prepped and ready, we can run synthesis using following command
run_synthesis

# Following commands are alltogather sourced in "run_floorplan" command
init_floorplan
place_io
tap_decap_or

# Now we are ready to run placement
run_placement

# Incase getting error
unset ::env(LIB_CTS)

# With placement done we are now ready to run CTS
run_cts

# Now that CTS is done we can do power distribution network
gen_pdn 
```
![Screenshot from 2024-11-15 02-32-27](https://github.com/user-attachments/assets/6ac21053-9f4f-4b92-992a-d5dad9e0194f)
![Screenshot from 2024-11-15 02-33-44](https://github.com/user-attachments/assets/66174b7e-ea47-4d52-99c8-29b8b50d0fb2)
![Screenshot from 2024-11-15 02-34-56](https://github.com/user-attachments/assets/c6ab5840-07e7-4174-9051-443494a890ff)
![Screenshot from 2024-11-15 02-35-37](https://github.com/user-attachments/assets/ff8f0ada-6bce-403c-99f6-78ddbd1cdfb8)
![Screenshot from 2024-11-15 02-36-44](https://github.com/user-attachments/assets/2c302f61-688d-4096-8ee2-701aeab0538a)
![Screenshot from 2024-11-15 02-37-21](https://github.com/user-attachments/assets/6b1a2271-ee7a-43d4-b83e-f5fed1026d59)
* Load the def file in another terminal and magic tool.
```
# Change directory to path containing generated PDN def
cd Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/runs/14-11_21-05/tmp/floorplan/

# Command to load the PDN def in magic tool
magic -T /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def read 14-pdn.def &
```
![Screenshot from 2024-11-15 02-38-49](https://github.com/user-attachments/assets/11c966cd-a579-4336-91c9-33240f9a98f0)
![Screenshot from 2024-11-15 02-39-28](https://github.com/user-attachments/assets/acbc0418-6f4b-469a-b9c7-407aaf8531da)
![Screenshot from 2024-11-15 02-41-01](https://github.com/user-attachments/assets/eae4ace6-1d28-4975-8e9d-e313daaa359c)
* The next step is to do routing(TrintonRoute).
```
# Check value of 'CURRENT_DEF'
echo $::env(CURRENT_DEF)

# Check value of 'ROUTING_STRATEGY'
echo $::env(ROUTING_STRATEGY)

# Command for detailed route using TritonRoute
run_routing
```
![Screenshot from 2024-11-15 02-47-54](https://github.com/user-attachments/assets/c1f12ba5-bace-42ec-bc4a-a66557c81a07)
* To view the layout,
```
# Change directory to path containing routed def
cd Desktop/work/tools/openlane_working_dir/openlane/designs/picorv32a/runs/14-11_21-05/results/routing/

# Command to load the routed def in magic tool
magic -T /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def read picorv32a.def &
```
![Screenshot from 2024-11-15 02-53-32](https://github.com/user-attachments/assets/2daeacd3-690c-4048-9afc-fc6f9a3f45b2)
![Screenshot from 2024-11-15 02-53-53](https://github.com/user-attachments/assets/d9268552-1fd0-4137-8d04-0eaafc34df7f)
![Screenshot from 2024-11-15 02-56-31](https://github.com/user-attachments/assets/08ab5c9c-635c-416c-b5aa-c3e8ab9befc2)
* Screenshot of fast route guide
![Screenshot from 2024-11-15 02-58-24](https://github.com/user-attachments/assets/5376e4d8-9ccc-4ed2-a6a8-f224bcf0897f)
* Post-Routing, we perform OpenSTA timing analysis with the extracted parasitics of the route.
```
# Command to run OpenROAD tool
openroad

# Reading lef file
read_lef /openLANE_flow/designs/picorv32a/runs/14-11_21-05/tmp/merged.lef

# Reading def file
read_def /openLANE_flow/designs/picorv32a/runs/14-11_21-05/results/routing/picorv32a.def

# Creating an OpenROAD database to work with
write_db pico_route.db

# Loading the created database in OpenROAD
read_db pico_route.db

# Read netlist post CTS
read_verilog /openLANE_flow/designs/picorv32a/runs/14-11_21-05/results/synthesis/picorv32a.synthesis_preroute.v

# Read library for design
read_liberty $::env(LIB_SYNTH_COMPLETE)

# Link design and library
link_design picorv32a

# Read in the custom sdc we created
read_sdc /openLANE_flow/designs/picorv32a/src/my_base.sdc

# Setting all cloks as propagated clocks
set_propagated_clock [all_clocks]

# Read SPEF
read_spef /openLANE_flow/designs/picorv32a/runs/14-11_21-05/results/routing/picorv32a.spef

# Generating custom timing report
report_checks -path_delay min_max -fields {slew trans net cap input_pins} -format full_clock_expanded -digits 4

# Exit to OpenLANE flow
exit
```
![Screenshot from 2024-11-15 03-08-26](https://github.com/user-attachments/assets/f8e36187-bd18-4dd1-b7e5-3d31b7a3a7bf)
![Screenshot from 2024-11-15 03-11-36](https://github.com/user-attachments/assets/5d902082-67fa-4ee5-acce-0c916a3ed5dd)
![Screenshot from 2024-11-15 03-12-15](https://github.com/user-attachments/assets/a9d029ee-787b-47ff-bf3c-bf9465f35a1d)
![Screenshot from 2024-11-15 03-12-20](https://github.com/user-attachments/assets/2b1a30d7-db7c-4205-b570-31fbc2097b87)
## OPENROAD PHYSICAL DESIGN-VSDBABYSOC
In this section, we deal with performing the physical design flow using OpenRoad Flow Scripts on our local machine. This is done with reference to the workshop enabled at 'vsdiat.com' titled "OPENROAD PHYSICAL DESIGN CONTEST". It has the nine sections as follows: <br/>
### Section 1:Latest developments in CMOS technology and its Implications on Circuits design <br/>
The path to Zetta computing was born out of need and necessity. <br/>
* The Bombe was an electro-mechanical machine designed during World War II to decrypt German Enigma-encrypted messages. It was refined and built by Alan Turing and Gordon Welchman at Bletchley Park, UK. The Bombe systematically tested possible rotor settings of the Enigma machine by exploiting known plaintext patterns. Its logical operations helped narrow down the vast number of possible keys, significantly accelerating the decryption process.
* ENIAC was developed during World War II by John Presper Eckert and John Mauchly at the University of Pennsylvania, was the first general-purpose, fully electronic digital computer. Completed in 1945, it was designed to compute artillery firing tables for the U.S. Army. ENIAC used vacuum tubes instead of mechanical or electromechanical components. However, it lacked a stored-program capability, requiring manual reconfiguration for each new task.
* EDVAC, also developed by Eckert and Mauchly with conceptual input from John von Neumann, was one of the first computers to implement the stored-program concept. Completed in 1949, EDVAC represented a significant improvement over ENIAC by using binary representation instead of decimal and storing both data and instructions in memory. This innovation simplified programming and laid the groundwork for the modern von Neumann architecture.<br/>
The trend is shown below:<br/>
![image](https://github.com/user-attachments/assets/fae1f640-944a-424d-b65d-344cbc89b4bb)<br/>
It can be noted that: <br/>
* Transistors (Orange): The number of transistors on a microprocessor chip (in thousands) has increased exponentially, following Moore's Law, which predicts a doubling approximately every two years. This growth enabled more complex and capable processors, reaching the range of billions of transistors by the 2020s.
* Single-Thread Performance (Blue): It is measured using SpecINT. It indicates the computational ability of a single processor core. Performance grew steadily due to improvements in architecture, instruction-level parallelism, and clock speeds, but the growth rate slowed post-2005 due to physical limitations like power and heat.
* Frequency (Green): Processor clock speed (in MHz) rose steadily until the early 2000s but then stagnated as increasing clock speeds became inefficient due to heat dissipation issues.
* Typical Power (Red): Power consumption increased with transistor density and frequency, becoming a critical design challenge around the mid-2000s.
* Number of Logical Cores (Black): The transition to multi-core processors gained momentum in the mid-2000s as a response to the stagnation in single-thread performance. By increasing the number of cores, processors enabled more efficient parallel processing, leading to significant improvements in overall performance. <br/>
![image](https://github.com/user-attachments/assets/15b586f5-142d-4b1f-846f-0b24ecbe1047)<br/>
As illustrated, the trend goes as Gigascale (10⁹ FLOPS),Terascale (10¹² FLOPS),Petascale (10¹⁵ FLOPS),Exascale (10¹⁸ FLOPS),Zettascale (10²¹ FLOPS). <br/>
![image](https://github.com/user-attachments/assets/b32325e2-6f1e-4171-a564-405e5e633bbf)<br/>
The above diagram shows the evolving landscape of CMOS (Complementary Metal-Oxide-Semiconductor) technology and highlights emerging materials, structures, and processes being explored for next-generation semiconductor devices.
* Silicon (Si) is the primary material used for the channel in traditional CMOS transistors, with strained SiGe (Silicon-Germanium) being used in some high-performance applications to enhance carrier mobility. 2D materials such as MoS₂ (Molybdenum Disulfide) are being explored due to their potential for better electrical characteristics at smaller scales.Germanium (Ge) is gaining interest as it offers higher electron mobility, which could significantly boost transistor performance at small nodes.
* Deep Ultraviolet (DUV) lithography is the most commonly used technique for defining transistor features, with ArF (Argon Fluoride) and KrF (Krypton Fluoride) lasers operating at different wavelengths.Extreme Ultraviolet (EUV) lithography is expected to be a key technology for sub-7nm nodes. High-NA (Numerical Aperture) EUV will further improve the resolution for even smaller transistor nodes, pushing the boundaries of Moore's Law.
* High-K metal gates (HKMG) are used in the gate stack of modern FETs to reduce gate leakage current and improve switching performance.NC-FET (Negative Capacitance FET): This is a promising transistor design that leverages ferroelectric materials to reduce power consumption by enabling lower voltage operation.TFET (Tunnel FET): TFETs use quantum tunneling to switch on and off, offering a significant reduction in power consumption compared to conventional FETs, especially for low-power applications.
* Copper (Cu) is the primary material used for interconnects due to its low resistivity, which helps in minimizing power loss and delays in transistor connections.Ruthenium (Ru) and Compound metals are being investigated for their potential to reduce resistance and improve performance in ultra-small transistors.Topological semi-metals may offer unique properties, such as lower resistivity and increased performance at the atomic scale.
* FinFET and planar transistors are used to maintain performance at smaller nodes. FinFETs, in particular, help improve control over short-channel effects by using a 3D structure.3DS-FET (3D Stacked FET): These are three-dimensional transistors where multiple layers of devices are stacked vertically, reducing footprint and improving performance.MBC-FET (Multi-Bridge Channel FET): This structure aims to enhance drive current by creating multiple channels within the same device.VFET (Vertical FET): VFETs utilize vertical channels to improve density and reduce power consumption.
* DTCO (Design-Technology Co-Optimization) focuses on integrating new design techniques with advanced process technologies to maximize chip performance, often involving backside interconnects (BSI), where interconnections are made at the back of the wafer for improved signal integrity and reduced latency.
* STCO (System-Technology Co-Optimization) nvolves optimizing both the system architecture and the underlying technology. One example is the use of chiplets, which allow for modular, customized designs by integrating multiple smaller chips into one package, offering flexibility and reducing the complexity of scaling single-chip designs.
### FINFETS
![image](https://github.com/user-attachments/assets/d4ba6f03-cb1d-443c-b8f1-5097b56f9aa2)<br/>
* Planar Transistor (Traditional): Early transistor design with a flat channel and gate structure.The gate controls the channel from one side only, leading to limited performance as scaling continues.Sub-channel leakage occurs where current leaks underneath the gate.Results in reduced efficiency.Increases power consumption.
* FinFET: The channel is shaped like a vertical fin, allowing the gate to wrap around three sides of the channel.Provides better control over the channel, reducing leakage and improving performance at smaller sizes. The gate wraps around the channel (fin) on three sides, providing better control over the channel. Reduces sub-threshold leakage.Enhances drive current.Allows a smaller transistor area while maintaining high performance.
* A possible improvement to FinFETs in the near future would be Gate-All-Around (GAA) Transistors where The gate completely surrounds the channel, offering superior electrostatic control.<br/>
Below shown is a comparison of Circuit Performance.<br/>
![image](https://github.com/user-attachments/assets/d0a3a05b-cad2-4056-9cda-8e0eeeb1ca67)<br/>
### CMOS INNOVATIONS
![image](https://github.com/user-attachments/assets/e0ec98ef-c3a7-46e0-b09a-60477fdb16eb)<br/>
The trend is as follows: <br/>
* 180 nm (Voltage Scaling): Start of drive voltage reduction.
* 130 nm (Cu BEOL): Introduction of copper interconnects for better conductivity.
* 90 nm (Uniaxial Strained Si NMOS): Strained silicon enhances electron mobility.
* 65 nm (eSiGe CVD ULK): Embedded SiGe improves PMOS performance.
* 45 nm (HK-first MG-last): High-k dielectrics and metal gates reduce leakage and improve gate control.
* 32 nm (HKMG with Raised S/D NMOS): Advanced HKMG implementation and raised source/drain regions.
* 22 nm: Introduction of FinFET (Tri-Gate) transistors, which reduce leakage and improve gate control.Use of self-aligned contacts (SAC) and copper interconnects (Co+Cu BEOL).
* 14 nm: Transition to unidirectional metal routing for better density. Implementation of SADP (Self-Aligned Double Patterning) and SDB (Single Diffusion Break) for precise layout.
* 10 nm: Adoption of advanced patterning techniques such as SA-SDB (Self-Aligned SDB),LELELE (Litho-Etch-Litho-Etch-Litho-Etch),SAQP (Self-Aligned Quadruple Patterning) for tighter geometries.
* 7 nm: Introduction of Extreme Ultraviolet Lithography (EUV) to simplify the patterning process and reduce overlay errors.
* 5 nm: Integration of SiGe (Silicon-Germanium) channels for PMOS to enhance hole mobility.Use of EUV SA-LELE (Self-Aligned Litho-Etch-Litho-Etch).
* 3 nm / 2 nm / 1.4 nm: Transition to Gate-All-Around (GAA) nanosheet transistors for improved electrostatic control.GAA stacks nanosheets or nanowires horizontally to maximize current drive.
* ~ 1 nm: Development of CFET (Complementary FET), which vertically stacks NMOS over PMOS to save area. Use of 2D materials, such as MoS₂, for atomic-scale channel thickness in 2D FETs.
### PARASITIC RESISTANCE <br/>
![image](https://github.com/user-attachments/assets/793d0bfe-2544-422b-8ba8-717d5324b6ab)
Parasitic resistance refers to the unintended or "extra" resistance that arises in an electrical circuit due to the physical properties of the materials, layout, and components involved, but is not part of the intentional design. It is an inherent characteristic in real-world circuits, especially in high-speed digital or analog systems, and is caused by the non-ideal behavior of conductive materials, such as metals and semiconductors.
<br/>
Components of Parasitic Resistance ((R_{EXT})) : <br/>
* (R_{CA-BEOL}): Resistance from the contact in the Back-End-Of-Line (BEOL).
* (R_{CA}): Resistance at the contact area.
* (R_{CA-TS}): Resistance at the contact to the transition structure.
* (R_{TS}): Resistance in the transition structure.
* (R_{MOL}): Middle-Of-Line resistance (includes lateral and vertical contributions).
* (R_C): Contact resistance at the metal-semiconductor interface.
* (R_{EPI}): Epitaxial layer resistance (contributes to current spreading).
* (R_{FEOL}): Front-End-Of-Line resistance from the source/drain extensions. <br/>
In the diagram below, the contribution is shown for both NFETS and PFETS along with the equation. <br/>
![image](https://github.com/user-attachments/assets/6abe6400-8e2b-44fe-9c29-c8dd3ee3d17c)<br/>
### PARASITIC CAPACITANCE <br/>
Parasitic capacitance refers to the unintended or unwanted capacitance that arises between conductors or components in a circuit due to their physical proximity and their electrical properties. It is an inherent characteristic of real-world electrical circuits and can significantly affect the performance of high-speed or high-frequency circuits. <br/>
![image](https://github.com/user-attachments/assets/346f6626-e75e-4776-b1e7-9675ad5979a9) <br/>
The diagram shows the main contributors in each technology node. The first scatter plot shows a reduction in normalized delay for a ring oscillator when using SiBCN spacers instead of SiN spacers, indicating improved performance. The second scatter plot demonstrates an 8% reduction in (C_{eff}) with SiBCN spacers, which corresponds to the delay improvement observed in the first plot. It also shows the evolution of spacer materials.
### TRANSISTOR SCALING <br/>
To achieve smaller gate lengths, devices must address various physical and material constraints to ensure reliable operation. However some major challenges exist like :<br/>
* Direct Source-to-Drain Tunneling: As the gate length decreases, electrons can tunnel directly from the source to the drain, bypassing the gate control. To mitigate this, materials with a high effective mass are needed.
* Surface Roughness and Thickness Variations: Variability at atomic scales can cause performance issues. Uniform, atomically thin materials are essential for minimizing such variations.
* Capacitance Ratios (( C_D ) and ( C_{ox} )): The capacitance of the depletion region (( C_D )) must remain low relative to the gate oxide capacitance (( C_{ox} )) to improve gate control. Materials with a low in-plane dielectric constant (( \epsilon )) are necessary for this.
### Direct Source-to-Drain Tunneling <br/>
Direct Source-to-Drain Tunneling (DSDT) refers to a phenomenon that occurs in Field-Effect Transistors (FETs), particularly in n-channel or p-channel MOSFETs at small feature sizes (such as in advanced technology nodes of semiconductors, e.g., 7nm, 5nm, and below). It describes a quantum mechanical effect where electrons or holes tunnel directly from the source to the drain of the transistor, bypassing the channel between them.
This effect becomes more pronounced as the transistor's gate length shrinks and the oxide layer (the insulating material between the gate and the channel) becomes thinner, allowing the quantum tunneling effect to occur more easily. <br/>
![image](https://github.com/user-attachments/assets/d5b06a3d-4276-489e-a639-ed25685fdd5c) <br/>
### Body- Bias Effect <br/>
The body-bias effect (also known as bulk-bias effect) refers to the influence of the bias voltage applied to the body (or substrate) of a Field-Effect Transistor (FET) on its threshold voltage (V_th) and overall electrical characteristics. This effect is particularly relevant in MOSFETs (Metal-Oxide-Semiconductor Field-Effect Transistors), including n-channel (NMOS) and p-channel (PMOS) devices. The body-bias effect is a key aspect of modern transistor design and is widely used in techniques such as dynamic voltage scaling and power management. <br/>
![image](https://github.com/user-attachments/assets/092e8da2-5728-4044-9387-b345ca94b060) <br/>
### LEVELS OF MOSFETS
* A MoS₂ (Molybdenum Disulfide) transistor with a 1 nm gate represents a promising development in the field of semiconductor technology, leveraging the unique properties of 2D materials for ultra-scaled devices. MoS₂ is known for its high electron mobility, direct bandgap, and scalability, making it an ideal candidate for high-speed and low-power electronics. However, as the gate length shrinks to 1 nm, several challenges arise, including short-channel effects, quantum tunneling, and increased leakage currents. The ultra-thin nature of MoS₂ allows for precise control over the channel, reducing threshold voltages and improving power efficiency, but the small gate length can lead to a degradation in electrostatic control over the channel, increasing the likelihood of drain-induced barrier lowering (DIBL) and subthreshold swing issues. Additionally, gate leakage becomes a concern due to quantum tunneling, especially with ultra-thin gate dielectrics. To overcome these challenges, innovative approaches such as high-k dielectrics, multi-gate or Gate-All-Around (GAA) structures, and better contact engineering are necessary to ensure efficient transistor performance. Despite these hurdles, MoS₂’s potential for low-power, high-performance electronics at the atomic scale makes it an exciting material for the next generation of transistors. <br/>
![image](https://github.com/user-attachments/assets/bf408c12-6b3b-43fb-94a0-cc9bc6f8e214)
* An All-2D MOSFET represents an advanced concept in semiconductor technology, where the transistor is entirely constructed from two-dimensional (2D) materials, including the channel, gate, and dielectric layers. This approach takes advantage of the unique properties of 2D materials like graphene, MoS₂ (Molybdenum Disulfide), and other transition metal dichalcogenides (TMDs), which exhibit exceptional electronic, optical, and mechanical characteristics at the atomic scale. In an All-2D MOSFET, the channel material, typically MoS₂ or similar materials, is just one or a few atoms thick, allowing for extreme miniaturization and reduced short-channel effects compared to traditional silicon-based MOSFETs. These materials offer high carrier mobility, low power consumption, and the potential for direct bandgap behavior that can be tuned for specific applications, such as optoelectronics and low-power digital logic circuits.However, building a fully 2D MOSFET presents significant challenges. One of the main difficulties lies in scaling the gate dielectric to maintain good electrostatic control over the extremely thin channel, which becomes problematic as the gate length approaches the atomic scale. Additionally, issues like contact resistance between 2D materials and metal electrodes, quantum tunneling, and gate leakage become more pronounced in devices with sub-nanometer scale gates. To overcome these challenges, the development of high-k dielectric materials, multi-gate architectures, and advanced 2D material synthesis techniques is essential. Despite these hurdles, All-2D MOSFETs hold great promise for future electronics, particularly in high-performance, low-power applications where the inherent properties of 2D materials can be fully exploited. <br/>
![image](https://github.com/user-attachments/assets/97d6e0af-78ed-4b96-a77d-70499b680f2f)
* Transistor-level Monolithic 3D (M3D) technology involves stacking multiple layers of active transistors within a single chip to create a three-dimensional integrated circuit. This approach significantly increases transistor density by arranging transistors vertically, reducing the footprint and enabling compact, high-performance devices. By minimizing the interconnect length between transistors, monolithic 3D can also enhance signal speed and reduce power consumption, making it a promising solution for next-generation electronics. The technology enables heterogeneous integration, where different materials and device types, such as logic, memory, and sensors, can be combined in a single stack, offering a high degree of functionality in a small space. However, challenges like effective thermal management, the need for precise through-silicon vias (TSVs) to connect layers, and maintaining high yields in complex fabrication processes must be addressed for large-scale adoption. Despite these challenges, monolithic 3D transistors hold the potential to revolutionize fields such as high-performance computing, mobile devices, and AI applications, providing both increased performance and energy efficiency. <br/>
![image](https://github.com/user-attachments/assets/6e1a2ac0-75ef-436f-816c-428cd7836d3f)
### Back-Side Power Delivery Network (BS-PDN)
The Back-Side Power Delivery Network (BS-PDN) is an innovative power distribution method used in advanced integrated circuit (IC) designs, particularly in 3D ICs and stacked die configurations. Unlike traditional power delivery networks that route power on the front side of the chip, the BS-PDN moves the power distribution to the back of the chip. This approach offers several benefits, including improved power delivery efficiency, reduced signal routing congestion, and better thermal management. By freeing up space on the front side of the chip for signal traces, the BS-PDN helps optimize routing and minimizes interconnect resistance, which can improve overall performance. Additionally, in 3D stacked ICs, the back-side PDN reduces the complexity of power delivery between multiple layers and enhances heat dissipation, helping to prevent overheating of the upper layers. However, incorporating a BS-PDN into chip designs increases manufacturing complexity and requires precise alignment and integration techniques. Despite these challenges, the BS-PDN is becoming an essential strategy for improving power efficiency and performance in modern semiconductor devices. <br/>
![image](https://github.com/user-attachments/assets/64f9c70c-9f3f-42a6-9d75-53e35ef22c8d) <br/>
### Section 2: Tools Installation
* The commands to install openroad is shown below: <br/>
```
git clone https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts
cd OpenROAD-flow-scripts
sudo ./setup.sh
```
![image](https://github.com/user-attachments/assets/56dab5ca-f4e6-48a3-b3b7-c30ff3a3876f)
![image](https://github.com/user-attachments/assets/b357e5d7-0e69-433c-92e3-49f685eb8eb6)
![image](https://github.com/user-attachments/assets/318693fc-d09c-473d-8508-55034f9490c7)
```
./build_openroad.sh --local
```
![image](https://github.com/user-attachments/assets/099b5026-3554-4d70-8ff2-017b40c7036d)
* To verify the setup, use the following commands:
```
source ./env.sh
yosys -help
openroad -help
cd flow
make
```
![Screenshot from 2024-11-22 21-45-35](https://github.com/user-attachments/assets/8876ea22-3377-4082-8056-9f9382c98587)
![Screenshot from 2024-11-22 21-45-59](https://github.com/user-attachments/assets/b72d79b0-801a-4f1b-8cbc-24dd4f514c63)
```
make gui_final
```
![Screenshot from 2024-11-22 21-46-27](https://github.com/user-attachments/assets/a09f240b-f295-47b1-8a2a-9163b2117417)
![Screenshot from 2024-11-22 21-46-36](https://github.com/user-attachments/assets/d5d66884-b3e3-4c37-8ebd-8501d7c5d9e3)
### Section 3: Flow Structure
The OpenROAD Directory Structure and File formats is shown below.
```
├── OpenROAD-flow-scripts             
│   ├── docker           -> It has Docker based installation, run scripts and all saved here
│   ├── docs             -> Documentation for OpenROAD or its flow scripts.  
│   ├── flow             -> Files related to run RTL to GDS flow  
|   ├── jenkins          -> It contains the regression test designed for each build update
│   ├── tools            -> It contains all the required tools to run RTL to GDS flow
│   ├── etc              -> Has the dependency installer script and other things
│   ├── setup_env.sh     -> Its the source file to source all our OpenROAD rules to run the RTL to GDS flow
```
```
├── flow           
│   ├── design           -> It has built-in examples from RTL to GDS flow across different technology nodes
│   ├── makefile         -> The automated flow runs through makefile setup
│   ├── platform         -> It has different technology note libraries, lef files, GDS etc 
|   ├── tutorials        
│   ├── util            
│   ├── scripts
```
![Screenshot from 2024-11-23 19-36-41](https://github.com/user-attachments/assets/903db259-1c52-41ff-84ba-d216eb939737)
### Section 4: Automated RTL2GDS Flow for VSDBabySoC
* We need to create a directory vsdbabysoc inside OpenROAD-flow-scripts/flow/designs/sky130hd
* Now copy the folders gds, include, lef and lib from the VSDBabySoC folder in your system into this directory.
* The gds folder would contain the files avsddac.gds and avsdpll.gds
* The include folder would contain the files sandpiper.vh, sandpiper_gen.vh, sp_default.vh and sp_verilog.vh
* The lef folder would contain the files avsddac.lef and avsdpll.lef
* The Additional lib folder would contain the files avsddac.lib and avsdpll.lib
* Now copy the constraints file(vsdbabysoc_synthesis.sdc).
* Now copy the files(macro.cfg and pin_order.cfg). <br/>
![image](https://github.com/user-attachments/assets/ffe15523-7740-4e66-8677-5577cfae1501) <br/>
![image](https://github.com/user-attachments/assets/7d78050c-ac01-4a26-bf96-6da65ec6539c) <br/>
The macro.cfg is shown below: <br/>
![image](https://github.com/user-attachments/assets/bff3ce86-7cf2-4977-93da-ad8383c63ded) <br/>
The pin_order.cfg is shown below:<br/>
![image](https://github.com/user-attachments/assets/01b6d853-feb6-4bf5-bf71-91cda5cdb9a4) <br/>
### Section 5 & Section 6: OpenROAD GUI. Macro Placement RTL MP and QOR.
We run the same flow for the default design: GCD.
```
make DESIGN_CONFIG=./designs/nangate45/gcd/config.mk
make gui_floorplan
make gui_place
make gui_cts
make gui_route
make gui_final
# or we can open the gui file and their we select the .odb file going through the results folder of nangate45 platform
source ./env.sh # go to the OpenROAD directory then run this command then below command
openroad -gui
make metadata
gedit designs/nangate45/gcd/metadata-base-ok.json
```
![image](https://github.com/user-attachments/assets/0b26dad5-eec3-4679-860b-901d6ae0192e)
![image](https://github.com/user-attachments/assets/61eb0273-535c-4685-8ba0-501202a42f08) <br/>
* The following commands are run:<br/>
![image](https://github.com/user-attachments/assets/066e2f9b-cdff-466f-bf44-0b345d9d277f)<br/>
### Heatmap: <br/>
![image](https://github.com/user-attachments/assets/53667428-37f0-488b-97c8-f0cc570c006a) <br/>
### Routing: <br/>
![image](https://github.com/user-attachments/assets/da729cee-8710-42ea-95c1-75df695648f2) <br/>
### CTS: <br/>
![image](https://github.com/user-attachments/assets/17e44250-9765-48d3-bb4f-1c56be3560d5) <br/>
* The final output in Klayout is : <br/>
![image](https://github.com/user-attachments/assets/e895fba8-15c2-4c34-83f2-f45e26ba3898)<br/>
## OpenRoad Flow Scripts: VSDbabySoC
In this section,we execute the same flow for our VSDbabysoc that was designed in earlier labs.
* We create a directory vsdbabysoc inside OpenROAD-flow-scripts/flow/designs/sky130hd
* Now copy the folders gds, include, lef and lib from the VSDBabySoC folder in your system into this directory. - The gds folder would contain the files avsddac.gds and avsdpll.gds - The include folder would contain the files sandpiper.vh, sandpiper_gen.vh, sp_default.vh and sp_verilog.vh - The gds folder would contain the files avsddac.lef and avsdpll.lef - The lib folder would contain the files avsddac.lib and avsdpll.lib
* Copy the constraints file(vsdbabysoc_synthesis.sdc) from the VSDBabySoC folder in your system into this directory.
* Copy the files(macro.cfg and pin_order.cfg) from the VSDBabySoC folder in your system into this directory.
* Create a macro.cfg file whose contents are shown below:
```
avsdpll 200 1200 N
avsddac 200 0 N
```
* Configuration file is shown below:
```
export DESIGN_NICKNAME = VSDbabysoc
export DESIGN_NAME = vsdbabysoc
export PLATFORM    = sky130hd
export VSDbabysoc_DIR = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)

#export VERILOG_FILES_BLACKBOX = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/*.v
export VERILOG_FILES =  $(sort $(wildcard $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/IPs/*.v \
	 $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/vsdbabysoc.v \
	 ))
	 
export VERILOG_INCLUDE_DIRS = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/include
export SDC_FILE      = $(wildcard $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraints.sdc)
export ADDITIONAL_LEFS = $(wildcard $(VSDbabysoc_DIR)/avsddac.lef) \
			$(wildcard $(VSDbabysoc_DIR)/avsdpll.lef)
export ADDITIONAL_LIBS = $(wildcard $(VSDbabysoc_DIR)/lib/*.lib)
export ADDITIONAL_GDS  = $(wildcard $(VSDbabysoc_DIR)/gds)

export PLACE_OPT_CONGESTION_DRIVEN = 1

#export FP_PIN_ORDER_CFG = $(wildcard $ (VSDbabysoc_DIR)/pin_order.cfg)
export FP_SIZING = absolute
export DIE_AREA = 0 0 3000 3000
export CORE_AREA = 50 50 2900 2900

export global_pins_spacing = 20


#export BOTTOM_MARGIN_MULT = 50
#export TOP_MARGIN_MULT = 50
#export LEFT_MARGIN_MULT = 200
#export RIGHT_MARGIN_MULT = 200


export MACRO_PLACEMENT = $(VSDbabysoc_DIR)/macro.cfg

 export RTLMP_BOUNDARY_WT = 0
 #export MACRO_PLACE_HALO = 200 200
 export MACRO_PLACE_CHANNEL = 250 250
 export avsddac_place_halo  = 20 20 20 20
 export avsdpll_place_halo  = 20 20 20 20
 export riscv_pri_routing_halo = 10 10 10 10

#export CORE_UTILIZATION = 30
export PLACE_DENSITY_LB_ADDON = 0.1

export REMOVE_ABC_BUFFERS = 1
```
* With reference to the workshop, we have used a similar script that automates the entire flow with a single command.
```
source ./env.sh
cd flow
make
```
![Screenshot from 2024-11-26 02-42-27](https://github.com/user-attachments/assets/79d8430a-ca88-4669-8499-6a75b5dd4ece)
**Note: The reports generated during the flow is attached to this repo. Below are just sample screenshots. The entire .rpt file is attached to the repo as files**
### Synthesis report:
![image](https://github.com/user-attachments/assets/f5875386-a8dd-4131-a28c-e2c1b80c0911)
![image](https://github.com/user-attachments/assets/8d086cba-3770-406a-b5d3-1471158f0bc7)
```

24. Printing statistics.

=== vsdbabysoc ===

   Number of wires:               7221
   Number of wire bits:           7221
   Number of public wires:        1416
   Number of public wire bits:    1416
   Number of ports:                  7
   Number of port bits:              7
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:               7077
     avsddac                         1
     avsdpll                         1
     sky130_fd_sc_hd__a2111oi_0     15
     sky130_fd_sc_hd__a2111oi_1      1
     sky130_fd_sc_hd__a2111oi_2      2
     sky130_fd_sc_hd__a211oi_1      20
     sky130_fd_sc_hd__a211oi_2       3
     sky130_fd_sc_hd__a21bo_2        1
     sky130_fd_sc_hd__a21boi_0       8
     sky130_fd_sc_hd__a21boi_2       1
     sky130_fd_sc_hd__a21o_1        30
     sky130_fd_sc_hd__a21oi_1      814
     sky130_fd_sc_hd__a221o_1        3
     sky130_fd_sc_hd__a221oi_1     101
     sky130_fd_sc_hd__a22o_1        95
     sky130_fd_sc_hd__a22oi_1      517
     sky130_fd_sc_hd__a311oi_1      41
     sky130_fd_sc_hd__a311oi_2       9
     sky130_fd_sc_hd__a31o_2         2
     sky130_fd_sc_hd__a31oi_1       18
     sky130_fd_sc_hd__a31oi_2        1
     sky130_fd_sc_hd__a32o_1         2
     sky130_fd_sc_hd__a41oi_1        2
     sky130_fd_sc_hd__and2_0         1
     sky130_fd_sc_hd__and2_1        12
     sky130_fd_sc_hd__and3_1        24
     sky130_fd_sc_hd__and3b_1        2
     sky130_fd_sc_hd__and4_1         2
     sky130_fd_sc_hd__buf_1         49
     sky130_fd_sc_hd__buf_2         10
     sky130_fd_sc_hd__buf_6          2
     sky130_fd_sc_hd__clkbuf_1     599
     sky130_fd_sc_hd__clkbuf_2       2
     sky130_fd_sc_hd__conb_1         1
     sky130_fd_sc_hd__dfxtp_1     1274
     sky130_fd_sc_hd__fa_1           3
     sky130_fd_sc_hd__ha_1         135
     sky130_fd_sc_hd__inv_1        110
     sky130_fd_sc_hd__mux2_2         2
     sky130_fd_sc_hd__mux2i_1       27
     sky130_fd_sc_hd__nand2_1     1407
     sky130_fd_sc_hd__nand2b_1      30
     sky130_fd_sc_hd__nand3_1      333
     sky130_fd_sc_hd__nand3b_1      38
     sky130_fd_sc_hd__nand4_1      120
     sky130_fd_sc_hd__nor2_1       319
     sky130_fd_sc_hd__nor2b_1       55
     sky130_fd_sc_hd__nor3_1        69
     sky130_fd_sc_hd__nor3b_1        7
     sky130_fd_sc_hd__nor4_1        34
     sky130_fd_sc_hd__nor4b_1        2
     sky130_fd_sc_hd__nor4bb_1       1
     sky130_fd_sc_hd__o2111a_1       2
     sky130_fd_sc_hd__o2111ai_1      3
     sky130_fd_sc_hd__o211a_1        3
     sky130_fd_sc_hd__o211ai_1      36
     sky130_fd_sc_hd__o211ai_2       1
     sky130_fd_sc_hd__o21a_1         5
     sky130_fd_sc_hd__o21ai_0      354
     sky130_fd_sc_hd__o21ai_1        9
     sky130_fd_sc_hd__o21ba_2        1
     sky130_fd_sc_hd__o21bai_1      25
     sky130_fd_sc_hd__o221a_2        1
     sky130_fd_sc_hd__o221ai_1      33
     sky130_fd_sc_hd__o22a_1        36
     sky130_fd_sc_hd__o22ai_1       73
     sky130_fd_sc_hd__o2bb2ai_1      1
     sky130_fd_sc_hd__o311a_1        2
     sky130_fd_sc_hd__o311ai_0       3
     sky130_fd_sc_hd__o311ai_1       3
     sky130_fd_sc_hd__o311ai_4       2
     sky130_fd_sc_hd__o31a_1         2
     sky130_fd_sc_hd__o31ai_1       34
     sky130_fd_sc_hd__o31ai_2        1
     sky130_fd_sc_hd__o32ai_1        1
     sky130_fd_sc_hd__or2_2         10
     sky130_fd_sc_hd__or3_1         20
     sky130_fd_sc_hd__or4_1         10
     sky130_fd_sc_hd__or4_4          2
     sky130_fd_sc_hd__xnor2_1       39
     sky130_fd_sc_hd__xor2_1         7

   Area for cell type \avsddac is unknown!
   Area for cell type \avsdpll is unknown!

   Chip area for module '\vsdbabysoc': 56739.417600
     of which used for sequential elements: 25504.460800 (44.95%)
```
### Floorplanning report:
![image](https://github.com/user-attachments/assets/48b36e63-98ab-41a1-93dc-98213bf9430b)
```

==========================================================================
floorplan final report_tns
--------------------------------------------------------------------------
tns -411.67

==========================================================================
floorplan final report_wns
--------------------------------------------------------------------------
wns -1.89

==========================================================================
floorplan final report_worst_slack
--------------------------------------------------------------------------
worst slack -1.89

==========================================================================
floorplan final report_checks -path_delay min
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_imm_a2[11]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_imm_a3[11]$_DFF_P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: min

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                  0.00    0.00    0.00   clock clk (rise edge)
                          3.00    3.00   clock network delay (ideal)
                  0.00    0.00    3.00 ^ rvmyth.CPU_imm_a2[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
     1    0.00    0.03    0.27    3.27 ^ rvmyth.CPU_imm_a2[11]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
                                         rvmyth.CPU_imm_a2[11] (net)
                  0.03    0.00    3.27 ^ rvmyth.CPU_imm_a3[11]$_DFF_P_/D (sky130_fd_sc_hd__dfxtp_1)
                                  3.27   data arrival time

                  0.00    0.00    0.00   clock clk (rise edge)
                          3.00    3.00   clock network delay (ideal)
                          0.92    3.92   clock uncertainty
                          0.00    3.92   clock reconvergence pessimism
                                  3.92 ^ rvmyth.CPU_imm_a3[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                         -0.03    3.89   library hold time
                                  3.89   data required time
-----------------------------------------------------------------------------
                                  3.89   data required time
                                 -3.27   data arrival time
-----------------------------------------------------------------------------
                                 -0.61   slack (VIOLATED)



==========================================================================
floorplan final report_checks -path_delay max
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_reset_a3$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[11][26]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                  0.00    0.00    0.00   clock clk (rise edge)
                          3.00    3.00   clock network delay (ideal)
                  0.00    0.00    3.00 ^ rvmyth.CPU_reset_a3$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
   256    0.64    5.89    4.39    7.39 ^ rvmyth.CPU_reset_a3$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
                                         rvmyth.CPU_reset_a3 (net)
                  5.89    0.00    7.39 ^ _08000_/A (sky130_fd_sc_hd__inv_1)
   283    0.65    1.13    7.27   14.66 v _08000_/Y (sky130_fd_sc_hd__inv_1)
                                         _02630_ (net)
                  1.13    0.00   14.66 v _08421_/B1 (sky130_fd_sc_hd__o21ai_1)
    15    0.04    0.76    0.89   15.55 ^ _08421_/Y (sky130_fd_sc_hd__o21ai_1)
                                         _03034_ (net)
                  0.76    0.00   15.55 ^ _08720_/A2 (sky130_fd_sc_hd__o31ai_1)
     1    0.00    0.17    0.13   15.68 v _08720_/Y (sky130_fd_sc_hd__o31ai_1)
                                         _00594_ (net)
                  0.17    0.00   15.68 v rvmyth.CPU_Xreg_value_a4[11][26]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
                                 15.68   data arrival time

                  0.00   11.55   11.55   clock clk (rise edge)
                          3.00   14.55   clock network delay (ideal)
                         -0.58   13.97   clock uncertainty
                          0.00   13.97   clock reconvergence pessimism
                                 13.97 ^ rvmyth.CPU_Xreg_value_a4[11][26]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                         -0.18   13.79   library setup time
                                 13.79   data required time
-----------------------------------------------------------------------------
                                 13.79   data required time
                                -15.68   data arrival time
-----------------------------------------------------------------------------
                                 -1.89   slack (VIOLATED)



==========================================================================
floorplan final report_checks -unconstrained
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_reset_a3$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[11][26]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                  0.00    0.00    0.00   clock clk (rise edge)
                          3.00    3.00   clock network delay (ideal)
                  0.00    0.00    3.00 ^ rvmyth.CPU_reset_a3$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
   256    0.64    5.89    4.39    7.39 ^ rvmyth.CPU_reset_a3$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
                                         rvmyth.CPU_reset_a3 (net)
                  5.89    0.00    7.39 ^ _08000_/A (sky130_fd_sc_hd__inv_1)
   283    0.65    1.13    7.27   14.66 v _08000_/Y (sky130_fd_sc_hd__inv_1)
                                         _02630_ (net)
                  1.13    0.00   14.66 v _08421_/B1 (sky130_fd_sc_hd__o21ai_1)
    15    0.04    0.76    0.89   15.55 ^ _08421_/Y (sky130_fd_sc_hd__o21ai_1)
                                         _03034_ (net)
                  0.76    0.00   15.55 ^ _08720_/A2 (sky130_fd_sc_hd__o31ai_1)
     1    0.00    0.17    0.13   15.68 v _08720_/Y (sky130_fd_sc_hd__o31ai_1)
                                         _00594_ (net)
                  0.17    0.00   15.68 v rvmyth.CPU_Xreg_value_a4[11][26]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
                                 15.68   data arrival time

                  0.00   11.55   11.55   clock clk (rise edge)
                          3.00   14.55   clock network delay (ideal)
                         -0.58   13.97   clock uncertainty
                          0.00   13.97   clock reconvergence pessimism
                                 13.97 ^ rvmyth.CPU_Xreg_value_a4[11][26]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                         -0.18   13.79   library setup time
                                 13.79   data required time
-----------------------------------------------------------------------------
                                 13.79   data required time
                                -15.68   data arrival time
-----------------------------------------------------------------------------
                                 -1.89   slack (VIOLATED)



==========================================================================
floorplan final report_power
--------------------------------------------------------------------------
Group                  Internal  Switching    Leakage      Total
                          Power      Power      Power      Power (Watts)
----------------------------------------------------------------
Sequential             4.85e-03   2.93e-04   1.03e-08   5.15e-03  72.1%
Combinational          8.16e-04   1.17e-03   8.24e-09   1.99e-03  27.9%
Clock                  0.00e+00   0.00e+00   0.00e+00   0.00e+00   0.0%
Macro                  0.00e+00   0.00e+00   0.00e+00   0.00e+00   0.0%
Pad                    0.00e+00   0.00e+00   0.00e+00   0.00e+00   0.0%
----------------------------------------------------------------
Total                  5.67e-03   1.47e-03   1.86e-08   7.14e-03 100.0%
                          79.4%      20.6%       0.0%
```
### Placement report:
The image is shown below: <br/>
![Screenshot from 2024-11-26 05-02-14](https://github.com/user-attachments/assets/81ac9fd1-7934-4149-8f55-ea9accdb6ba6) <br/>
The reports are :<br/>
![image](https://github.com/user-attachments/assets/816c9e34-0c30-4015-901a-388ce7d01730)
```

==========================================================================
detailed place report_tns
--------------------------------------------------------------------------
tns 0.00

==========================================================================
detailed place report_wns
--------------------------------------------------------------------------
wns 0.00

==========================================================================
detailed place report_worst_slack
--------------------------------------------------------------------------
worst slack 5.82

==========================================================================
detailed place report_checks -path_delay min
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_imm_a2[11]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_imm_a3[11]$_DFF_P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: min

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                  0.00    0.00    0.00   clock clk (rise edge)
                          3.00    3.00   clock network delay (ideal)
                  0.00    0.00    3.00 ^ rvmyth.CPU_imm_a2[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
     1    0.00    0.04    0.28    3.28 ^ rvmyth.CPU_imm_a2[11]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
                                         rvmyth.CPU_imm_a2[11] (net)
                  0.04    0.00    3.28 ^ rvmyth.CPU_imm_a3[11]$_DFF_P_/D (sky130_fd_sc_hd__dfxtp_1)
                                  3.28   data arrival time

                  0.00    0.00    0.00   clock clk (rise edge)
                          3.00    3.00   clock network delay (ideal)
                          0.92    3.92   clock uncertainty
                          0.00    3.92   clock reconvergence pessimism
                                  3.92 ^ rvmyth.CPU_imm_a3[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                         -0.04    3.89   library hold time
                                  3.89   data required time
-----------------------------------------------------------------------------
                                  3.89   data required time
                                 -3.28   data arrival time
-----------------------------------------------------------------------------
                                 -0.61   slack (VIOLATED)



==========================================================================
detailed place report_checks -path_delay max
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_src1_value_a3[11]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[8][29]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                  0.00    0.00    0.00   clock clk (rise edge)
                          3.00    3.00   clock network delay (ideal)
                  0.00    0.00    3.00 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
     3    0.01    0.13    0.35    3.35 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
                                         rvmyth.CPU_src1_value_a3[11] (net)
                  0.13    0.00    3.35 ^ _05952_/A (sky130_fd_sc_hd__inv_1)
     2    0.01    0.08    0.11    3.45 v _05952_/Y (sky130_fd_sc_hd__inv_1)
                                         _05526_ (net)
                  0.08    0.00    3.45 v _11479_/B (sky130_fd_sc_hd__ha_4)
     9    0.06    0.09    0.30    3.75 v _11479_/SUM (sky130_fd_sc_hd__ha_4)
                                         _05528_ (net)
                  0.09    0.00    3.75 v _08072_/A (sky130_fd_sc_hd__or4_2)
     2    0.01    0.14    0.74    4.49 v _08072_/X (sky130_fd_sc_hd__or4_2)
                                         _02699_ (net)
                  0.14    0.00    4.49 v _08077_/D (sky130_fd_sc_hd__or4_2)
     2    0.02    0.15    0.65    5.14 v _08077_/X (sky130_fd_sc_hd__or4_2)
                                         _02704_ (net)
                  0.15    0.00    5.14 v _08078_/B1 (sky130_fd_sc_hd__a211oi_4)
     2    0.02    0.33    0.37    5.51 ^ _08078_/Y (sky130_fd_sc_hd__a211oi_4)
                                         _02705_ (net)
                  0.33    0.00    5.51 ^ _08288_/A3 (sky130_fd_sc_hd__o311ai_4)
     3    0.03    0.23    0.18    5.69 v _08288_/Y (sky130_fd_sc_hd__o311ai_4)
                                         _02906_ (net)
                  0.23    0.00    5.69 v _08482_/A2 (sky130_fd_sc_hd__a2111oi_2)
     1    0.01    0.45    0.56    6.25 ^ _08482_/Y (sky130_fd_sc_hd__a2111oi_2)
                                         _03092_ (net)
                  0.45    0.00    6.25 ^ _08483_/C1 (sky130_fd_sc_hd__a2111oi_2)
     1    0.01    0.12    0.13    6.38 v _08483_/Y (sky130_fd_sc_hd__a2111oi_2)
                                         _03093_ (net)
                  0.12    0.00    6.38 v _08484_/B (sky130_fd_sc_hd__xnor2_2)
     1    0.02    0.14    0.21    6.59 v _08484_/Y (sky130_fd_sc_hd__xnor2_2)
                                         _03094_ (net)
                  0.14    0.00    6.59 v _08501_/A2 (sky130_fd_sc_hd__a211oi_4)
    17    0.13    1.35    1.12    7.71 ^ _08501_/Y (sky130_fd_sc_hd__a211oi_4)
                                         _03111_ (net)
                  1.35    0.03    7.74 ^ _09874_/A1 (sky130_fd_sc_hd__o21ai_0)
     1    0.00    0.19    0.23    7.97 v _09874_/Y (sky130_fd_sc_hd__o21ai_0)
                                         _00981_ (net)
                  0.19    0.00    7.97 v rvmyth.CPU_Xreg_value_a4[8][29]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
                                  7.97   data arrival time

                  0.00   11.55   11.55   clock clk (rise edge)
                          3.00   14.55   clock network delay (ideal)
                         -0.58   13.97   clock uncertainty
                          0.00   13.97   clock reconvergence pessimism
                                 13.97 ^ rvmyth.CPU_Xreg_value_a4[8][29]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                         -0.19   13.79   library setup time
                                 13.79   data required time
-----------------------------------------------------------------------------
                                 13.79   data required time
                                 -7.97   data arrival time
-----------------------------------------------------------------------------
                                  5.82   slack (MET)



==========================================================================
detailed place report_checks -unconstrained
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_src1_value_a3[11]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[8][29]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                  0.00    0.00    0.00   clock clk (rise edge)
                          3.00    3.00   clock network delay (ideal)
                  0.00    0.00    3.00 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
     3    0.01    0.13    0.35    3.35 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
                                         rvmyth.CPU_src1_value_a3[11] (net)
                  0.13    0.00    3.35 ^ _05952_/A (sky130_fd_sc_hd__inv_1)
     2    0.01    0.08    0.11    3.45 v _05952_/Y (sky130_fd_sc_hd__inv_1)
                                         _05526_ (net)
                  0.08    0.00    3.45 v _11479_/B (sky130_fd_sc_hd__ha_4)
     9    0.06    0.09    0.30    3.75 v _11479_/SUM (sky130_fd_sc_hd__ha_4)
                                         _05528_ (net)
                  0.09    0.00    3.75 v _08072_/A (sky130_fd_sc_hd__or4_2)
     2    0.01    0.14    0.74    4.49 v _08072_/X (sky130_fd_sc_hd__or4_2)
                                         _02699_ (net)
                  0.14    0.00    4.49 v _08077_/D (sky130_fd_sc_hd__or4_2)
     2    0.02    0.15    0.65    5.14 v _08077_/X (sky130_fd_sc_hd__or4_2)
                                         _02704_ (net)
                  0.15    0.00    5.14 v _08078_/B1 (sky130_fd_sc_hd__a211oi_4)
     2    0.02    0.33    0.37    5.51 ^ _08078_/Y (sky130_fd_sc_hd__a211oi_4)
                                         _02705_ (net)
                  0.33    0.00    5.51 ^ _08288_/A3 (sky130_fd_sc_hd__o311ai_4)
     3    0.03    0.23    0.18    5.69 v _08288_/Y (sky130_fd_sc_hd__o311ai_4)
                                         _02906_ (net)
                  0.23    0.00    5.69 v _08482_/A2 (sky130_fd_sc_hd__a2111oi_2)
     1    0.01    0.45    0.56    6.25 ^ _08482_/Y (sky130_fd_sc_hd__a2111oi_2)
                                         _03092_ (net)
                  0.45    0.00    6.25 ^ _08483_/C1 (sky130_fd_sc_hd__a2111oi_2)
     1    0.01    0.12    0.13    6.38 v _08483_/Y (sky130_fd_sc_hd__a2111oi_2)
                                         _03093_ (net)
                  0.12    0.00    6.38 v _08484_/B (sky130_fd_sc_hd__xnor2_2)
     1    0.02    0.14    0.21    6.59 v _08484_/Y (sky130_fd_sc_hd__xnor2_2)
                                         _03094_ (net)
                  0.14    0.00    6.59 v _08501_/A2 (sky130_fd_sc_hd__a211oi_4)
    17    0.13    1.35    1.12    7.71 ^ _08501_/Y (sky130_fd_sc_hd__a211oi_4)
                                         _03111_ (net)
                  1.35    0.03    7.74 ^ _09874_/A1 (sky130_fd_sc_hd__o21ai_0)
     1    0.00    0.19    0.23    7.97 v _09874_/Y (sky130_fd_sc_hd__o21ai_0)
                                         _00981_ (net)
                  0.19    0.00    7.97 v rvmyth.CPU_Xreg_value_a4[8][29]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
                                  7.97   data arrival time

                  0.00   11.55   11.55   clock clk (rise edge)
                          3.00   14.55   clock network delay (ideal)
                         -0.58   13.97   clock uncertainty
                          0.00   13.97   clock reconvergence pessimism
                                 13.97 ^ rvmyth.CPU_Xreg_value_a4[8][29]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                         -0.19   13.79   library setup time
                                 13.79   data required time
-----------------------------------------------------------------------------
                                 13.79   data required time
                                 -7.97   data arrival time
-----------------------------------------------------------------------------
                                  5.82   slack (MET)



==========================================================================
detailed place report_check_types -max_slew -max_cap -max_fanout -violators
--------------------------------------------------------------------------

==========================================================================
detailed place max_slew_check_slack
--------------------------------------------------------------------------
0.019938606768846512

==========================================================================
detailed place max_slew_check_limit
--------------------------------------------------------------------------
1.5

==========================================================================
detailed place max_slew_check_slack_limit
--------------------------------------------------------------------------
0.0133

==========================================================================
detailed place max_fanout_check_slack
--------------------------------------------------------------------------
1.0000000150474662e+30

==========================================================================
detailed place max_fanout_check_limit
--------------------------------------------------------------------------
1.0000000150474662e+30

==========================================================================
detailed place max_capacitance_check_slack
--------------------------------------------------------------------------
0.000956510251853615

==========================================================================
detailed place max_capacitance_check_limit
--------------------------------------------------------------------------
0.43305400013923645

==========================================================================
detailed place max_capacitance_check_slack_limit
--------------------------------------------------------------------------
0.0022

==========================================================================
detailed place max_slew_violation_count
--------------------------------------------------------------------------
max slew violation count 0

==========================================================================
detailed place max_fanout_violation_count
--------------------------------------------------------------------------
max fanout violation count 0

==========================================================================
detailed place max_cap_violation_count
--------------------------------------------------------------------------
max cap violation count 0

==========================================================================
detailed place setup_violation_count
--------------------------------------------------------------------------
setup violation count 0

==========================================================================
detailed place hold_violation_count
--------------------------------------------------------------------------
hold violation count 1254

==========================================================================
detailed place report_checks -path_delay max reg to reg
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_src1_value_a3[11]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[8][29]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

  Delay    Time   Description
---------------------------------------------------------
   0.00    0.00   clock clk (rise edge)
   3.00    3.00   clock network delay (ideal)
   0.00    3.00 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
   0.35    3.35 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
   0.11    3.45 v _05952_/Y (sky130_fd_sc_hd__inv_1)
   0.30    3.75 v _11479_/SUM (sky130_fd_sc_hd__ha_4)
   0.74    4.49 v _08072_/X (sky130_fd_sc_hd__or4_2)
   0.65    5.14 v _08077_/X (sky130_fd_sc_hd__or4_2)
   0.37    5.51 ^ _08078_/Y (sky130_fd_sc_hd__a211oi_4)
   0.18    5.69 v _08288_/Y (sky130_fd_sc_hd__o311ai_4)
   0.56    6.25 ^ _08482_/Y (sky130_fd_sc_hd__a2111oi_2)
   0.13    6.38 v _08483_/Y (sky130_fd_sc_hd__a2111oi_2)
   0.21    6.59 v _08484_/Y (sky130_fd_sc_hd__xnor2_2)
   1.12    7.71 ^ _08501_/Y (sky130_fd_sc_hd__a211oi_4)
   0.26    7.97 v _09874_/Y (sky130_fd_sc_hd__o21ai_0)
   0.00    7.97 v rvmyth.CPU_Xreg_value_a4[8][29]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
           7.97   data arrival time

  11.55   11.55   clock clk (rise edge)
   3.00   14.55   clock network delay (ideal)
  -0.58   13.97   clock uncertainty
   0.00   13.97   clock reconvergence pessimism
          13.97 ^ rvmyth.CPU_Xreg_value_a4[8][29]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
  -0.19   13.79   library setup time
          13.79   data required time
---------------------------------------------------------
          13.79   data required time
          -7.97   data arrival time
---------------------------------------------------------
           5.82   slack (MET)



==========================================================================
detailed place report_checks -path_delay min reg to reg
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_imm_a2[11]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_imm_a3[11]$_DFF_P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: min

  Delay    Time   Description
---------------------------------------------------------
   0.00    0.00   clock clk (rise edge)
   3.00    3.00   clock network delay (ideal)
   0.00    3.00 ^ rvmyth.CPU_imm_a2[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
   0.28    3.28 ^ rvmyth.CPU_imm_a2[11]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
   0.00    3.28 ^ rvmyth.CPU_imm_a3[11]$_DFF_P_/D (sky130_fd_sc_hd__dfxtp_1)
           3.28   data arrival time

   0.00    0.00   clock clk (rise edge)
   3.00    3.00   clock network delay (ideal)
   0.92    3.92   clock uncertainty
   0.00    3.92   clock reconvergence pessimism
           3.92 ^ rvmyth.CPU_imm_a3[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
  -0.04    3.89   library hold time
           3.89   data required time
---------------------------------------------------------
           3.89   data required time
          -3.28   data arrival time
---------------------------------------------------------
          -0.61   slack (VIOLATED)



==========================================================================
detailed place critical path target clock latency max path
--------------------------------------------------------------------------
0

==========================================================================
detailed place critical path target clock latency min path
--------------------------------------------------------------------------
0

==========================================================================
detailed place critical path source clock latency min path
--------------------------------------------------------------------------
0

==========================================================================
detailed place critical path delay
--------------------------------------------------------------------------
7.9685

==========================================================================
detailed place critical path slack
--------------------------------------------------------------------------
5.8173

==========================================================================
detailed place slack div critical path delay
--------------------------------------------------------------------------
73.003702

==========================================================================
detailed place report_power
--------------------------------------------------------------------------
Group                  Internal  Switching    Leakage      Total
                          Power      Power      Power      Power (Watts)
----------------------------------------------------------------
Sequential             4.93e-03   9.74e-04   1.04e-08   5.90e-03  48.5%
Combinational          1.76e-03   4.52e-03   1.22e-08   6.28e-03  51.5%
Clock                  0.00e+00   0.00e+00   0.00e+00   0.00e+00   0.0%
Macro                  0.00e+00   0.00e+00   0.00e+00   0.00e+00   0.0%
Pad                    0.00e+00   0.00e+00   0.00e+00   0.00e+00   0.0%
----------------------------------------------------------------
Total                  6.68e-03   5.49e-03   2.26e-08   1.22e-02 100.0%
                          54.9%      45.1%       0.0%
```
### CTS report:
The clock tree is shown below:<br/>
![Screenshot from 2024-11-26 05-03-14](https://github.com/user-attachments/assets/4ae6a58c-835d-4637-8d6d-061626540751)<br/>
The reports are:<br/>
![image](https://github.com/user-attachments/assets/9c2b8bff-6dfc-477a-b28a-3ed34586ad1d)
```

==========================================================================
cts final report_tns
--------------------------------------------------------------------------
tns 0.00

==========================================================================
cts final report_wns
--------------------------------------------------------------------------
wns 0.00

==========================================================================
cts final report_worst_slack
--------------------------------------------------------------------------
worst slack 5.73

==========================================================================
cts final report_clock_skew
--------------------------------------------------------------------------
Clock clk
   3.03 source latency rvmyth.CPU_src1_value_a3[20]$_DFF_P_/CLK ^
  -2.95 target latency rvmyth.CPU_Xreg_value_a4[5][26]$_SDFFE_PP0P_/CLK ^
   0.58 clock uncertainty
   0.00 CRPR
--------------
   0.66 setup skew


==========================================================================
cts final report_checks -path_delay min
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_dmem_rd_data_a5[20]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[14][20]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: min

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                          0.00    0.00   clock clk (rise edge)
                          2.00    2.00   clock source latency
     1    0.23    0.00    0.00    2.00 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.03    0.01    2.01 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.16    0.17    0.22    2.23 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.17    0.00    2.23 ^ clkbuf_2_2_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.14    0.16    0.26    2.49 ^ clkbuf_2_2_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_2_0_clk_arun (net)
                  0.16    0.00    2.49 ^ clkbuf_4_8__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    13    0.23    0.24    0.31    2.81 ^ clkbuf_4_8__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_8__leaf_clk_arun (net)
                  0.24    0.00    2.81 ^ clkbuf_leaf_24_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     9    0.04    0.06    0.20    3.01 ^ clkbuf_leaf_24_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_24_clk_arun (net)
                  0.06    0.00    3.01 ^ rvmyth.CPU_dmem_rd_data_a5[20]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_4)
     1    0.06    0.09    0.41    3.42 v rvmyth.CPU_dmem_rd_data_a5[20]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_4)
                                         rvmyth.CPU_dmem_rd_data_a5[20] (net)
                  0.09    0.01    3.43 v _08267_/B (sky130_fd_sc_hd__nand3_4)
    15    0.09    0.26    0.26    3.68 ^ _08267_/Y (sky130_fd_sc_hd__nand3_4)
                                         _02886_ (net)
                  0.26    0.01    3.69 ^ _09005_/A1 (sky130_fd_sc_hd__o221ai_1)
     1    0.00    0.08    0.16    3.85 v _09005_/Y (sky130_fd_sc_hd__o221ai_1)
                                         _00684_ (net)
                  0.08    0.00    3.85 v rvmyth.CPU_Xreg_value_a4[14][20]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
                                  3.85   data arrival time

                          0.00    0.00   clock clk (rise edge)
                          2.00    2.00   clock source latency
     1    0.23    0.00    0.00    2.00 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.03    0.01    2.01 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.16    0.17    0.22    2.23 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.17    0.00    2.23 ^ clkbuf_2_0_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.15    0.17    0.26    2.50 ^ clkbuf_2_0_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_0_0_clk_arun (net)
                  0.17    0.00    2.50 ^ clkbuf_4_2__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    10    0.20    0.21    0.29    2.79 ^ clkbuf_4_2__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_2__leaf_clk_arun (net)
                  0.21    0.00    2.80 ^ clkbuf_leaf_7_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     8    0.04    0.06    0.20    2.99 ^ clkbuf_leaf_7_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_7_clk_arun (net)
                  0.06    0.00    2.99 ^ rvmyth.CPU_Xreg_value_a4[14][20]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                          0.92    3.92   clock uncertainty
                          0.00    3.92   clock reconvergence pessimism
                         -0.06    3.85   library hold time
                                  3.85   data required time
-----------------------------------------------------------------------------
                                  3.85   data required time
                                 -3.85   data arrival time
-----------------------------------------------------------------------------
                                  0.00   slack (MET)



==========================================================================
cts final report_checks -path_delay max
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_imm_a3[30]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[8][30]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                          0.00    0.00   clock clk (rise edge)
                          2.00    2.00   clock source latency
     1    0.23    0.00    0.00    2.00 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.03    0.01    2.01 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.16    0.17    0.22    2.23 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.17    0.00    2.23 ^ clkbuf_2_3_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.15    0.16    0.26    2.49 ^ clkbuf_2_3_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_3_0_clk_arun (net)
                  0.16    0.00    2.50 ^ clkbuf_4_13__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    12    0.21    0.22    0.30    2.80 ^ clkbuf_4_13__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_13__leaf_clk_arun (net)
                  0.22    0.00    2.80 ^ clkbuf_leaf_96_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     9    0.04    0.07    0.20    3.00 ^ clkbuf_leaf_96_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_96_clk_arun (net)
                  0.07    0.00    3.00 ^ rvmyth.CPU_imm_a3[30]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_4)
    51    0.43    1.18    1.11    4.11 ^ rvmyth.CPU_imm_a3[30]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_4)
                                         rvmyth.CPU_imm_a3[10] (net)
                  1.18    0.03    4.14 ^ _11528_/B (sky130_fd_sc_hd__ha_2)
     6    0.03    0.10    0.55    4.68 v _11528_/SUM (sky130_fd_sc_hd__ha_2)
                                         _05639_ (net)
                  0.10    0.00    4.68 v _07982_/C (sky130_fd_sc_hd__nor3_2)
     3    0.02    0.34    0.28    4.96 ^ _07982_/Y (sky130_fd_sc_hd__nor3_2)
                                         _02612_ (net)
                  0.34    0.00    4.96 ^ _07984_/A (sky130_fd_sc_hd__nand2_2)
     2    0.02    0.13    0.16    5.12 v _07984_/Y (sky130_fd_sc_hd__nand2_2)
                                         _02614_ (net)
                  0.13    0.00    5.12 v _07988_/A2 (sky130_fd_sc_hd__a21oi_2)
     2    0.02    0.26    0.29    5.41 ^ _07988_/Y (sky130_fd_sc_hd__a21oi_2)
                                         _02618_ (net)
                  0.26    0.00    5.41 ^ _08107_/A1 (sky130_fd_sc_hd__o21ai_4)
     4    0.04    0.17    0.16    5.57 v _08107_/Y (sky130_fd_sc_hd__o21ai_4)
                                         _02733_ (net)
                  0.17    0.00    5.57 v _08315_/A1 (sky130_fd_sc_hd__a21oi_4)
     3    0.03    0.22    0.26    5.84 ^ _08315_/Y (sky130_fd_sc_hd__a21oi_4)
                                         _02932_ (net)
                  0.22    0.00    5.84 ^ _08522_/A2 (sky130_fd_sc_hd__o211ai_2)
     2    0.01    0.13    0.13    5.97 v _08522_/Y (sky130_fd_sc_hd__o211ai_2)
                                         _03129_ (net)
                  0.13    0.00    5.97 v _08526_/B (sky130_fd_sc_hd__and3_1)
     1    0.01    0.06    0.23    6.20 v _08526_/X (sky130_fd_sc_hd__and3_1)
                                         _03133_ (net)
                  0.06    0.00    6.20 v _08540_/B (sky130_fd_sc_hd__nor3_4)
    17    0.14    1.32    1.03    7.23 ^ _08540_/Y (sky130_fd_sc_hd__nor3_4)
                                         _03147_ (net)
                  1.32    0.03    7.26 ^ _09879_/B2 (sky130_fd_sc_hd__o221ai_1)
     1    0.00    0.20    0.20    7.47 v _09879_/Y (sky130_fd_sc_hd__o221ai_1)
                                         _00983_ (net)
                  0.20    0.00    7.47 v hold1504/A (sky130_fd_sc_hd__dlygate4sd3_1)
     1    0.00    0.06    0.63    8.09 v hold1504/X (sky130_fd_sc_hd__dlygate4sd3_1)
                                         net1742 (net)
                  0.06    0.00    8.09 v rvmyth.CPU_Xreg_value_a4[8][30]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
                                  8.09   data arrival time

                         11.55   11.55   clock clk (rise edge)
                          2.00   13.55   clock source latency
     1    0.23    0.00    0.00   13.55 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.03    0.01   13.56 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.16    0.17    0.22   13.78 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.17    0.00   13.78 ^ clkbuf_2_0_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.15    0.17    0.26   14.05 ^ clkbuf_2_0_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_0_0_clk_arun (net)
                  0.17    0.00   14.05 ^ clkbuf_4_0__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    10    0.17    0.18    0.28   14.33 ^ clkbuf_4_0__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_0__leaf_clk_arun (net)
                  0.18    0.00   14.33 ^ clkbuf_leaf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     9    0.04    0.06    0.19   14.52 ^ clkbuf_leaf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_0_clk_arun (net)
                  0.06    0.00   14.52 ^ rvmyth.CPU_Xreg_value_a4[8][30]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                         -0.58   13.94   clock uncertainty
                          0.00   13.94   clock reconvergence pessimism
                         -0.11   13.83   library setup time
                                 13.83   data required time
-----------------------------------------------------------------------------
                                 13.83   data required time
                                 -8.09   data arrival time
-----------------------------------------------------------------------------
                                  5.73   slack (MET)



==========================================================================
cts final report_checks -unconstrained
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_imm_a3[30]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[8][30]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                          0.00    0.00   clock clk (rise edge)
                          2.00    2.00   clock source latency
     1    0.23    0.00    0.00    2.00 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.03    0.01    2.01 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.16    0.17    0.22    2.23 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.17    0.00    2.23 ^ clkbuf_2_3_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.15    0.16    0.26    2.49 ^ clkbuf_2_3_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_3_0_clk_arun (net)
                  0.16    0.00    2.50 ^ clkbuf_4_13__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    12    0.21    0.22    0.30    2.80 ^ clkbuf_4_13__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_13__leaf_clk_arun (net)
                  0.22    0.00    2.80 ^ clkbuf_leaf_96_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     9    0.04    0.07    0.20    3.00 ^ clkbuf_leaf_96_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_96_clk_arun (net)
                  0.07    0.00    3.00 ^ rvmyth.CPU_imm_a3[30]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_4)
    51    0.43    1.18    1.11    4.11 ^ rvmyth.CPU_imm_a3[30]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_4)
                                         rvmyth.CPU_imm_a3[10] (net)
                  1.18    0.03    4.14 ^ _11528_/B (sky130_fd_sc_hd__ha_2)
     6    0.03    0.10    0.55    4.68 v _11528_/SUM (sky130_fd_sc_hd__ha_2)
                                         _05639_ (net)
                  0.10    0.00    4.68 v _07982_/C (sky130_fd_sc_hd__nor3_2)
     3    0.02    0.34    0.28    4.96 ^ _07982_/Y (sky130_fd_sc_hd__nor3_2)
                                         _02612_ (net)
                  0.34    0.00    4.96 ^ _07984_/A (sky130_fd_sc_hd__nand2_2)
     2    0.02    0.13    0.16    5.12 v _07984_/Y (sky130_fd_sc_hd__nand2_2)
                                         _02614_ (net)
                  0.13    0.00    5.12 v _07988_/A2 (sky130_fd_sc_hd__a21oi_2)
     2    0.02    0.26    0.29    5.41 ^ _07988_/Y (sky130_fd_sc_hd__a21oi_2)
                                         _02618_ (net)
                  0.26    0.00    5.41 ^ _08107_/A1 (sky130_fd_sc_hd__o21ai_4)
     4    0.04    0.17    0.16    5.57 v _08107_/Y (sky130_fd_sc_hd__o21ai_4)
                                         _02733_ (net)
                  0.17    0.00    5.57 v _08315_/A1 (sky130_fd_sc_hd__a21oi_4)
     3    0.03    0.22    0.26    5.84 ^ _08315_/Y (sky130_fd_sc_hd__a21oi_4)
                                         _02932_ (net)
                  0.22    0.00    5.84 ^ _08522_/A2 (sky130_fd_sc_hd__o211ai_2)
     2    0.01    0.13    0.13    5.97 v _08522_/Y (sky130_fd_sc_hd__o211ai_2)
                                         _03129_ (net)
                  0.13    0.00    5.97 v _08526_/B (sky130_fd_sc_hd__and3_1)
     1    0.01    0.06    0.23    6.20 v _08526_/X (sky130_fd_sc_hd__and3_1)
                                         _03133_ (net)
                  0.06    0.00    6.20 v _08540_/B (sky130_fd_sc_hd__nor3_4)
    17    0.14    1.32    1.03    7.23 ^ _08540_/Y (sky130_fd_sc_hd__nor3_4)
                                         _03147_ (net)
                  1.32    0.03    7.26 ^ _09879_/B2 (sky130_fd_sc_hd__o221ai_1)
     1    0.00    0.20    0.20    7.47 v _09879_/Y (sky130_fd_sc_hd__o221ai_1)
                                         _00983_ (net)
                  0.20    0.00    7.47 v hold1504/A (sky130_fd_sc_hd__dlygate4sd3_1)
     1    0.00    0.06    0.63    8.09 v hold1504/X (sky130_fd_sc_hd__dlygate4sd3_1)
                                         net1742 (net)
                  0.06    0.00    8.09 v rvmyth.CPU_Xreg_value_a4[8][30]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
                                  8.09   data arrival time

                         11.55   11.55   clock clk (rise edge)
                          2.00   13.55   clock source latency
     1    0.23    0.00    0.00   13.55 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.03    0.01   13.56 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.16    0.17    0.22   13.78 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.17    0.00   13.78 ^ clkbuf_2_0_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.15    0.17    0.26   14.05 ^ clkbuf_2_0_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_0_0_clk_arun (net)
                  0.17    0.00   14.05 ^ clkbuf_4_0__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    10    0.17    0.18    0.28   14.33 ^ clkbuf_4_0__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_0__leaf_clk_arun (net)
                  0.18    0.00   14.33 ^ clkbuf_leaf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     9    0.04    0.06    0.19   14.52 ^ clkbuf_leaf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_0_clk_arun (net)
                  0.06    0.00   14.52 ^ rvmyth.CPU_Xreg_value_a4[8][30]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                         -0.58   13.94   clock uncertainty
                          0.00   13.94   clock reconvergence pessimism
                         -0.11   13.83   library setup time
                                 13.83   data required time
-----------------------------------------------------------------------------
                                 13.83   data required time
                                 -8.09   data arrival time
-----------------------------------------------------------------------------
                                  5.73   slack (MET)



==========================================================================
cts final report_check_types -max_slew -max_cap -max_fanout -violators
--------------------------------------------------------------------------

==========================================================================
cts final max_slew_check_slack
--------------------------------------------------------------------------
0.03236699849367142

==========================================================================
cts final max_slew_check_limit
--------------------------------------------------------------------------
1.5

==========================================================================
cts final max_slew_check_slack_limit
--------------------------------------------------------------------------
0.0216

==========================================================================
cts final max_fanout_check_slack
--------------------------------------------------------------------------
1.0000000150474662e+30

==========================================================================
cts final max_fanout_check_limit
--------------------------------------------------------------------------
1.0000000150474662e+30

==========================================================================
cts final max_capacitance_check_slack
--------------------------------------------------------------------------
0.004754904191941023

==========================================================================
cts final max_capacitance_check_limit
--------------------------------------------------------------------------
0.43305400013923645

==========================================================================
cts final max_capacitance_check_slack_limit
--------------------------------------------------------------------------
0.0110

==========================================================================
cts final max_slew_violation_count
--------------------------------------------------------------------------
max slew violation count 0

==========================================================================
cts final max_fanout_violation_count
--------------------------------------------------------------------------
max fanout violation count 0

==========================================================================
cts final max_cap_violation_count
--------------------------------------------------------------------------
max cap violation count 0

==========================================================================
cts final setup_violation_count
--------------------------------------------------------------------------
setup violation count 0

==========================================================================
cts final hold_violation_count
--------------------------------------------------------------------------
hold violation count 0

==========================================================================
cts final report_checks -path_delay max reg to reg
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_imm_a3[30]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[8][30]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

  Delay    Time   Description
---------------------------------------------------------
   0.00    0.00   clock clk (rise edge)
   2.00    2.00   clock source latency
   0.00    2.00 ^ avsdpll/CLK (avsdpll)
   0.23    2.23 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.26    2.49 ^ clkbuf_2_3_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.30    2.80 ^ clkbuf_4_13__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.20    3.00 ^ clkbuf_leaf_96_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.00    3.00 ^ rvmyth.CPU_imm_a3[30]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_4)
   1.11    4.11 ^ rvmyth.CPU_imm_a3[30]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_4)
   0.57    4.68 v _11528_/SUM (sky130_fd_sc_hd__ha_2)
   0.28    4.96 ^ _07982_/Y (sky130_fd_sc_hd__nor3_2)
   0.16    5.12 v _07984_/Y (sky130_fd_sc_hd__nand2_2)
   0.29    5.41 ^ _07988_/Y (sky130_fd_sc_hd__a21oi_2)
   0.16    5.57 v _08107_/Y (sky130_fd_sc_hd__o21ai_4)
   0.26    5.84 ^ _08315_/Y (sky130_fd_sc_hd__a21oi_4)
   0.13    5.97 v _08522_/Y (sky130_fd_sc_hd__o211ai_2)
   0.23    6.20 v _08526_/X (sky130_fd_sc_hd__and3_1)
   1.03    7.23 ^ _08540_/Y (sky130_fd_sc_hd__nor3_4)
   0.24    7.47 v _09879_/Y (sky130_fd_sc_hd__o221ai_1)
   0.63    8.09 v hold1504/X (sky130_fd_sc_hd__dlygate4sd3_1)
   0.00    8.09 v rvmyth.CPU_Xreg_value_a4[8][30]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
           8.09   data arrival time

  11.55   11.55   clock clk (rise edge)
   2.00   13.55   clock source latency
   0.00   13.55 ^ avsdpll/CLK (avsdpll)
   0.23   13.78 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.27   14.05 ^ clkbuf_2_0_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.28   14.33 ^ clkbuf_4_0__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.19   14.52 ^ clkbuf_leaf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.00   14.52 ^ rvmyth.CPU_Xreg_value_a4[8][30]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
  -0.58   13.94   clock uncertainty
   0.00   13.94   clock reconvergence pessimism
  -0.11   13.83   library setup time
          13.83   data required time
---------------------------------------------------------
          13.83   data required time
          -8.09   data arrival time
---------------------------------------------------------
           5.73   slack (MET)



==========================================================================
cts final report_checks -path_delay min reg to reg
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_dmem_rd_data_a5[20]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[14][20]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: min

  Delay    Time   Description
---------------------------------------------------------
   0.00    0.00   clock clk (rise edge)
   2.00    2.00   clock source latency
   0.00    2.00 ^ avsdpll/CLK (avsdpll)
   0.23    2.23 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.26    2.49 ^ clkbuf_2_2_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.31    2.81 ^ clkbuf_4_8__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.21    3.01 ^ clkbuf_leaf_24_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.00    3.01 ^ rvmyth.CPU_dmem_rd_data_a5[20]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_4)
   0.41    3.42 v rvmyth.CPU_dmem_rd_data_a5[20]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_4)
   0.27    3.68 ^ _08267_/Y (sky130_fd_sc_hd__nand3_4)
   0.17    3.85 v _09005_/Y (sky130_fd_sc_hd__o221ai_1)
   0.00    3.85 v rvmyth.CPU_Xreg_value_a4[14][20]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
           3.85   data arrival time

   0.00    0.00   clock clk (rise edge)
   2.00    2.00   clock source latency
   0.00    2.00 ^ avsdpll/CLK (avsdpll)
   0.23    2.23 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.27    2.50 ^ clkbuf_2_0_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.30    2.79 ^ clkbuf_4_2__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.20    2.99 ^ clkbuf_leaf_7_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.00    2.99 ^ rvmyth.CPU_Xreg_value_a4[14][20]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
   0.92    3.92   clock uncertainty
   0.00    3.92   clock reconvergence pessimism
  -0.06    3.85   library hold time
           3.85   data required time
---------------------------------------------------------
           3.85   data required time
          -3.85   data arrival time
---------------------------------------------------------
           0.00   slack (MET)



==========================================================================
cts final critical path target clock latency max path
--------------------------------------------------------------------------
0

==========================================================================
cts final critical path target clock latency min path
--------------------------------------------------------------------------
0

==========================================================================
cts final critical path source clock latency min path
--------------------------------------------------------------------------
0

==========================================================================
cts final critical path delay
--------------------------------------------------------------------------
8.0928

==========================================================================
cts final critical path slack
--------------------------------------------------------------------------
5.7323

==========================================================================
cts final slack div critical path delay
--------------------------------------------------------------------------
70.832098

==========================================================================
cts final report_power
--------------------------------------------------------------------------
Group                  Internal  Switching    Leakage      Total
                          Power      Power      Power      Power (Watts)
----------------------------------------------------------------
Sequential             4.83e-03   9.02e-04   1.04e-08   5.73e-03  30.7%
Combinational          2.05e-03   4.67e-03   2.39e-08   6.72e-03  36.0%
Clock                  3.27e-03   2.95e-03   2.82e-09   6.22e-03  33.3%
Macro                  0.00e+00   0.00e+00   0.00e+00   0.00e+00   0.0%
Pad                    0.00e+00   0.00e+00   0.00e+00   0.00e+00   0.0%
----------------------------------------------------------------
Total                  1.01e-02   8.52e-03   3.71e-08   1.87e-02 100.0%
                          54.4%      45.6%       0.0%
```

### Routing report:
* There is no congestion issues/violations observed.
![Screenshot from 2024-11-26 02-43-02](https://github.com/user-attachments/assets/d30acd08-b96d-40cc-a9d0-6e635b4a3b91)
The report is given below: <br/>
![image](https://github.com/user-attachments/assets/3de98caa-2915-4d04-8386-7172d4627d48)
```

==========================================================================
global route report_tns
--------------------------------------------------------------------------
tns 0.00

==========================================================================
global route report_wns
--------------------------------------------------------------------------
wns 0.00

==========================================================================
global route report_worst_slack
--------------------------------------------------------------------------
worst slack 5.62

==========================================================================
global route report_clock_skew
--------------------------------------------------------------------------
Clock clk
   2.98 source latency rvmyth.CPU_src1_value_a3[20]$_DFF_P_/CLK ^
  -2.91 target latency rvmyth.CPU_Xreg_value_a4[8][26]$_SDFFE_PP0P_/CLK ^
   0.58 clock uncertainty
   0.00 CRPR
--------------
   0.65 setup skew


==========================================================================
global route report_checks -path_delay min
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_Xreg_value_a4[1][21]$_SDFFE_PP0P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_src1_value_a3[21]$_DFF_P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: min

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                          0.00    0.00   clock clk (rise edge)
                          2.00    2.00   clock source latency
     2    0.20    0.00    0.00    2.00 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.02    0.01    2.01 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.13    0.14    0.20    2.21 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.14    0.00    2.21 ^ clkbuf_2_0_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.14    0.16    0.25    2.46 ^ clkbuf_2_0_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_0_0_clk_arun (net)
                  0.16    0.01    2.46 ^ clkbuf_4_0__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    10    0.17    0.18    0.27    2.73 ^ clkbuf_4_0__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_0__leaf_clk_arun (net)
                  0.18    0.00    2.74 ^ clkbuf_leaf_1_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     9    0.04    0.06    0.19    2.92 ^ clkbuf_leaf_1_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_1_clk_arun (net)
                  0.06    0.00    2.92 ^ rvmyth.CPU_Xreg_value_a4[1][21]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
     3    0.01    0.11    0.36    3.29 ^ rvmyth.CPU_Xreg_value_a4[1][21]$_SDFFE_PP0P_/Q (sky130_fd_sc_hd__dfxtp_1)
                                         rvmyth.CPU_Xreg_value_a4[1][21] (net)
                  0.11    0.00    3.29 ^ _10331_/B2 (sky130_fd_sc_hd__a22oi_1)
     1    0.00    0.06    0.08    3.37 v _10331_/Y (sky130_fd_sc_hd__a22oi_1)
                                         _04437_ (net)
                  0.06    0.00    3.37 v _10332_/C (sky130_fd_sc_hd__nand3_1)
     1    0.01    0.12    0.13    3.50 ^ _10332_/Y (sky130_fd_sc_hd__nand3_1)
                                         _04438_ (net)
                  0.12    0.00    3.50 ^ _10333_/B2 (sky130_fd_sc_hd__o22ai_4)
     1    0.05    0.14    0.15    3.65 v _10333_/Y (sky130_fd_sc_hd__o22ai_4)
                                         _04439_ (net)
                  0.14    0.01    3.66 v _10336_/A2 (sky130_fd_sc_hd__o21ai_0)
     1    0.00    0.08    0.20    3.87 ^ _10336_/Y (sky130_fd_sc_hd__o21ai_0)
                                         rvmyth.CPU_src1_value_a2[21] (net)
                  0.08    0.00    3.87 ^ rvmyth.CPU_src1_value_a3[21]$_DFF_P_/D (sky130_fd_sc_hd__dfxtp_2)
                                  3.87   data arrival time

                          0.00    0.00   clock clk (rise edge)
                          2.00    2.00   clock source latency
     2    0.20    0.00    0.00    2.00 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.02    0.01    2.01 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.13    0.14    0.20    2.21 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.14    0.00    2.21 ^ clkbuf_2_2_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.13    0.15    0.24    2.45 ^ clkbuf_2_2_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_2_0_clk_arun (net)
                  0.15    0.00    2.46 ^ clkbuf_4_8__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    13    0.21    0.22    0.30    2.75 ^ clkbuf_4_8__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_8__leaf_clk_arun (net)
                  0.22    0.01    2.76 ^ clkbuf_leaf_26_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    10    0.05    0.07    0.21    2.97 ^ clkbuf_leaf_26_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_26_clk_arun (net)
                  0.07    0.00    2.97 ^ rvmyth.CPU_src1_value_a3[21]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_2)
                          0.92    3.89   clock uncertainty
                          0.00    3.89   clock reconvergence pessimism
                         -0.04    3.86   library hold time
                                  3.86   data required time
-----------------------------------------------------------------------------
                                  3.86   data required time
                                 -3.87   data arrival time
-----------------------------------------------------------------------------
                                  0.01   slack (MET)



==========================================================================
global route report_checks -path_delay max
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_src1_value_a3[11]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[14][29]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                          0.00    0.00   clock clk (rise edge)
                          2.00    2.00   clock source latency
     2    0.20    0.00    0.00    2.00 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.02    0.01    2.01 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.13    0.14    0.20    2.21 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.14    0.00    2.21 ^ clkbuf_2_3_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.13    0.14    0.24    2.45 ^ clkbuf_2_3_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_3_0_clk_arun (net)
                  0.14    0.00    2.46 ^ clkbuf_4_13__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    12    0.20    0.21    0.29    2.74 ^ clkbuf_4_13__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_13__leaf_clk_arun (net)
                  0.21    0.01    2.75 ^ clkbuf_leaf_95_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    10    0.05    0.07    0.20    2.95 ^ clkbuf_leaf_95_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_95_clk_arun (net)
                  0.07    0.00    2.95 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
     3    0.02    0.16    0.40    3.35 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
                                         rvmyth.CPU_src1_value_a3[11] (net)
                  0.16    0.00    3.35 ^ _05952_/A (sky130_fd_sc_hd__inv_1)
     2    0.02    0.10    0.13    3.47 v _05952_/Y (sky130_fd_sc_hd__inv_1)
                                         _05526_ (net)
                  0.10    0.00    3.48 v _11479_/B (sky130_fd_sc_hd__ha_4)
     9    0.06    0.10    0.31    3.78 v _11479_/SUM (sky130_fd_sc_hd__ha_4)
                                         _05528_ (net)
                  0.10    0.00    3.79 v _08072_/A (sky130_fd_sc_hd__or4_2)
     2    0.01    0.14    0.74    4.53 v _08072_/X (sky130_fd_sc_hd__or4_2)
                                         _02699_ (net)
                  0.14    0.00    4.53 v _08077_/D (sky130_fd_sc_hd__or4_2)
     2    0.02    0.15    0.65    5.18 v _08077_/X (sky130_fd_sc_hd__or4_2)
                                         _02704_ (net)
                  0.15    0.00    5.18 v _08078_/B1 (sky130_fd_sc_hd__a211oi_4)
     2    0.02    0.34    0.38    5.56 ^ _08078_/Y (sky130_fd_sc_hd__a211oi_4)
                                         _02705_ (net)
                  0.34    0.00    5.56 ^ _08288_/A3 (sky130_fd_sc_hd__o311ai_4)
     3    0.03    0.24    0.18    5.75 v _08288_/Y (sky130_fd_sc_hd__o311ai_4)
                                         _02906_ (net)
                  0.24    0.00    5.75 v _08482_/A2 (sky130_fd_sc_hd__a2111oi_2)
     1    0.01    0.49    0.60    6.35 ^ _08482_/Y (sky130_fd_sc_hd__a2111oi_2)
                                         _03092_ (net)
                  0.49    0.00    6.35 ^ _08483_/C1 (sky130_fd_sc_hd__a2111oi_2)
     1    0.01    0.13    0.14    6.49 v _08483_/Y (sky130_fd_sc_hd__a2111oi_2)
                                         _03093_ (net)
                  0.13    0.00    6.49 v _08484_/B (sky130_fd_sc_hd__xnor2_2)
     1    0.02    0.15    0.22    6.71 v _08484_/Y (sky130_fd_sc_hd__xnor2_2)
                                         _03094_ (net)
                  0.15    0.00    6.71 v _08501_/A2 (sky130_fd_sc_hd__a211oi_4)
    17    0.12    1.31    1.09    7.80 ^ _08501_/Y (sky130_fd_sc_hd__a211oi_4)
                                         _03111_ (net)
                  1.31    0.03    7.83 ^ _09030_/A1 (sky130_fd_sc_hd__o21ai_0)
     1    0.00    0.21    0.28    8.11 v _09030_/Y (sky130_fd_sc_hd__o21ai_0)
                                         _00693_ (net)
                  0.21    0.00    8.11 v rvmyth.CPU_Xreg_value_a4[14][29]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
                                  8.11   data arrival time

                         11.55   11.55   clock clk (rise edge)
                          2.00   13.55   clock source latency
     2    0.20    0.00    0.00   13.55 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.02    0.01   13.56 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.13    0.14    0.20   13.76 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.14    0.00   13.76 ^ clkbuf_2_0_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.14    0.16    0.25   14.01 ^ clkbuf_2_0_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_0_0_clk_arun (net)
                  0.16    0.01   14.01 ^ clkbuf_4_0__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    10    0.17    0.18    0.27   14.28 ^ clkbuf_4_0__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_0__leaf_clk_arun (net)
                  0.18    0.00   14.29 ^ clkbuf_leaf_3_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     8    0.05    0.07    0.19   14.48 ^ clkbuf_leaf_3_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_3_clk_arun (net)
                  0.07    0.00   14.48 ^ rvmyth.CPU_Xreg_value_a4[14][29]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                         -0.58   13.90   clock uncertainty
                          0.00   13.90   clock reconvergence pessimism
                         -0.18   13.72   library setup time
                                 13.72   data required time
-----------------------------------------------------------------------------
                                 13.72   data required time
                                 -8.11   data arrival time
-----------------------------------------------------------------------------
                                  5.62   slack (MET)



==========================================================================
global route report_checks -unconstrained
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_src1_value_a3[11]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[14][29]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

Fanout     Cap    Slew   Delay    Time   Description
-----------------------------------------------------------------------------
                          0.00    0.00   clock clk (rise edge)
                          2.00    2.00   clock source latency
     2    0.20    0.00    0.00    2.00 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.02    0.01    2.01 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.13    0.14    0.20    2.21 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.14    0.00    2.21 ^ clkbuf_2_3_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.13    0.14    0.24    2.45 ^ clkbuf_2_3_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_3_0_clk_arun (net)
                  0.14    0.00    2.46 ^ clkbuf_4_13__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    12    0.20    0.21    0.29    2.74 ^ clkbuf_4_13__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_13__leaf_clk_arun (net)
                  0.21    0.01    2.75 ^ clkbuf_leaf_95_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    10    0.05    0.07    0.20    2.95 ^ clkbuf_leaf_95_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_95_clk_arun (net)
                  0.07    0.00    2.95 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
     3    0.02    0.16    0.40    3.35 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
                                         rvmyth.CPU_src1_value_a3[11] (net)
                  0.16    0.00    3.35 ^ _05952_/A (sky130_fd_sc_hd__inv_1)
     2    0.02    0.10    0.13    3.47 v _05952_/Y (sky130_fd_sc_hd__inv_1)
                                         _05526_ (net)
                  0.10    0.00    3.48 v _11479_/B (sky130_fd_sc_hd__ha_4)
     9    0.06    0.10    0.31    3.78 v _11479_/SUM (sky130_fd_sc_hd__ha_4)
                                         _05528_ (net)
                  0.10    0.00    3.79 v _08072_/A (sky130_fd_sc_hd__or4_2)
     2    0.01    0.14    0.74    4.53 v _08072_/X (sky130_fd_sc_hd__or4_2)
                                         _02699_ (net)
                  0.14    0.00    4.53 v _08077_/D (sky130_fd_sc_hd__or4_2)
     2    0.02    0.15    0.65    5.18 v _08077_/X (sky130_fd_sc_hd__or4_2)
                                         _02704_ (net)
                  0.15    0.00    5.18 v _08078_/B1 (sky130_fd_sc_hd__a211oi_4)
     2    0.02    0.34    0.38    5.56 ^ _08078_/Y (sky130_fd_sc_hd__a211oi_4)
                                         _02705_ (net)
                  0.34    0.00    5.56 ^ _08288_/A3 (sky130_fd_sc_hd__o311ai_4)
     3    0.03    0.24    0.18    5.75 v _08288_/Y (sky130_fd_sc_hd__o311ai_4)
                                         _02906_ (net)
                  0.24    0.00    5.75 v _08482_/A2 (sky130_fd_sc_hd__a2111oi_2)
     1    0.01    0.49    0.60    6.35 ^ _08482_/Y (sky130_fd_sc_hd__a2111oi_2)
                                         _03092_ (net)
                  0.49    0.00    6.35 ^ _08483_/C1 (sky130_fd_sc_hd__a2111oi_2)
     1    0.01    0.13    0.14    6.49 v _08483_/Y (sky130_fd_sc_hd__a2111oi_2)
                                         _03093_ (net)
                  0.13    0.00    6.49 v _08484_/B (sky130_fd_sc_hd__xnor2_2)
     1    0.02    0.15    0.22    6.71 v _08484_/Y (sky130_fd_sc_hd__xnor2_2)
                                         _03094_ (net)
                  0.15    0.00    6.71 v _08501_/A2 (sky130_fd_sc_hd__a211oi_4)
    17    0.12    1.31    1.09    7.80 ^ _08501_/Y (sky130_fd_sc_hd__a211oi_4)
                                         _03111_ (net)
                  1.31    0.03    7.83 ^ _09030_/A1 (sky130_fd_sc_hd__o21ai_0)
     1    0.00    0.21    0.28    8.11 v _09030_/Y (sky130_fd_sc_hd__o21ai_0)
                                         _00693_ (net)
                  0.21    0.00    8.11 v rvmyth.CPU_Xreg_value_a4[14][29]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
                                  8.11   data arrival time

                         11.55   11.55   clock clk (rise edge)
                          2.00   13.55   clock source latency
     2    0.20    0.00    0.00   13.55 ^ avsdpll/CLK (avsdpll)
                                         clk_arun (net)
                  0.02    0.01   13.56 ^ clkbuf_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.13    0.14    0.20   13.76 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_0_clk_arun (net)
                  0.14    0.00   13.76 ^ clkbuf_2_0_0_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     4    0.14    0.16    0.25   14.01 ^ clkbuf_2_0_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_2_0_0_clk_arun (net)
                  0.16    0.01   14.01 ^ clkbuf_4_0__f_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
    10    0.17    0.18    0.27   14.28 ^ clkbuf_4_0__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_4_0__leaf_clk_arun (net)
                  0.18    0.00   14.29 ^ clkbuf_leaf_3_clk_arun/A (sky130_fd_sc_hd__clkbuf_16)
     8    0.05    0.07    0.19   14.48 ^ clkbuf_leaf_3_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
                                         clknet_leaf_3_clk_arun (net)
                  0.07    0.00   14.48 ^ rvmyth.CPU_Xreg_value_a4[14][29]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
                         -0.58   13.90   clock uncertainty
                          0.00   13.90   clock reconvergence pessimism
                         -0.18   13.72   library setup time
                                 13.72   data required time
-----------------------------------------------------------------------------
                                 13.72   data required time
                                 -8.11   data arrival time
-----------------------------------------------------------------------------
                                  5.62   slack (MET)



==========================================================================
global route report_check_types -max_slew -max_cap -max_fanout -violators
--------------------------------------------------------------------------

==========================================================================
global route max_slew_check_slack
--------------------------------------------------------------------------
0.08847511559724808

==========================================================================
global route max_slew_check_limit
--------------------------------------------------------------------------
1.5

==========================================================================
global route max_slew_check_slack_limit
--------------------------------------------------------------------------
0.0590

==========================================================================
global route max_fanout_check_slack
--------------------------------------------------------------------------
1.0000000150474662e+30

==========================================================================
global route max_fanout_check_limit
--------------------------------------------------------------------------
1.0000000150474662e+30

==========================================================================
global route max_capacitance_check_slack
--------------------------------------------------------------------------
0.015918675810098648

==========================================================================
global route max_capacitance_check_limit
--------------------------------------------------------------------------
0.021067000925540924

==========================================================================
global route max_capacitance_check_slack_limit
--------------------------------------------------------------------------
0.7556

==========================================================================
global route max_slew_violation_count
--------------------------------------------------------------------------
max slew violation count 0

==========================================================================
global route max_fanout_violation_count
--------------------------------------------------------------------------
max fanout violation count 0

==========================================================================
global route max_cap_violation_count
--------------------------------------------------------------------------
max cap violation count 0

==========================================================================
global route setup_violation_count
--------------------------------------------------------------------------
setup violation count 0

==========================================================================
global route hold_violation_count
--------------------------------------------------------------------------
hold violation count 0

==========================================================================
global route report_checks -path_delay max reg to reg
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_src1_value_a3[11]$_DFF_P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_Xreg_value_a4[14][29]$_SDFFE_PP0P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

  Delay    Time   Description
---------------------------------------------------------
   0.00    0.00   clock clk (rise edge)
   2.00    2.00   clock source latency
   0.00    2.00 ^ avsdpll/CLK (avsdpll)
   0.21    2.21 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.24    2.45 ^ clkbuf_2_3_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.29    2.74 ^ clkbuf_4_13__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.21    2.95 ^ clkbuf_leaf_95_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.00    2.95 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_1)
   0.40    3.35 ^ rvmyth.CPU_src1_value_a3[11]$_DFF_P_/Q (sky130_fd_sc_hd__dfxtp_1)
   0.13    3.47 v _05952_/Y (sky130_fd_sc_hd__inv_1)
   0.31    3.78 v _11479_/SUM (sky130_fd_sc_hd__ha_4)
   0.75    4.53 v _08072_/X (sky130_fd_sc_hd__or4_2)
   0.65    5.18 v _08077_/X (sky130_fd_sc_hd__or4_2)
   0.38    5.56 ^ _08078_/Y (sky130_fd_sc_hd__a211oi_4)
   0.18    5.75 v _08288_/Y (sky130_fd_sc_hd__o311ai_4)
   0.60    6.35 ^ _08482_/Y (sky130_fd_sc_hd__a2111oi_2)
   0.14    6.49 v _08483_/Y (sky130_fd_sc_hd__a2111oi_2)
   0.22    6.71 v _08484_/Y (sky130_fd_sc_hd__xnor2_2)
   1.09    7.80 ^ _08501_/Y (sky130_fd_sc_hd__a211oi_4)
   0.31    8.11 v _09030_/Y (sky130_fd_sc_hd__o21ai_0)
   0.00    8.11 v rvmyth.CPU_Xreg_value_a4[14][29]$_SDFFE_PP0P_/D (sky130_fd_sc_hd__dfxtp_1)
           8.11   data arrival time

  11.55   11.55   clock clk (rise edge)
   2.00   13.55   clock source latency
   0.00   13.55 ^ avsdpll/CLK (avsdpll)
   0.21   13.76 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.25   14.01 ^ clkbuf_2_0_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.27   14.28 ^ clkbuf_4_0__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.20   14.48 ^ clkbuf_leaf_3_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.00   14.48 ^ rvmyth.CPU_Xreg_value_a4[14][29]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
  -0.58   13.90   clock uncertainty
   0.00   13.90   clock reconvergence pessimism
  -0.18   13.72   library setup time
          13.72   data required time
---------------------------------------------------------
          13.72   data required time
          -8.11   data arrival time
---------------------------------------------------------
           5.62   slack (MET)



==========================================================================
global route report_checks -path_delay min reg to reg
--------------------------------------------------------------------------
Startpoint: rvmyth.CPU_Xreg_value_a4[1][21]$_SDFFE_PP0P_
            (rising edge-triggered flip-flop clocked by clk)
Endpoint: rvmyth.CPU_src1_value_a3[21]$_DFF_P_
          (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: min

  Delay    Time   Description
---------------------------------------------------------
   0.00    0.00   clock clk (rise edge)
   2.00    2.00   clock source latency
   0.00    2.00 ^ avsdpll/CLK (avsdpll)
   0.21    2.21 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.25    2.46 ^ clkbuf_2_0_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.27    2.73 ^ clkbuf_4_0__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.19    2.92 ^ clkbuf_leaf_1_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.00    2.92 ^ rvmyth.CPU_Xreg_value_a4[1][21]$_SDFFE_PP0P_/CLK (sky130_fd_sc_hd__dfxtp_1)
   0.36    3.29 ^ rvmyth.CPU_Xreg_value_a4[1][21]$_SDFFE_PP0P_/Q (sky130_fd_sc_hd__dfxtp_1)
   0.08    3.37 v _10331_/Y (sky130_fd_sc_hd__a22oi_1)
   0.13    3.50 ^ _10332_/Y (sky130_fd_sc_hd__nand3_1)
   0.15    3.65 v _10333_/Y (sky130_fd_sc_hd__o22ai_4)
   0.21    3.87 ^ _10336_/Y (sky130_fd_sc_hd__o21ai_0)
   0.00    3.87 ^ rvmyth.CPU_src1_value_a3[21]$_DFF_P_/D (sky130_fd_sc_hd__dfxtp_2)
           3.87   data arrival time

   0.00    0.00   clock clk (rise edge)
   2.00    2.00   clock source latency
   0.00    2.00 ^ avsdpll/CLK (avsdpll)
   0.21    2.21 ^ clkbuf_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.25    2.45 ^ clkbuf_2_2_0_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.30    2.75 ^ clkbuf_4_8__f_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.21    2.97 ^ clkbuf_leaf_26_clk_arun/X (sky130_fd_sc_hd__clkbuf_16)
   0.00    2.97 ^ rvmyth.CPU_src1_value_a3[21]$_DFF_P_/CLK (sky130_fd_sc_hd__dfxtp_2)
   0.92    3.89   clock uncertainty
   0.00    3.89   clock reconvergence pessimism
  -0.04    3.86   library hold time
           3.86   data required time
---------------------------------------------------------
           3.86   data required time
          -3.87   data arrival time
---------------------------------------------------------
           0.01   slack (MET)



==========================================================================
global route critical path target clock latency max path
--------------------------------------------------------------------------
0

==========================================================================
global route critical path target clock latency min path
--------------------------------------------------------------------------
0

==========================================================================
global route critical path source clock latency min path
--------------------------------------------------------------------------
0

==========================================================================
global route critical path delay
--------------------------------------------------------------------------
8.1059

==========================================================================
global route critical path slack
--------------------------------------------------------------------------
5.6176

==========================================================================
global route slack div critical path delay
--------------------------------------------------------------------------
69.302607

==========================================================================
global route report_power
--------------------------------------------------------------------------
Group                  Internal  Switching    Leakage      Total
                          Power      Power      Power      Power (Watts)
----------------------------------------------------------------
Sequential             4.83e-03   8.99e-04   1.04e-08   5.73e-03  30.3%
Combinational          2.06e-03   4.80e-03   2.40e-08   6.86e-03  36.4%
Clock                  3.28e-03   3.00e-03   2.82e-09   6.28e-03  33.3%
Macro                  0.00e+00   0.00e+00   0.00e+00   0.00e+00   0.0%
Pad                    0.00e+00   0.00e+00   0.00e+00   0.00e+00   0.0%
----------------------------------------------------------------
Total                  1.02e-02   8.69e-03   3.72e-08   1.89e-02 100.0%
                          53.9%      46.1%       0.0%
```

### Heatmap <br/>
In physical design of semiconductor chips, a heatmap is a visual representation that shows the distribution of a particular parameter (such as power, temperature, or congestion) across the chip's layout. It uses color coding to represent varying values of the parameter, with each color corresponding to a specific range or intensity of that parameter. Heatmaps are used to provide a quick, intuitive understanding of how different regions of the chip are behaving with respect to specific design goals or constraints.<br/>
The heatmap of the design can be found using:
```
make gui_place
```
![Screenshot from 2024-11-26 02-45-17](https://github.com/user-attachments/assets/8eaccee2-c903-46e2-b014-0282baa1531a)<br/>
![image](https://github.com/user-attachments/assets/e151755a-e815-4a9c-bb23-0ca9299fcd0b)<br/>
Zoomed view of all macros:<br/>
![Screenshot from 2024-11-26 02-47-09](https://github.com/user-attachments/assets/71596c7c-1906-496f-8d83-ce69fb5cf87f) <br/>
![Screenshot from 2024-11-26 02-47-24](https://github.com/user-attachments/assets/2089c47b-5d12-4cf0-80fa-9f47a2fd72d6) <br/>
![Screenshot from 2024-11-26 02-48-00](https://github.com/user-attachments/assets/d7acf37e-022e-440f-acf2-874edbb96947) <br/>
### QoR <br/>
QoR stands for Quality of Results. It refers to a set of metrics used to evaluate the quality of a chip's physical design after various stages of the design process. <br/>
For this, we see timing as a metric and use CTS. 
```
make gui_cts
```
![Screenshot from 2024-11-26 02-48-28](https://github.com/user-attachments/assets/770eb0f2-eb70-4f81-bafb-c64e506f91e5)
The path is highlighted below: <br/>
![Screenshot from 2024-11-26 02-50-20](https://github.com/user-attachments/assets/b051a0d8-2c2b-42ff-bc4c-8006aeff1473)

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
* https://www.udemy.com/course/vlsi-academy-sta-checks/?couponCode=3D425F2B9705E44298A9
* https://www.udemy.com/course/vlsi-academy-sta-checks-2/?couponCode=952614A18B598B2B0623
* https://github.com/arunkpv/vsd-hdp/blob/main/docs/Day_19.md#day-19---pvt-corner-analysis-post-synthesis-timing-of-the-risc-v-cpu-design
* https://github.com/fayizferosh/soc-design-and-planning-nasscom-vsd
* https://github.com/nickson-jose
  



  
