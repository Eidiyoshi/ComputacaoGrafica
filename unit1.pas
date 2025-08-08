unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  op: Integer;
  desenhar, linhar : Boolean;
  m: Float;
  x1,y1,x2,y2,x,y,inc: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (op = 1) then desenhar := true;
  if (op = 2) then
  begin                              
    Image1.Canvas.Pen.Color := clred;
    Image1.Canvas.MoveTo(X,Y);
  end;
  if ((op = 3) and (linhar = false))  then
  begin
    x1 := X;
    Edit3.Text := IntToStr(x1);
    y1 := Y;
    Edit4.Text := IntToStr(y1);
    linhar := true;
  end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ((op = 1) and (desenhar)) then Image1.Canvas.Pixels[X,Y] := clred;
  Edit1.Text := IntToStr(X);
  Edit2.Text := IntToStr(Y);
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (op = 1) then desenhar := false;
  if (op = 2) then Image1.Canvas.LineTo(X,Y);
  if ((op = 3) and (linhar = true)) then
  begin
    x2 := X;
    Edit5.Text := IntToStr(x2);
    y2 := Y;
    Edit6.Text := IntToStr(y2);
    if(x2=x1) then   // linha vertical
    begin
      if(y1<y2) then
      begin
        for y := y1 to y2 do Image1.Canvas.Pixels[x1,y] := clred;
      end;
      if(y1>=y2) then
      begin
        for y := y2 to y1 do Image1.Canvas.Pixels[x1,y] := clred;
      end;
    end;

    m := abs(y2 - y1)/abs(x2-x1);

    if(abs(y2-y1) <= abs(x2-x1)) then   // linha mais horizonatl
    begin
      if(x1 < x2) then
      begin
        inc := 1;
      end
        else inc := -1;

        while(x <> x2) do
      begin
           y := Trunc((x - x1)/m) + y1;
           Image1.Canvas.Pixels[x,y] := clred;
           x := x + inc;
      end;
    end;

    if(abs(y2-y1) > abs(x2-x1)) then   // linha mais vertical
    begin
      if(y1 < y2) then
      begin
        inc := 1;
      end
      else inc := -1;
      while(y <> y2) do
      begin
           x := Trunc((y - y1)/m) + x1;
           Image1.Canvas.Pixels[x,y] := clred;
           y := y + inc;
      end;
    end;
    linhar := false;
  end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  op := 1; // desenhar pixels
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  op := 2 // desenhar linha
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  op := 3 // desenhar linhas na "mão"
end;

end.

