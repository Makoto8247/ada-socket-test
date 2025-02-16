with Ada.Streams;
with Ada.Text_IO; use Ada.Text_IO;
with GNAT.Sockets; use GNAT.Sockets;

procedure Server_Test is
   Server_Socket     : Socket_Type;
   Server_Address    : Sock_Addr_Type;
   Client_Socket     : Socket_Type;
   Client_Address    : Sock_Addr_Type;
   Buffer            : Ada.Streams.Stream_Element_Array (1 .. 100);
   Offset            : Ada.Streams.Stream_Element_Offset;
begin
   Create_Socket (Server_Socket);
   Server_Address.Addr := GNAT.Sockets.Inet_Addr ("127.0.0.1");
   Server_Address.Port := 8000;

   Bind_Socket (Server_Socket, Server_Address);
   Listen_Socket (Server_Socket);
   Put_Line ("Listening..");

   Accept_Socket (Server_Socket, Client_Socket, Client_Address);

   Receive_Socket (Client_Socket, Buffer, Offset, Client_Address);

   for J in 1 .. Offset loop
      Put (Character'Val (Integer (Buffer (J)))'Img);
   end loop;
   Put_Line ("");
   Close_Socket (Client_Socket);
end Server_Test;
