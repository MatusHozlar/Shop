unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Hladaj: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
   type
     zaznam=record
       nazov:string;
       kod:integer;

     end;
     const
      n=10;
var
  Form1: TForm1;
 vsetko :array[1..N] of zaznam;
 znak:char;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var subor: textfile;
    i:integer;
begin
  i:=0;
   assignfile(subor,'Cenotvorba.txt');
   reset(subor);
   for i:=1 to N do
     begin
       read(subor,znak);
        repeat
        vsetko[i].nazov:=vsetko[i].nazov+znak;
        read(subor,znak);
       until znak=' ';


     read(subor,vsetko[i].kod);

      memo1.append(inttostr(vsetko[i].kod)+' '+vsetko[i].nazov);
    end;
end;

end.
