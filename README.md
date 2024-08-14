# Physical Design_2024
## TABLE OF CONTENTS
1. [GCC COMPILATION OF C PROGRAM](#gcc-compilation-of-c-program)
2. [RISC V COMPILATION OF C PROGRAM](#risc-v-compilation-of-c-program)
3. [SPIKE SIMULATION](#spike-simulation)
4. [RISC-V INSTRUCTION SET](#risc-v-instruction-set)
5. [ENCODING INSTRUCTIONS](#encoding-instructions)<br/>
6. [FUNCTIONAL SIMULATION OF RISC-V](#functional-simulation-of-risc-v)<br/>
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


## REFERENCES
* https://forgefunder.com/~kunal/riscv_workshop.vdi
* https://riscv.org/technical/specifications/
* https://fraserinnovations.com/risc-v/risc-v-instruction-set-explanation/
* https://github.com/vinayrayapati/rv32i
  



  
