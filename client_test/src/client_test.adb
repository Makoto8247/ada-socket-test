with Ada.Streams; use Ada.Streams;
with Ada.Text_IO; use Ada.Text_IO;
with GNAT.Sockets; use GNAT.Sockets;

procedure Client_Test is
   Output            : constant String := "Hello Test";
   Server_Address    : Sock_Addr_Type;
   Client_Socket     : Socket_Type;
   Client_Address    : Sock_Addr_Type;
   Buffer            : Stream_Element_Array (1 .. Output'Length);
   Offset            : Stream_Element_Offset;
begin
   Create_Socket (Client_Socket);

   -- サーバーのアドレス設定
   Server_Address.Addr := Inet_Addr ("127.0.0.1");
   Server_Address.Port := 8000;

   -- 文字列をバイト列に変換
   for I in Output'Range loop
      Buffer (Stream_Element_Offset (I)) :=
         Stream_Element (
            Character'Pos (
               Output (I)
            )
         );
   end loop;

   Connect_Socket (Client_Socket, Server_Address);

   Send_Socket (Client_Socket, Buffer, Offset, Server_Address);

   Put_Line ("Send bytes: " & Stream_Element_Offset'Image (Offset));
   Close_Socket (Client_Socket);
end Client_Test;
