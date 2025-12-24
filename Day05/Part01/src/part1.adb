with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings; use Ada.Strings;

procedure Part1 is
   File: File_Type;
   Line: String (1 .. 200);
   Last: Natural;
   Is_Numbers: Boolean := False;
   Ranges_Low: Array (1 .. 400) of Long_Integer;
   Ranges_High: Array (1 .. 400) of Long_Integer;
   Number_Of_Ranges: Natural := 0;
   Numbers: Array (1 .. 2000) of Long_Integer;
   Number_Of_Numbers: Natural := 0;
   Array_Pointer: Natural := 1;
   Number_Of_Matches: Natural := 0;
begin
   Open (File, In_File, "input.txt");
   while not End_Of_File (File) loop
      Get_Line (File, Line, Last);

      if Is_Numbers = True then
         Numbers (Array_Pointer) := Long_Integer'Value (Line (1 .. Last));
         Number_Of_Numbers := Array_Pointer;
         Array_Pointer := Array_Pointer + 1;
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
            Low : Long_Integer;
            High: Long_Integer;
         begin
            Low  := Long_Integer'Value (Line (1 .. Dash - 1));
            High := Long_Integer'Value (Line (Dash + 1 .. Last));

            -- Add the ranges to a list.
            Ranges_Low (Array_Pointer) := Low;
            Ranges_High (Array_Pointer) := High;
            Number_Of_Ranges := Array_Pointer;
            Array_Pointer := Array_Pointer + 1;
         end;
      end if;
   end loop;

   for i in 1..Number_Of_Numbers loop
      declare
         Is_In_Range : Boolean := false;
      begin
         for j in 1..Number_Of_Ranges loop
            if Is_In_Range = False then
               if Numbers (i) >= Ranges_Low (j) and Numbers (i) <= Ranges_High (j) then
                  Is_In_Range := True;
               end if;
            end if;
         end loop;

         if Is_In_Range then
            Put_Line ("Is in range: " & Long_Integer'Image (Numbers (i)));
            Number_Of_Matches := Number_Of_Matches + 1;
         end if;
      end;
   end loop;

   Put_Line ("Number of matches: " & Integer'Image (Number_Of_Matches));
   Close (File);
end Part1;


-- 511


-- Steps for merging ranges but I don't think I want to.
   -- 1. Loop through the list of ranges.
   -- 2. For each range, loop through the REST OF the ranges.
   -- 3. If there is overlap, take the lowest start and highest end.
   -- 4. Remove the overlapping range from the list.
