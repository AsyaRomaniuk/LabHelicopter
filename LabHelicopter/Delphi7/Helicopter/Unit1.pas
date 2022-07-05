unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, Unit2;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure create_tree(x:integer; y:integer;
     clr:TColor; size:extended; h:integer);
    procedure CreatePicture(X1:integer; Y1:integer; Xb:integer; Yb:integer;
     Xe:integer; Ye:integer; X2:integer; Y2:integer; W:integer; H:integer;
     Ya:integer; left:TColor; right:TColor; under:TColor);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  points : array[0..14] of TPoint;

implementation

{$R *.dfm}

procedure TForm1.create_tree(x:integer; y:integer;
     clr:TColor; size:extended; h:integer);
begin
  Form2.Image1.Canvas.Brush.Color := clr;
  Form2.Image1.Canvas.Pen.Color := clr;
  points[0] := Point(Trunc(x-10*size), h-y);
  points[1] := Point(Trunc(x+10*size), h-y);
  points[2] := Point(Trunc(x+10*size), Trunc(h-y-10*size));
  points[3] := Point(Trunc(x+40*size), h-y);
  points[4] := Point(Trunc(x+20*size), Trunc(h-y-40*size));
  points[5] := Point(Trunc(x+30*size), Trunc(h-y-35*size));
  points[6] := Point(Trunc(x+15*size), Trunc(h-y-65*size));
  points[7] := Point(Trunc(x+25*size), Trunc(h-y-60*size));
  points[8] := Point(x, Trunc(h-y-100*size));
  points[9] := Point(Trunc(x-25*size), Trunc(h-y-60*size));
  points[10] := Point(Trunc(x-15*size), Trunc(h-y-65*size));
  points[11] := Point(Trunc(x-30*size), Trunc(h-y-35*size));
  points[12] := Point(Trunc(x-20*size), Trunc(h-y-40*size));
  points[13] := Point(Trunc(x-40*size), h-y);
  points[14] := Point(Trunc(x-10*size), Trunc(h-y-10*size));
  Form2.Image1.Canvas.Polygon(points);
end;

procedure TForm1.CreatePicture(X1:integer; Y1:integer; Xb:integer; Yb:integer;
     Xe:integer; Ye:integer; X2:integer; Y2:integer; W:integer; H:integer;
     Ya:integer; left:TColor; right:TColor; under:TColor);
var
  constant, wd, ht, bridgeconstant : integer;
