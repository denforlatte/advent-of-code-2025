with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings; use Ada.Strings;

procedure Part1 is
   File: File_Type;
   Line: String (1 .. 100);
   Last: Natural;
   Is_Numbers: Boolean := False;
   Ranges_Low: Array (1 .. 400) of Integer;
   Ranges_High: Array (1 .. 400) of Integer;
   Number_of_Ranges: Natural := 0;
   Numbers: Array (1 .. 2000) of Integer;
   Number_of_Numbers: Natural := 0;
   Array_Pointer: Natural := 1;
begin
   Open (File, In_File, "test-input.txt");
   while not End_Of_File (File) loop
      Get_Line (File, Line, Last);

      if Is_Numbers = True then
         Numbers (Array_Pointer) := Integer'Value (Line (1 .. Last));
         Array_Pointer := Array_Pointer + 1;
         Number_of_Numbers := Array_Pointer;
      end if;

      -- This acts like a switch on the blank line to switch from parsing ranges to numbers.
      if Last = 0 then
         Is_Numbers := True;
         Array_Pointer := 1;
      end if;

      if Is_Numbers = False then
         declare
            Dash  : constant Positive :=
               Ada.Strings.Fixed.Index (Line (1 .. Last), "-");
            Low : Natural;
            High: Natural;
         begin
            Low  := Integer'Value (Line (1 .. Dash - 1));
            High := Integer'Value (Line (Dash + 1 .. Last));

            -- Add the ranges to a list. 
            Ranges_Low (Array_Pointer) := Low;
            Ranges_High (Array_Pointer) := High;
            Array_Pointer := Array_Pointer + 1;
            Number_of_Ranges := Array_Pointer;
         end;
      end if;
   end loop;

   for index in 1..Number_of_Numbers loop
      Put_Line(Integer'Image (Numbers (index)));
   end loop;
   Close (File);
end Part1;





-- Steps for merging ranges but I don't think I want to.
   -- 1. Loop through the list of ranges.
   -- 2. For each range, loop through the REST OF the ranges.
   -- 3. If there is overlap, take the lowest start and highest end.
   -- 4. Remove the overlapping range from the list.
