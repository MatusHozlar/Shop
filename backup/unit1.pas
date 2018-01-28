unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Math, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ValEdit, ComCtrls, Grids, ExtCtrls, Spin, EditBtn;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    pocet: TFloatSpinEdit;
    predaj: TFloatSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ID: TEdit;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AhojChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pocetChange(Sender: TObject);
    procedure predajChange(Sender: TObject);
    procedure predajClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;
  type TTranslateString = type string;
   type
  hodnoty=record
    kod:integer;
    nazov:string;
    nakup:float;
    predaj:float;
  end;
var
  Form1: TForm1;
  sklad,cena,tovar,transakcia,statistiky:textfile;
  pole:array of hodnoty;
  riadky,prikaz:integer;
  aktual:boolean;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i,z,k:integer;c:char;cislo,price,namee:string;
begin
ShowMessage('Program je iba v Alpha stadiu riesenia - niektore funkcie nemusia fungovat spravne!' );
Label1.Caption:='ID produktu';
Label2.Caption:='Nakupna cena';
label3.Caption:='Predajna cena';

//nacitanie suborov

cislo:='';
price:='';
namee:='';
  AssignFile(sklad,'tovar.txt');
  AssignFile(cena,'cennik.txt');
  prikaz:=0;

begin
//tovar
Reset(sklad);
  ReadLn(sklad,riadky);
  SetLength(pole,riadky);
  StringGrid1.RowCount:=riadky+1;
  StringGrid1.ColCount:=4;
  for i:=0 to riadky-1 do
  begin
    Read(sklad,c);
    repeat
        cislo:=cislo+c;
      Read(sklad,c);
    until c=';';
    pole[i].kod:=StrToInt(cislo);
    cislo:='';
    ReadLn(sklad,pole[i].nazov);
    StringGrid1.Cells[0,i+1]:=IntToStr(pole[i].kod);
    StringGrid1.Cells[1,i+1]:=pole[i].nazov;
  end;


  ReWrite(sklad);
  WriteLn(sklad,riadky);
  for k:=0 to riadky-1 do
  begin
    WriteLn(sklad,pole[k].kod,';',pole[k].nazov);
    StringGrid1.Cells[0,k+1]:=IntToStr(pole[k].kod);
    StringGrid1.Cells[1,k+1]:=pole[k].nazov;


  end;
  CloseFile(sklad);
end;
end;

procedure TForm1.pocetChange(Sender: TObject);
begin

end;

procedure TForm1.predajChange(Sender: TObject);
begin

end;