begin
  constant := X2 + X1;
  bridgeconstant := Trunc((X2 - X1) * 0.08);
  wd := Form2.Image1.Width;
  ht := Form2.Image1.Height;
  Form2.Label1.Caption := '';
  Form2.Label1.Left := Trunc(constant+(wd-constant)/2);
  Form2.Label1.Top := Trunc(ht-ht/2);
  Form2.Image1.Canvas.Pen.Width := 2;
  Form2.Image1.Canvas.Pen.Color := RGB(38, 38, 38);
  Form2.Image1.Canvas.MoveTo(constant, 0);//rightside
  Form2.Image1.Canvas.LineTo(constant, ht);
  points[0] := Point(0, ht);
  points[1] := Point(0, ht-Y1);
  points[2] := Point(X1, ht-Y1);
  points[3] := Point(Xb, ht-Ye);
  points[4] := Point(Xe, ht-Ye);
  points[5] := Point(X2, ht-Y2);
  points[6] := Point(constant, ht-Y2);
  points[7] := Point(constant, ht);
  Form2.Image1.Canvas.Pen.Color := RGB(51, 51, 51);
  Form2.Image1.Canvas.Brush.Color := RGB(128, 128, 128);
  Form2.Image1.Canvas.Polygon(Slice(points, 8));//polygon
  Form2.Image1.Canvas.Brush.Style := bsClear;
  Form2.Image1.Canvas.Pen.Width := 16;
  Form2.Image1.Canvas.Pen.Color := clBlue;
  Form2.Image1.Canvas.MoveTo(Xb, ht-Ye);//water
  Form2.Image1.Canvas.LineTo(Xe, ht-Ye);
  Form2.Image1.Canvas.Pen.Width := 10;
  Form2.Image1.Canvas.Pen.Color := RGB(51, 51, 51);
  Form2.Image1.Canvas.MoveTo(Xb, ht-Yb);//column1
  Form2.Image1.Canvas.LineTo(Xb, ht-Ye);
  Form2.Image1.Canvas.MoveTo(Xe, ht-Ye);//column2
  Form2.Image1.Canvas.LineTo(Xe, ht-Yb);
  Form2.Image1.Canvas.Pen.Color := clBlack;
  Form2.Image1.Canvas.Pen.Width := 4;
  Form2.Image1.Canvas.MoveTo(X1, ht-Y1);//bridge
  Form2.Image1.Canvas.LineTo(Xb, ht-Yb);
  Form2.Image1.Canvas.LineTo(Xe, ht-Yb);
  Form2.Image1.Canvas.LineTo(X2, ht-Y2);
  Form2.Image1.Canvas.Pen.Width := 2;
  Form2.Image1.Canvas.MoveTo(X1, ht-Y1);//topbridge
  Form2.Image1.Canvas.LineTo(Xb, ht-Yb-bridgeconstant);
  Form2.Image1.Canvas.LineTo(Xe, ht-Yb-bridgeconstant);
  Form2.Image1.Canvas.LineTo(X2, ht-Y2);
  Form2.Image1.Canvas.MoveTo(Xb, ht-Yb);//lineup
  Form2.Image1.Canvas.LineTo(Xe, ht-Yb-bridgeconstant);
  Form2.Image1.Canvas.MoveTo(Xb, ht-Yb-bridgeconstant);//linedown
  Form2.Image1.Canvas.LineTo(Xe, ht-Yb);
  Form2.Image1.Canvas.Pen.Color := clBlue;
  Form2.Image1.Canvas.Brush.Color := left;
  Form2.Image1.Canvas.Pen.Width := 1;
  Form2.Image1.Canvas.Pen.Style := psDot;
  Form2.Image1.Canvas.Rectangle(trunc(X1/2+W/2), trunc(ht-(Y1+(Ya-Y1)/2)+H/2),
  trunc(X1/2-W/2), trunc(ht-(Y1+(Ya-Y1)/2)-H/2));//rect1
  Form2.Image1.Canvas.Brush.Color := right;
  Form2.Image1.Canvas.Rectangle(trunc(X2+(constant-X2)/2+W/2),
  trunc(ht-(Y2+(Ya-Y2)/2+H/2)), trunc(X2+(constant-X2)/2-W/2),
  trunc(ht-(Y2+(Ya-Y2)/2-H/2)));//rect2
  Form2.Image1.Canvas.Brush.Color := under;
  Form2.Image1.Canvas.Rectangle(trunc(Xb+(Xe-Xb)/2+W/2),
  trunc(ht-(Ye+(Yb-Ye)/2+H/2)), trunc(Xb + (Xe - Xb)/2-W/2),
  trunc(ht-(Ye + (Yb-Ye)/2-H/2)));//rect3
  Form2.Image1.Canvas.Pen.Color := clRed;
  Form2.Image1.Canvas.Brush.Color := StringToColor('$e8ffe8');
  Form2.Image1.Canvas.Pen.Style := psDash;
  Form2.Image1.Canvas.MoveTo(0, ht-Ya);//limit
  Form2.Image1.Canvas.LineTo(constant, ht-Ya);
  create_tree(Trunc(Xe+(X2-Xe)*0.12), Ye, RGB(0, 128, 0),
  (Yb-Ye)*0.004, ht);
  create_tree(Trunc(X1+(Xb-X1)*0.88), Ye, RGB(0, 128, 0),
  (Yb-Ye)*0.004, ht);
  create_tree(Trunc(X1+(Xb-X1)*0.64), Trunc(Ye+(Y1-Ye)*0.24), RGB(0, 128, 0),
  (Yb-Ye)*0.004, ht);
  Form2.Image1.Canvas.Brush.Color := RGB(0, 255, 255);
  Form2.Image1.Canvas.Pen.Width := 1;
  Form2.Image1.Canvas.Pen.Style := psSolid;
  Form2.Image1.Canvas.Ellipse(trunc(X1/2+5), trunc(ht-(Y1+(Ya-Y1)/2)+5),
  trunc(X1/2-5), trunc(ht-(Y1+(Ya-Y1)/2)-5));//dot1
  Form2.Image1.Canvas.Ellipse(trunc(X2+(constant-X2)/2+5),
  trunc(ht-(Y2+(Ya-Y2)/2+5)), trunc(X2+(constant-X2)/2-5),
  trunc(ht-(Y2+(Ya-Y2)/2-5)));//dot2
  Form2.Image1.Canvas.Ellipse(trunc(Xb+(Xe-Xb)/2+5), trunc(ht-(Ye+(Yb-Ye)/2+5)),
  trunc(Xb+(Xe-Xb)/2-5), trunc(ht-(Ye+(Yb-Ye)/2-5)));//dot3
  Form2.Image1.Canvas.Pen.Width := 2;
  Form2.Image1.Canvas.Brush.Color := clYellow;
  Form2.Image1.Canvas.Pen.Color := clWhite;
  Form2.Image1.Canvas.Ellipse(X1+5, ht-(Y1+5), X1-5, ht-(Y1-5));//c1
  Form2.Image1.Canvas.Ellipse(Xb+5, ht-(Yb+5), Xb-5, ht-(Yb-5));//c2
  Form2.Image1.Canvas.Ellipse(Xe+5, ht-(Ye+5), Xe-5, ht-(Ye-5));//c3
  Form2.Image1.Canvas.Ellipse(X2+5, ht-(Y2+5), X2-5, ht-(Y2-5));//c4
  Form2.ShowModal();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  Edit5.Text := '';
  Edit6.Text := '';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Edit1.Text := '360';
  Edit2.Text := '200 240';
  Edit3.Text := '350 240';
  Edit4.Text := '600 100';
  Edit5.Text := '750 240';
  Edit6.Text := '150 60';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open',
   'https://drive.google.com/file/d/1-MsFejNgq8smBRzNbeuYd4SR41UWCgvi/view?usp=sharing'
   , nil, nil, SW_NORMAL);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  msg : string;
  left : TColor;
  right : TColor;
  under : TColor;
  Ya, X1, Y1, Xb, Yb, Xe, Ye, X2, Y2, W, H, constant: integer;
  Dlg : TForm;
  trimmed : string;
