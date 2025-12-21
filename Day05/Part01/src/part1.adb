with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings; use Ada.Strings;

procedure Part1 is
   File: File_Type;
   Line: String (1 .. 100);
   Last: Natural;
   Is_Numbers: Boolean := False;
begin
   Put_Line ("Hello world!");
   Open (File, In_File, "test-input.txt");
   while not End_Of_File (File) loop
      Get_Line (File, Line, Last);
      Put_Line("Read line: " & "'" & Line (1 .. Last) & "'");

      if Is_Numbers = False then
         declare
            Dash  : constant Positive :=
               Ada.Strings.Fixed.Index (Line (1 .. Last), "-");
            Low : Natural;
            High: Natural;
         begin
            Low  := Integer'Value (Line (1 .. Dash - 1));
            High := Integer'Value (Line (Dash + 1 .. Last));

            Put_Line (Integer'Image (Low) & " →" & Integer'Image (High));
         end;
      end if;

      -- This acts like a switch on the blank line to switch from parsing ranges to numbers.
      if Last = 0 then
         Is_Numbers := True;
      end if;

      if Is_Numbers = True then
         Put_Line ("Ignoring line: " & Line (1 .. Last));
      end if;
   end loop;
   Close (File);
end Part1;