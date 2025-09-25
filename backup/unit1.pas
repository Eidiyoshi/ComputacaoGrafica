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
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
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
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
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
  x1,y1,x2,y2,x,y,xc,yc,inc,incx,incy,i,setor,direcao,raio,h,dEC,dSE,clip,x3,y3: Integer;
  x4,y4,xLeft,xRight,yTop,yBottom,limX,limY,xLim,yLim, desenho,aux, cod1,cod2: Integer;
  R,xr,yr,a,sen1,cos1,xn,d,dE,dNE,hr : Real;

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

  if( (op = 4) ) then   // linhas
  begin
    x1 := X;
    Edit3.Text := IntToStr(x1);
    y1 := Y;
    Edit4.Text := IntToStr(y1);
  end;

  if ((op = 5) or (op = 6) or (op = 7) or (op = 8)) then // circunferencias
  begin
       xc := X;
       yc := Y;
  end;

  if(op = 9) then // clipping
  begin
    if((desenho = 1) or (desenho = 2)) then //desenhar linha
    begin
      cod1 := 0;
      x1 := X;
      Edit3.Text := IntToStr(x1);
      y1 := Y;                   
      Edit4.Text := IntToStr(y1);
      desenho := 2;

      cod1 := 0;
      if(x1<xLeft) then cod1 := cod1 + 1;//0001
      if(x1>xRight) then cod1 := cod1 + 2; //0010
      if(y1>yBottom) then cod1 := cod1 + 4;//0100
      if(y1<yTop) then cod1 := cod1 + 8;//1000
    end;

    if(clip = 1) then //fazercaixa
    begin
      x4 := X;
      Edit5.Text := IntToSTr(x4);
      y4 := Y;
      Edit6.Text := IntToSTr(y4);

      xLeft := x3;
      xRight := x4;
      yBottom := y4;
      yTop := y3;

      x := x3;
      y := y3;
      incx := 1;
      incy := 1;
      if(x3>x4) then
      begin
           incx := -1;
           xLeft := x4;
           xRight := x3;
      end;

      if(y3>y4) then
      begin
        incy := -1;
        yBottom := y3;
        yTop := y4;
      end;

      while(x <> x4) do
      begin
        Image1.Canvas.Pixels[x,y3] := clred;
        Image1.Canvas.Pixels[x,y4] := clred;
        x := x +incx;
      end;

      while(y <> y4) do
      begin
        Image1.Canvas.Pixels[x3,y] := clred;
        Image1.Canvas.Pixels[x4,y] := clred;
        y := y + incy;
      end;
      desenho := 1;
      clip := 2;
    end;

    if(clip = 0) then  //fazercaixa
    begin
      x3 := X;
      Edit3.Text := IntToSTr(x3);
      y3 := Y;
      Edit4.Text := IntToSTr(y3);
      clip := 1;
    end;
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
  begin // desenhar linhas bresenham WIP

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

        if( dy < 0 ) then incy := -1;
        if( dx < 0 ) then incx := -1;
        if( dx > dy ) then direcao := 1;  //horizontal
        if( dy > dx ) then direcao := 0;  //vertical

        setor := 1;
        if((direcao = 0) and (y2>y1) and (x2>x1)) then setor := 2;
        if((direcao = 0) and (y2>y1) and (x1>x2)) then setor := 3;
        if((direcao = 1) and (y2>y1) and (x1>x2)) then setor := 4;
        if((direcao = 1) and (y1>y2) and (x1>x2)) then setor := 5;
        if((direcao = 0) and (y1>y2) and (x1>x2)) then setor := 6;
        if((direcao = 0) and (y1>y2) and (x2>x1)) then setor := 7;
        if((direcao = 1) and (y1>y2) and (x2>x1)) then setor := 8;

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
              if( setor = 1 ) then Image1.Canvas.Pixels[x,y] := clred;  
              if( setor = 2 ) then Image1.Canvas.Pixels[y,x] := clred;
              if( setor = 3 ) then Image1.Canvas.Pixels[y,-x] := clred;
              if( setor = 4 ) then Image1.Canvas.Pixels[-x,y] := clred;
              if( setor = 5 ) then Image1.Canvas.Pixels[-x,-y] := clred;
              if( setor = 6 ) then Image1.Canvas.Pixels[-y,-x] := clred;
              if( setor = 7 ) then Image1.Canvas.Pixels[y,-x] := clred;
              if( setor = 8 ) then Image1.Canvas.Pixels[-x,y] := clred;
          end;

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

  if(op = 8) then //circunferencia bresenham WIP
  begin
    raio := abs(xc - X);
    x := xc;
    y := x + raio;
    h := 1 - raio;
    dEC := 3;
    dSE := (-2 * raio) + 5;
    Image1.Canvas.Pixels[x,y] := clred;
    while ( x < y ) do
    begin
      if( h < 0) then
      begin
        h := h + dEC;
        dEC := dEC + 2;
        dSE := dSE + 2;
      end
      else
      begin
        h := h + dSE;
        dEC := dEC + 2;
        dSE := dSE + 4;
        y := y - 1;
      end;
      x := x + 1;
      Image1.Canvas.Pixels[x,y] := clred;
    end;

  end;

  if( (op = 9) and (desenho = 2)) then // clipping
  begin
    x2 := X;
    Edit5.Text := IntToStr(x2);
    y2 := Y;                   
    Edit6.Text := IntToStr(y2);

    cod2 := 0;
    if(x2<xLeft) then cod2 := cod2 + 1;//0001
    if(x2>xRight) then cod2 := cod2 + 2; //0010
    if(y2>yBottom) then cod2 := cod2 + 4;//0100
    if(y2<yTop) then cod2 := cod2 + 8;//1000

    if((cod1 and cod2) = 0) then
    begin
      Image1.Canvas.Pen.Color := clred;
      if((cod1 = 0)and(cod2 = 0)) then Image1.Canvas.Line(x1,y1,x2,y2); // dois pontos dentro do quadrado

      desenho := 1;
      end;
    end;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  op := 8; // circ bresenham
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  op := 9; // reta clipping
  clip := 0;
  desenho := 0;
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