begin
  msg := '';
  left := clRed;
  right := clRed;
  under := clRed;
  try
    Ya := StrToInt(Trim(Edit1.Text));
    trimmed := Trim(Edit2.Text);
    X1 := StrToInt(Copy(trimmed, 1, Pos(' ', trimmed)-1));
    Y1 := StrToInt(Copy(trimmed, Pos(' ', trimmed)+1,
    Length(trimmed)-Pos(' ', trimmed)+1));
    trimmed := Trim(Edit3.Text);
    Xb := StrToInt(Copy(trimmed, 1, Pos(' ', trimmed)-1));
    Yb := StrToInt(Copy(trimmed, Pos(' ', trimmed)+1,
    Length(trimmed)-Pos(' ', trimmed)+1));
    trimmed := Trim(Edit4.Text);
    Xe := StrToInt(Copy(trimmed, 1, Pos(' ', trimmed)-1));
    Ye := StrToInt(Copy(trimmed, Pos(' ', trimmed)+1,
    Length(trimmed)-Pos(' ', trimmed)+1));
    trimmed := Trim(Edit5.Text);
    X2 := StrToInt(Copy(trimmed, 1, Pos(' ', trimmed)-1));
    Y2 := StrToInt(Copy(trimmed, Pos(' ', trimmed)+1,
    Length(trimmed)-Pos(' ', trimmed)+1));
    trimmed := Trim(Edit6.Text);
    W := StrToInt(Copy(trimmed, 1, Pos(' ', trimmed)-1));
    H := StrToInt(Copy(trimmed, Pos(' ', trimmed)+1,
    Length(trimmed)-Pos(' ', trimmed)+1));
    constant := X2 + X1;
    if (X1 - W > 0) and (Ya - Y1 > H) then
    begin
      left := RGB(144, 238, 144);
      msg := msg+'Можна пролетіти під мостом зліва:('+FloatToStr(X1/2)+';'
      +FloatToStr(Y1 + (Ya-Y1)/2)+')'+#13#10;
    end;
    if (Ya - Y2 > H) then
    begin
      right := RGB(144, 238, 144);
      msg := msg+'Можна пролетіти під мостом справа:('+FloatToStr(X2 +
      (constant-X2)/2)+';'+FloatToStr(Y2+ (Ya-Y2)/2)+')'+#13#10;
    end;
    if (Ya > Ye + (Yb - Ye)/2 + H/2) and  (Yb > Ye + (Yb - Ye)/2 + H/2)
    and (Xb + W < Xe) then
    begin
      under := RGB(144, 238, 144);
      msg := msg+'Можна пролетіти під мостом:('+FloatToStr(Xb + (Xe - Xb)/2)+';'
      +FloatToStr(Ye + (Yb - Ye)/2)+')'+#13#10;
    end;
    if (msg = '') then
      msg := msg+'На жаль, рекомендацій по шляху немає.';
    Dlg := CreateMessageDialog(msg,
     mtInformation, [mbOk]);
    Dlg.Caption := 'Рекомендації';
    Dlg.ShowModal;
    Dlg.Free;
    CreatePicture(X1, Y1, Xb, Yb, Xe, Ye, X2, Y2, W, H,
     Ya, left, right, under);
  except
    Dlg := CreateMessageDialog('Ви ввели недопустиме значення!',
     mtError, [mbOk]);
    Dlg.Caption := 'Сталася помилка!';
    Dlg.ShowModal;
    Dlg.Free;
  end;                                                       
end;

end.
