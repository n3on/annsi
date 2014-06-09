unit Options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls;

type
  Tsettings = class(TForm)
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    Panel1: TPanel;
    cld: TColorDialog;
    Label3: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Button1: TButton;
    Label10: TLabel;
    Label11: TLabel;
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);  
    procedure Label7Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    gridcolor:TColor;
    bgcolor:TColor;
    scrollspeed:integer;
    nsel:TColor;
    nin:TColor;
    nout:TColor;
    nmid:TColor;
    conn:TColor;
    sel:TColor;
    font:tcolor;
  end;

var
  settings: Tsettings;

implementation

uses MainUnit;

{$R *.dfm}

procedure Tsettings.Panel1Click(Sender: TObject);
begin
if (cld.Execute) then
  begin
  Panel1.Color := cld.Color;
  MainForm.Color := cld.Color;
  end;
end;

procedure Tsettings.Panel2Click(Sender: TObject);
begin
if (cld.Execute) then
  begin
  Panel2.Color := cld.Color;
  end;
end;

procedure Tsettings.TrackBar1Change(Sender: TObject);
begin
scrollspeed := TrackBar1.Position;
end;

procedure Tsettings.Label5Click(Sender: TObject);
begin
  if (cld.Execute) then
  begin
  Label5.Color := cld.Color;
  end;
end;

procedure Tsettings.Label8Click(Sender: TObject);
begin
  if (cld.Execute) then
  begin
  Label8.Color := cld.Color;
  end;
end;

procedure Tsettings.Label6Click(Sender: TObject);
begin
  if (cld.Execute) then
  begin
  Label6.Color := cld.Color;
  end;
end;

procedure Tsettings.Label7Click(Sender: TObject);
begin
  if (cld.Execute) then
  begin
  Label7.Color := cld.Color;
  end;
end;

procedure Tsettings.Label9Click(Sender: TObject);
begin
  if (cld.Execute) then
  begin
  Label9.Color := cld.Color;
  end;
end;

procedure Tsettings.Button1Click(Sender: TObject);
begin
  conn := Label9.Color;
  nout := Label7.Color;
  nin := Label6.Color;
  nmid := Label8.Color;
  nsel := Label5.Color;
  scrollspeed := TrackBar1.Position;
  conn := Label9.Color;
  gridcolor := Panel2.Color;
  bgcolor := Panel1.Color;
  sel := Label10.Color;
  font:=Label11.color;
  Close();
end;

procedure Tsettings.FormShow(Sender: TObject);
begin
Label9.Color := conn;
Label7.Color := nout;
  Label6.Color := nin;
  Label8.Color := nmid;
  Label5.Color := nsel;
  TrackBar1.Position := scrollspeed;
  Label9.Color := conn;
  Panel2.Color:=gridcolor;
  Panel1.Color:=bgcolor;
  Label10.Color := sel;
  Label11.Color := font;
end;

procedure Tsettings.Label10Click(Sender: TObject);
begin
  if (cld.Execute) then
  begin
  Label10.Color := cld.Color;
  end;
end;

procedure Tsettings.Label11Click(Sender: TObject);
begin
   if (cld.Execute) then
  begin
  Label11.Color := cld.Color;
  end;
end;

end.
