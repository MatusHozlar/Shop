unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Math, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Grids, ExtCtrls, Spin, EditBtn;

type

  { TCenotvorba }

  TCenotvorba = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label4: TLabel;
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
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure delete(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pocetChange(Sender: TObject);
    procedure predajChange(Sender: TObject);
    procedure predajClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Kontrola;
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
  const
  path='';  //\\comenius\public\market\timb\
var
  Cenotvorba: TCenotvorba;
  sklad,cena,tovar,transakcia,statistiky:textfile;
  pole:array of hodnoty;
  riadky,prikaz:integer;
  aktual:boolean;
  editcennik,edittovar:LongInt;
implementation

{$R *.lfm}

{ TCenotvorba }

procedure TCenotvorba.FormCreate(Sender: TObject);
var i,k:integer;c:char;cislo:string;
begin
DecimalSeparator:='.';
AssignFile(sklad,'tovar.txt');
AssignFile(cena,'cennik.txt');
{ShowMessage('Program je iba v Alpha stadiu riesenia - niektore funkcie nemusia fungovat spravne!' );}
Label1.Caption:='ID produktu';
Label2.Caption:='Nakupna cena';
label3.Caption:='Predajna cena';
Label4.Caption:='Vymazat nakupnu/predajnu cenu zvoleneho produktu';

//nacitanie suborov

cislo:='';
  AssignFile(sklad,'tovar.txt');
  AssignFile(cena,'cennik.txt');
  editcennik:=FileAge('CENNIK.txt');
  edittovar:=FileAge('TOVAR.txt');
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
procedure TCenotvorba.pocetChange(Sender: TObject);
begin

end;

procedure TCenotvorba.predajChange(Sender: TObject);
begin

end;

procedure TCenotvorba.predajClick(Sender: TObject);
begin

end;

procedure TCenotvorba.Timer1Timer(Sender: TObject);
var i,k:integer;c:char;cislo:string;
begin

if aktual=true then
    Kontrola;



//nacitanie suborov

cislo:='';
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

procedure TCenotvorba.Button1Click(Sender: TObject);
var z,cisla:boolean;i,k:integer;
begin
  kontrola;
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
      pole[i].nakup:=strtofloat(pocet.text);
      for k:=0 to riadky-1 do
      begin
      StringGrid1.Cells[2,k+1]:=floattostr(pole[k].nakup);
      end;
      ShowMessage('Zadaj kladnu cenu');
    end
    else


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
          pole[i].nakup:=strtofloat(Pocet.text);
          for k:=0 to riadky-1 do
          begin
            StringGrid1.Cells[2,k+1]:=floattostr(pole[k].nakup);
          end;
           ShowMessage('Zadaj kladnu cenu');

        end
        else

      end;
    end;
  end;
  inc(i);
until (z=true) or (i=riadky);
if z=false then
  ShowMessage('Zadany kod produktu nie je v databaze');
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
    if StrToFloat(predaj.Text)>0 then
    begin
      pole[i].predaj:=strtofloat(predaj.Text);
      for k:=0 to riadky-1 do
      begin
      StringGrid1.Cells[3,k+1]:=floattostr(pole[k].predaj);
      end;
    end
    else
      ShowMessage('Zadaj kladnu cenu');
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
          pole[i].predaj:=strtofloat(predaj.Text);
          for k:=0 to riadky-1 do
          begin
            StringGrid1.Cells[3,k+1]:=floattostr(pole[k].predaj);
          end;

        end
        else
          ShowMessage('Zadaj kladnu cenu');
      end;
    end;
  end;
  inc(i);
until (z=true) or (i=riadky);
if z=false then
 // ShowMessage('Zadany kod produktu nie je v databaze');
aktual:=true;
end;

procedure TCenotvorba.Button2Click(Sender: TObject);
var k:integer;
begin
kontrola;
k:=0;
begin
     Reset(cena);
     ReWrite(cena);
          WriteLn(cena,riadky);
          for k:=0 to riadky-1 do
          begin
  WriteLn(cena,pole[k].kod,';',FloatToStrF(pole[k].nakup,fffixed,30,2),';',FloatToStrF(pole[k].predaj,fffixed,30,2),';');
end;
end;
CloseFile(cena);
ShowMessage('Zmeny boli ulozene!');
end;

procedure TCenotvorba.AhojChange(Sender: TObject);
begin

end;

procedure TCenotvorba.Button3Click(Sender: TObject);
var z,cisla:boolean;i,k:integer;
begin
  kontrola;
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
      pole[i].nakup:=strtofloat(pocet.text);
      for k:=0 to riadky-1 do
      begin
      StringGrid1.Cells[2,k+1]:=floattostr(pole[k].nakup);
      end;
    end
    else
      ShowMessage('Zadaj kladnu cenu');
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
          pole[i].nakup:=strtofloat(Pocet.text);
          for k:=0 to riadky-1 do
          begin
            StringGrid1.Cells[2,k+1]:=floattostr(pole[k].nakup);
          end;
          //CloseFile(cena);


        end
        else
          ShowMessage('Zadaj kladnu cenu');
      end;
    end;
  end;
  inc(i);
until (z=true) or (i=riadky);
if z=false then
  ShowMessage('Zadany kod produktu nie je v databaze');
aktual:=true;
end;

procedure TCenotvorba.Button4Click(Sender: TObject);
var z,cisla:boolean;i,k:integer;
begin
kontrola;
  aktual:=false;
z:=false;
i:=0;
repeat
  cisla:=true;
  if (ID.Text = pole[i].nazov) then
  begin
    z:=true;
    if StrToFloat(predaj.Text)>0 then
    begin
      pole[i].predaj:=strtofloat(predaj.Text);
      for k:=0 to riadky-1 do
      begin
      StringGrid1.Cells[3,k+1]:=floattostr(pole[k].predaj);
      end;
    end
    else
      ShowMessage('Zadaj kladnu cenu');
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
          for k:=0 to riadky-1 do
          begin
            StringGrid1.Cells[3,k+1]:=floattostr(pole[k].predaj);
          end;

        end
        else
          ShowMessage('Zadaj kladnu cenu');
      end;
    end;
  end;
  inc(i);
until (z=true) or (i=riadky);
if z=false then
  ShowMessage('Zadany kod produktu nie je v databaze');
aktual:=true;
end;

procedure TCenotvorba.Button5Click(Sender: TObject);
var z,cisla:boolean;i,k:integer;
begin
  kontrola;
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
      pole[i].nakup:=0;
      for k:=0 to riadky-1 do
      begin
      StringGrid1.Cells[2,k+1]:=floattostr(pole[k].nakup);
      end;
    end
    else
      ShowMessage('Pre potvrdenie zadajte lubovolnu kladnu hodnotu do policka nakupna cena');
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
          pole[i].nakup:=0;
          for k:=0 to riadky-1 do
          begin
            StringGrid1.Cells[2,k+1]:=floattostr(pole[k].nakup);
          end;
        end
        else
          ShowMessage('Pre potvrdenie zadajte lubovolnu kladnu hodnotu do policka nakupna cena');
      end;
    end;
  end;
  inc(i);
until (z=true) or (i=riadky);
if z=false then
  ShowMessage('Zadany kod produktu nie je v databaze');
aktual:=true;
end;

procedure TCenotvorba.Button6Click(Sender: TObject);
var z,cisla:boolean;i,k:integer;
begin
kontrola;
  aktual:=false;
z:=false;
i:=0;
repeat
  cisla:=true;
  if (ID.Text = pole[i].nazov) then
  begin
    z:=true;
    if StrToFloat(predaj.Text)>=0 then
    begin
      pole[i].predaj:=0;
      for k:=0 to riadky-1 do
      begin
      StringGrid1.Cells[3,k+1]:=floattostr(pole[k].predaj);
      end;
    end
    else
      ShowMessage('Pre potvrdenie zadajte lubovolnu kladnu hodnotu do policka predajna cena');
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
          pole[i].predaj:=0;
          for k:=0 to riadky-1 do
          begin
            StringGrid1.Cells[3,k+1]:=floattostr(pole[k].predaj);
          end;
        end
        else
          ShowMessage('Pre potvrdenie zadajte lubovolnu kladnu hodnotu do policka predajna cena');
      end;
    end;
  end;
  inc(i);
until (z=true) or (i=riadky);
if z=false then
  ShowMessage('Zadany kod produktu nie je v databaze');
aktual:=true;
end;

procedure TCenotvorba.delete(Sender: TObject);
begin

end;

procedure TCenotvorba.Kontrola;
var lock:boolean;
    F1,F2,F3:integer;
   //begin
   //if (FileExists(path+'Tovar.txt')=true) and (FileExists(path+'CENNIK.txt')=true) and (FileExists(path+'TOVAR.txt')=true) then
   //begin
   //if not (FileExists(path+'SKLAD_LOCK.txt')=true) or (FileExists(path+'CENNIK_LOCK.txt')=true) or (FileExists(path+'TOVAR_LOCK.txt')=true) then
   begin
   //LOCKOVANIE
   //F2:=FileCreate(path+'CENNIK_LOCK.txt');
   //F3:=FileCreate(path+'TOVAR_LOCK.txt');

     //DELETE LOCKU
     //FileClose(F2);
     //DeleteFile(path+'cennik_LOCK.txt');
     //FileClose(F3);
     //DeleteFile(path+'tovar_LOCK.txt');

end;
   //end;
   //end;
end.

