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
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  op: Integer;
  desenhar, linhar : Boolean;
  m,dx,dy: Float;
  x1,y1,x2,y2,x,y,xc,yc,inc,incx,incy,i: Integer;
  R,xr,yr,a,sen1,cos1,xn,d,dE,dNE : Real;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (op = 1) then
  begin
       desenhar := true;
       end;

  if (op = 2) then
  begin                              
    Image1.Canvas.Pen.Color := clred;
    Image1.Canvas.MoveTo(X,Y);
  end;

  if ( (op = 3) and (linhar = false))  then // linhas manuais
  begin
    x1 := X;
    Edit3.Text := IntToStr(x1);
    y1 := Y;
    Edit4.Text := IntToStr(y1);
    linhar := true;
  end;

  if( op = 4 ) then   // linha bresenham
  begin
    x1 := X;
    Edit3.Text := IntToStr(x1);
    y1 := Y;
    Edit4.Text := IntToStr(y1);
  end;

  if ((op = 5) or (op = 6) or (op = 7)) then // circunferencia
  begin
       xc := X;
       yc := Y;
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
  begin // desenhar linhas manuais
    x2 := X;
    Edit5.Text := IntToStr(x2);
    y2 := Y;
    Edit6.Text := IntToStr(y2);
    dx := Trunc(x2-x1);
    if( abs(dx) = 0 ) then   // linha vertical
    begin
      if(y1<y2) then
      begin
        for y := y1 to y2 do Image1.Canvas.Pixels[x1,y] := clred;
      end;
      if(y1>=y2) then
      begin
        for y := y2 to y1 do Image1.Canvas.Pixels[x1,y] := clred;
      end;
    end
    else
    begin
      m := (y2 - y1)/(dx);

      if(abs(y2-y1) <= abs(x2-x1)) then   // linha mais horizonatl
      begin
        if(x1 <= x2) then
        begin
          inc := 1;
        end
          else inc := -1;
        x := x1;
        y := y1;
        while(x <> x2) do
        begin
             m := (y2 - y1)/(x2-x1);
             y := Round((x - x1)*m) + y1;
             Image1.Canvas.Pixels[x,y] := clred;
             x := x + inc;
        end;
      end;

      if(abs(y2-y1) > abs(x2-x1)) then   // linha mais vertical
      begin
        if(y1 > y2) then
        begin
          inc := -1;
        end
        else inc := 1;
        x := x1;
        y := y1;
        while(y <> y2) do
        begin
             m := (y2 - y1)/(x2-x1);
             x := Round((y - y1)/m) + x1;
             Image1.Canvas.Pixels[x,y] := clred;
             y := y + inc;
        end;
      end;
    end;
    linhar := false;
    end;

  if(op = 4) then
  begin // desenhar linhas bresenham

        x2 := X;
        y2 := Y;
        Edit5.Text := IntToStr(x2);
        Edit6.Text := IntToStr(y2);

        dx := x2 - x1;
        dy := y2 - y1;

        d := 2 * dy - dx;
        dE := 2 * dy;
        dNE := 2 * ( dy - dx );
        x := x1;
        y := y1;
        Image1.Canvas.Pixels[x,y] := clred;

        incx := 1;
        incy := 1;

        if( dy < 0 ) then
        begin
        incy := -1;
        end;

        if( dx < 0 ) then
        begin
        incx := -1;
        end;

        if(abs(x2-x1) > abs(y2-y1)) then   // linha mais horizontal
        begin
          while( x <> x2 ) do
          begin
              if( d < 0 ) then
                begin
                  d := d + dE;
                  x := x + incx;
                end
              else
                begin
                  d := d + dNE;
                  x := x + incx;
                  y := y + incy;
                end;
              Image1.Canvas.Pixels[x,y] := clred;
          end;
        end;

        if(abs(y2-y1) >= abs(x2-x1)) then   // linha mais vertical
        begin
          while(y <> y2) do
          begin
              if( d < 0 ) then
                begin
                  d := d + dE;
                  y := y + incy;
                end
              else
                begin
                  d := d + dNE;
                  y := y + incy;
                  x := x + incx;
                end;
              Image1.Canvas.Pixels[x,y] := clred;
          end;
        end;
       incx := 1;
       incy := 1;
  end;

  if(op = 5) then
  begin // circunferencia
       R := sqrt((xc-X)*(xc-X) + (yc-Y)*(yc-Y));
       xr := -R;
       while (xr < R) do
       begin
            yr := sqrt(R*R - xr*xr);
            Image1.Canvas.Pixels[round(xc+xr),round(yc+yr)] := clred;
            Image1.Canvas.Pixels[round(xc+xr),round(yc-yr)] := clred;
            xr := xr + 0.01;
       end;
  end;

  if(op = 6) then
  begin // circunferencia parametrica                 
        R := sqrt((xc-X)*(xc-X) + (yc-Y)*(yc-Y));
        a := 0;
        while(a < 6.28) do
        begin
             xr := R * cos(a);
             yr := R * sin(a);
             Image1.Canvas.Pixels[round(xc+xr),round(yc+yr)] := clred;
             a := a + 0.01;
        end;
  end;

  if(op = 7) then
  begin // circ sen1
        xr := sqrt((xc-X)*(xc-X) + (yc-Y)*(yc-Y));
        yr := 0;
        cos1 := cos(1);
        sen1 := sin(1);
        for i := 1 to 360 do
        begin
          xn := xr * cos1 - yr * sen1;
          yr := xr * sen1 + yr * cos1;
          xr := xn;
          Image1.Canvas.Pixels[round(xc+xr),round(yc+yr)] := clred;
        end;
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  op := 1; // desenhar pixels
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  op := 2; // desenhar linha
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  op := 3; // desenhar linhas na "mão"
end;
                   
procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  op := 4; //desenhar linha bresenham
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  op := 5;   // circ
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  op := 6;   // circ parametrica
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  op := 7;  // circ sin1
end;


end.

