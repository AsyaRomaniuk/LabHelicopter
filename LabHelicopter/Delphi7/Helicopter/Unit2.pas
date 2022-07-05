unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls;

type
  TForm2 = class(TForm)
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PostMenu(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure MousePressed(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form2.Close;
  Image1.Canvas.Pen.Color := StringToColor('$e8ffe8');
  Image1.Canvas.Brush.Color := StringToColor('$e8ffe8');
  Image1.Canvas.FillRect(Rect(0, 0, Image1.Width, Image1.Height));
end;

procedure TForm2.PostMenu(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    PopupMenu1.Popup(X, Y);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Image1.Width := Screen.Width;
  Image1.Height := Screen.Height;
  Image1.Canvas.Pen.Color := StringToColor('$e8ffe8');
  Image1.Canvas.Brush.Color := StringToColor('$e8ffe8');
  Image1.Canvas.FillRect(Rect(0, 0, Image1.Width, Image1.Height));
  Label1.Color := StringToColor('$e8ffe8');
end;

procedure TForm2.N1Click(Sender: TObject);
begin
  Form2.Close();
  Image1.Canvas.Pen.Color := StringToColor('$e8ffe8');
  Image1.Canvas.Brush.Color := StringToColor('$e8ffe8');
  Image1.Canvas.FillRect(Rect(0, 0, Image1.Width, Image1.Height));
end;

procedure TForm2.MousePressed(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Label1.Caption := '(' + IntToStr(X) + ';' + IntToStr(Screen.Height - Y - 1) + ')';
end;

end.
