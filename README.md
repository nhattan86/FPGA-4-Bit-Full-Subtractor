# FPGA-4-Bit-Full-Subtractor

This code appears to be implementing a **4-Bit Full Subtractor** using **1-Bit Full Subtractor** components in VHDL. Here’s a detailed analysis of each part:

### Code Structure and Components

#### 1. **Libraries**:
   ```vhdl
   library ieee;
   use ieee.std_logic_1164.all;
   ```
   This imports the IEEE library and the `std_logic_1164` package, which are necessary for basic logic operations in VHDL.

#### 2. **Entity and Architecture for 4-Bit Subtractor (`BIT4`)**:
   ```vhdl
   entity BIT4 is
       port (A, B: in std_logic_vector (3 downto 0);
             CIN: in std_logic;
             S: out std_logic_vector (3 downto 0);
             COUT: out std_logic);
   end BIT4;
   ```
   - **Entity Name**: `BIT4`
   - **Ports**:
     - `A` and `B` are 4-bit inputs (subtractor and minuend respectively).
     - `CIN` is the carry-in (or borrow-in) for the least significant bit.
     - `S` is the 4-bit output vector that stores the difference.
     - `COUT` is the final carry-out (borrow-out) after the last bit operation.
   
   ```vhdl
   architecture H of BIT4 is
       component BIT1 is
           port (A, B, CIN: in std_logic;
                 S, COUT: out std_logic);
       end component;
       signal t1, t2, t3: std_logic;
   begin
       m1: BIT1 port map (A(0), B(0), CIN, S(0), t1);
       m2: BIT1 port map (A(1), B(1), t1, S(1), t2);
       m3: BIT1 port map (A(2), B(2), t2, S(2), t3);
       m4: BIT1 port map (A(3), B(3), t3, S(3), COUT);
   end H;
   ```
   - **Architecture Name**: `H`
   - **Components and Signals**:
     - `BIT1` is a 1-bit full subtractor component that will be instantiated 4 times to create a 4-bit subtractor.
     - Intermediate signals `t1`, `t2`, and `t3` are used to pass the carry-out (borrow-out) of one stage to the carry-in (borrow-in) of the next stage.
   - **Logic**:
     - Each instance of `BIT1` computes the subtraction for one bit, passing the borrow signal (`COUT`) to the next stage.
     - The result for each bit is stored in `S`, and the final `COUT` represents the overall borrow-out.

#### 3. **Entity and Architecture for 1-Bit Subtractor (`BIT1`)**:
   ```vhdl
   entity BIT1 is
       port (A, B, CIN: in std_logic;
             S, COUT: out std_logic);
   end BIT1;
   architecture T of BIT1 is
   begin
       S <= A XOR B XOR CIN;
       COUT <= (((not A) AND B) OR (B AND CIN) OR (CIN AND (not A)));
   end T;
   ```
   - **Entity Name**: `BIT1`
   - **Ports**:
     - `A`, `B`, and `CIN` are single-bit inputs.
     - `S` is the single-bit output representing the difference.
     - `COUT` is the single-bit output representing the borrow-out.
   - **Logic**:
     - The difference `S` is calculated with `A XOR B XOR CIN`.
     - The borrow-out `COUT` is calculated with `(((not A) AND B) OR (B AND CIN) OR (CIN AND (not A)))`, which correctly represents a 1-bit full subtractor.

#### **Description**:
This VHDL code defines a **4-Bit Full Subtractor** using instances of a **1-Bit Full Subtractor** component. It takes two 4-bit binary inputs, `A` and `B`, and a borrow input (`CIN`) to calculate the 4-bit binary difference (`S`) and the final borrow-out (`COUT`).

1. **Components**:
   - `BIT4`: The main entity, representing the 4-bit full subtractor.
   - `BIT1`: A subcomponent that performs a 1-bit full subtraction, used as a building block.

2. **Operation**:
   - Each bit of the input vectors `A` and `B` is processed sequentially from the least significant to the most significant bit using instances of the `BIT1` component.
   - Intermediate signals `t1`, `t2`, and `t3` carry the borrow output from one bit to the borrow input of the next bit.
   - The final `COUT` represents the overall borrow for the subtraction of the 4-bit numbers.

3. **Inputs**:
   - `A` and `B`: 4-bit binary numbers.
   - `CIN`: Initial carry-in (borrow-in) for the least significant bit.

4. **Outputs**:
   - `S`: 4-bit difference result.
   - `COUT`: Final carry-out (borrow-out), indicating if an additional borrow is required.

This code can be synthesized on an FPGA and used in digital circuits that require a 4-bit subtraction operation.

https://www.youtube.com/watch?v=wMWvTKmp8aM&t=54s
