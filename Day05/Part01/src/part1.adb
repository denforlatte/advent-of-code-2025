with Ada.Text_IO; use Ada.Text_IO;

-- Still having build issues.
procedure Part1 is
   File: File_Type;
   Line: String (1 .. 100);
   Last: Natural;
begin
   Put_Line ("Hello world!");
   Open (File, In_File, "input.txt");
   while not End_Of_File (File) loop
      Get_Line (File, Line, Last);
      Put_Line (Line (1 .. Last));
   end loop;
   Close (File);
end Part1;
