# Physical Design_2024
# TABLE OF CONTENTS
1. [GCC Compilation of C program](url)
2. [RISC V COMPILATION OF C PROGRAM](url)
## GCC Compilation of C program
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
  
  



  
