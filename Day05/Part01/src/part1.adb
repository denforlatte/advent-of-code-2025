with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings; use Ada.Strings;

procedure Part1 is
   File: File_Type;
   Line: String (1 .. 100);
   Last: Natural;
begin
   Put_Line ("Hello world!");
   Open (File, In_File, "test-input.txt");
   while not End_Of_File (File) loop
      Get_Line (File, Line, Last);

      declare
         Dash  : constant Positive :=
            Ada.Strings.Fixed.Index (Line (1 .. Last), "-");
         Low : Natural;
         High: Natural;
      begin
         Low  := Integer'Value (Line (1 .. Dash - 1));
         High := Integer'Value (Line (Dash + 1 .. Last));

         Put_Line
         (Integer'Image (Low) & " →" &
            Integer'Image (High));
      end;
   end loop;
   Close (File);
end Part1;