procedure TForm1.predajClick(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i,z,k:integer;c:char;cislo,price,namee:string;
begin
//nacitanie suborov

cislo:='';
price:='';
namee:='';
  AssignFile(sklad,'tovar.txt');
  AssignFile(cena,'cennik.txt');
  prikaz:=0;

begin
//tovar
Reset(sklad);
  ReadLn(sklad,riadky);
  SetLength(pole,riadky);
  StringGrid1.RowCount:=riadky+1;
  StringGrid1.ColCount:=4;
  for i:=0 to riadky-1 do
  begin
    Read(sklad,c);
    repeat
        cislo:=cislo+c;
      Read(sklad,c);
    until c=';';
    pole[i].kod:=StrToInt(cislo);
    cislo:='';
    ReadLn(sklad,pole[i].nazov);
    StringGrid1.Cells[0,i+1]:=IntToStr(pole[i].kod);
    StringGrid1.Cells[1,i+1]:=pole[i].nazov;
  end;


  ReWrite(sklad);
  WriteLn(sklad,riadky);
  for k:=0 to riadky-1 do
  begin
    WriteLn(sklad,pole[k].kod,';',pole[k].nazov);
    StringGrid1.Cells[0,k+1]:=IntToStr(pole[k].kod);
    StringGrid1.Cells[1,k+1]:=pole[k].nazov;


  end;
  CloseFile(sklad);
end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var z,cisla:boolean;i,k:integer;
begin

//Nakupna cena

aktual:=false;
z:=false;
i:=0;
repeat
  cisla:=true;
  if (ID.Text = pole[i].nazov) then
  begin
    z:=true;
    if StrToFloat(Pocet.Text)>0 then
    begin
      pole[i].nakup:=pole[i].nakup+strtofloat(pocet.text);
      ReWrite(cena);
      WriteLn(cena,riadky);
      for k:=0 to riadky-1 do
      begin
        WriteLn(cena,pole[k].kod,';',pole[k].nakup);
      end;
      CloseFile(cena);

    end
    else
      ShowMessage('Zadajte kladne cislo');
  end
  else
  begin
    for k:=1 to length(ID.Text) do
    begin
      if (ID.Text[k] < '0') or (ID.Text[k] > '9') then
      begin
        cisla:=false;
      end;
    end;
    if cisla=true then
    begin
      if StrToInt(ID.Text)=pole[i].kod then
      begin
        z:=true;
        if strtofloat(Pocet.Text)>0 then
        begin
          pole[i].nakup:=pole[i].nakup+strtofloat(Pocet.text);
          ReWrite(cena);
          WriteLn(cena,riadky);
          for k:=0 to riadky-1 do
          begin
            StringGrid1.Cells[2,k+1]:=floattostr(pole[k].nakup);
          end;
          CloseFile(cena);


        end
        else
          ShowMessage('Zadajte kladne cislo');
      end;
    end;
  end;
  inc(i);
until (z=true) or (i=riadky);
if z=false then
  ShowMessage('Zadajte kod produktu nie je v databaze');
aktual:=true;

//predajna cena

aktual:=false;
z:=false;
i:=0;
repeat
  cisla:=true;
  if (ID.Text = pole[i].nazov) then
  begin
    z:=true;
    if StrToint(predaj.Text)>0 then
    begin
      pole[i].predaj:=pole[i].predaj+strtofloat(predaj.Text);
      ReWrite(cena);
      WriteLn(cena,riadky);
      for k:=0 to riadky-1 do

      CloseFile(cena);
    end
    else
      ShowMessage('Zadajte kladne cislo');
  end
  else
  begin
    for k:=1 to length(ID.Text) do
    begin
      if (ID.Text[k] < '0') or (ID.Text[k] > '9') then
      begin
        cisla:=false;
      end;
    end;
    if cisla=true then
    begin
      if StrToInt(ID.Text)=pole[i].kod then
      begin
        z:=true;
        if StrTofloat(predaj.Text)>0 then
        begin
          pole[i].predaj:=pole[i].predaj+strtofloat(predaj.Text);
          ReWrite(cena);
          WriteLn(cena,riadky);
          for k:=0 to riadky-1 do
          begin
            StringGrid1.Cells[3,k+1]:=floattostr(pole[k].predaj);
          end;
          CloseFile(cena);

        end
        else
          ShowMessage('Zadajte kladné množstvo tovaru');
      end;
    end;
  end;
  inc(i);
until (z=true) or (i=riadky);
end;

procedure TForm1.Button2Click(Sender: TObject);
var k,i:integer;
begin
k:=0;
begin
     Reset(cena);
     ReWrite(cena);
          WriteLn(cena,riadky);
          for k:=0 to riadky-1 do
          begin
  WriteLn(cena,pole[k].kod,';',floattostr(pole[k].nakup),';',floattostr(pole[k].predaj),';');
end;
end;
CloseFile(cena);
end;

procedure TForm1.AhojChange(Sender: TObject);
begin

end;

procedure TForm1.Button3Click(Sender: TObject);
var z,cisla:boolean;i,k:integer;
begin

//Nakupna cena

aktual:=false;
z:=false;
i:=0;
repeat
  cisla:=true;
  if (ID.Text = pole[i].nazov) then
  begin
    z:=true;
    if StrToInT(Pocet.Text)>0 then
    begin
      pole[i].nakup:=pole[i].nakup+strtofloat(pocet.text);
      ReWrite(cena);
      WriteLn(cena,riadky);
      for k:=0 to riadky-1 do
      begin
        WriteLn(cena,pole[k].kod,';',pole[k].nakup);
      end;
      CloseFile(cena);

    end
    else
      ShowMessage('Zadajte kladne cislo');
  end
  else
  begin
    for k:=1 to length(ID.Text) do
    begin
      if (ID.Text[k] < '0') or (ID.Text[k] > '9') then
      begin
        cisla:=false;
      end;
    end;
    if cisla=true then
    begin
      if StrToInt(ID.Text)=pole[i].kod then
      begin
        z:=true;
        if strtofloat(Pocet.Text)>0 then
        begin
          pole[i].nakup:=pole[i].nakup+strtofloat(Pocet.text);
          ReWrite(cena);
          WriteLn(cena,riadky);
          for k:=0 to riadky-1 do
          begin
            StringGrid1.Cells[2,k+1]:=floattostr(pole[k].nakup);
          end;
          CloseFile(cena);


        end
        else
          ShowMessage('Zadajte kladne cislo');
      end;
    end;
  end;
  inc(i);
until (z=true) or (i=riadky);
if z=false then
  ShowMessage('Zadajte kod produktu nie je v databaze');
aktual:=true;
end;

procedure TForm1.Button4Click(Sender: TObject);
var z,cisla:boolean;i,k:integer;
begin
  aktual:=false;
z:=false;
i:=0;
repeat
  cisla:=true;
  if (ID.Text = pole[i].nazov) then
  begin
    z:=true;
    if StrToint(predaj.Text)>0 then
    begin
      pole[i].predaj:=pole[i].predaj+strtofloat(predaj.Text);
      ReWrite(cena);
      WriteLn(cena,riadky);
      for k:=0 to riadky-1 do

      CloseFile(cena);
    end
    else
      ShowMessage('Zadajte kladne cislo');
  end
  else
  begin
    for k:=1 to length(ID.Text) do
    begin
      if (ID.Text[k] < '0') or (ID.Text[k] > '9') then
      begin
        cisla:=false;
      end;
    end;
    if cisla=true then
    begin
      if StrToInt(ID.Text)=pole[i].kod then
      begin
        z:=true;
        if StrTofloat(predaj.Text)>0 then
        begin
          pole[i].predaj:=pole[i].predaj+strtofloat(predaj.Text);
          ReWrite(cena);
          WriteLn(cena,riadky);
          for k:=0 to riadky-1 do
          begin
            StringGrid1.Cells[3,k+1]:=floattostr(pole[k].predaj);
          end;
          CloseFile(cena);

        end
        else
          ShowMessage('Zadajte kladné množstvo tovaru');
      end;
    end;
  end;
  inc(i);
until (z=true) or (i=riadky);
end;

end.
