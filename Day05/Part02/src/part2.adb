with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings; use Ada.Strings;

procedure Part2 is
   File: File_Type;
   Line: String (1 .. 200);
   Last: Natural;
   Is_Numbers: Boolean := False;
   Ranges_Low: Array (1 .. 400) of Long_Integer;
   Ranges_High: Array (1 .. 400) of Long_Integer;
   Number_Of_Ranges: Natural := 0;
   Ranges_Low_Collapsed: Array (1 .. 400) of Long_Integer;
   Ranges_High_Collapsed: Array (1 .. 400) of Long_Integer;
   Number_Of_Ranges_Collapsed: Natural := 0;
   Array_Pointer: Natural := 1;
   Number_Of_Matches: Long_Integer := 0;
begin
   Open (File, In_File, "input.txt");
   while not End_Of_File (File) loop
      Get_Line (File, Line, Last);

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

   declare
      Low: Long_Integer;
      High: Long_Integer;
      Is_Merged: Boolean;
   begin
      for i in 1..Number_Of_Ranges loop
         if Ranges_Low (i) /= 0 and Ranges_High (i) /= 0 then
            Low := Ranges_Low (i);
            High := Ranges_High (i);
            Is_Merged := False;

            declare
               Is_Changed_This_While_Loop: Boolean := True;
               Is_Merging: Boolean := False;
            begin
               while Is_Changed_This_While_Loop = True loop
                  Is_Changed_This_While_Loop := False;

                  for j in i..Number_Of_Ranges loop
                     Is_Merging := False;
                     Put_Line ("Testing range: " & Long_Integer'Image (Ranges_Low(j)) & " -> " & Long_Integer'Image (Ranges_High (j)));
                     if Ranges_Low (j) /= 0 and Ranges_Low (j) <= Low and Ranges_High (j) >= Low then
                        Low := Ranges_Low (j);
                        Put_Line ("New Low:" & Long_Integer'Image (Ranges_Low (j)));
                        Is_Merging := true;
                     end if;
                     if Ranges_High (j) /= 0 and Ranges_High (j) >= High and Ranges_Low (j) <= High then
                        High := Ranges_High (j);
                        Put_Line ("New High:" & Long_Integer'Image (Ranges_High (j)));
                        Is_Merging := true;
                     end if;
                     if Ranges_Low (j) /= 0 and Ranges_High (j) <= High and Ranges_Low (j) >= Low then
                        Put_Line ("Deleting fully contained ranges");
                        Is_Merging := true;
                     end if;

                     -- Zero merged ranges to "delete" then.
                     if Is_Merging then
                        Is_Changed_This_While_Loop := True;
                        Is_Merged := True;
                        Ranges_Low (j) := 0;
                        Ranges_High (j) := 0;
                     end if;
                  end loop;
               end loop;
            end;

            Ranges_Low_Collapsed (Number_Of_Ranges_Collapsed + 1) := Low;
            Ranges_High_Collapsed (Number_Of_Ranges_Collapsed + 1) := High;
            Number_Of_Ranges_Collapsed := Number_Of_Ranges_Collapsed + 1;
         end if;
      end loop;
   end;

   for i in 1..Number_Of_Ranges_Collapsed loop
      Put_Line (Long_Integer'Image (Ranges_Low_Collapsed (i)) & " -> " & Long_Integer'Image (Ranges_High_Collapsed (i)));
      Put_Line ("Adding: " & Long_Integer'Image (Ranges_High_Collapsed (i) - Ranges_Low_Collapsed (i) + 1));
      Number_Of_Matches := Ranges_High_Collapsed (i) - Ranges_Low_Collapsed (i) + 1 + Number_Of_Matches;
   end loop;
   Put_Line ("Number of fresh ids: " & Long_Integer'Image (Number_Of_Matches));
   Close (File);
end Part2;


-- 394060826678121 - Too high
-- 353916876101465 - Too high - Missed deleting ranges that were fully contained within another range
-- 350939902751909 - Correct!


-- Steps for merging ranges but I don't think I want to.
   -- 1. Loop through the list of ranges.
   -- 2. For each range, loop through the REST OF the ranges.
   -- 3. If there is overlap, take the lowest start and highest end.
   -- 4. Remove the overlapping range from the list.




-- Alternative idea
   -- Order ranges by low
   -- Keep a count of fresh ids
   -- Keep a count of where we are in the ids.