//This file is a part of ANNSI-Project
//
//(c)2007/2008 by MAD-Crew
//Marcel S.,Alex L. D., Dimitri M.

unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, ExtCtrls, ImgList,AboutUnit, StrUtils ,

  Neuron,NeuronManager,Renderer,Unit1, StdCtrls, Options;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Bearbeiten1: TMenuItem;
    Ansicht1: TMenuItem;
    Beenden1: TMenuItem;
    StatusBar: TStatusBar;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    Neuron1: TMenuItem;
    Einfgen1: TMenuItem;
    I1: TMenuItem;
    About1: TMenuItem;
    Timer1: TTimer;
    PopupMenuForm: TPopupMenu;
    Hinzufgen1: TMenuItem;
    PopupMenuNeuron: TPopupMenu;
    Entfernen2: TMenuItem;
    Verbinde1: TMenuItem;
    Verbinde2: TMenuItem;
    Neu1: TMenuItem;
    Entferne1: TMenuItem;
    N2: TMenuItem;
    Optionen1: TMenuItem;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    Vergrern1: TMenuItem;
    Verkleinern1: TMenuItem;
    Optionen2: TMenuItem;
    NewButton: TToolButton;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    NewNeuronButton: TToolButton;
    NeuronDeleteButton: TToolButton;
    NeuronConnetcButton: TToolButton;
    NeuronOptionButton: TToolButton;
    Netzexportieren1: TMenuItem;
    sd: TSaveDialog;
    Netzimportieren1: TMenuItem;
    N3: TMenuItem;
    DebugWindow1: TMenuItem;
    NeuronSaveButton: TToolButton;
    NeuronLoadButton: TToolButton;
    N4: TMenuItem;
    Netzwerk1: TMenuItem;
    RandomisiereVerbindungen1: TMenuItem;
    Netzeditor1: TMenuItem;
    N5: TMenuItem;
    estphase1: TMenuItem;
    Einfgenn1: TMenuItem;
    Aktivierung1: TMenuItem;
    Gewicht1: TMenuItem;
    od: TOpenDialog;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Eingabe1: TMenuItem;
    Ausgabe1: TMenuItem;
    Schwellwert1: TMenuItem;
    Grid1: TMenuItem;
    Statistik: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    StatNumNeuron: TLabel;
    Label3: TLabel;
    StatNumInput: TLabel;
    Label4: TLabel;
    StatNumHidden: TLabel;
    Label5: TLabel;
    StatNumOutput: TLabel;
    Label6: TLabel;
    StatNumCon: TLabel;
    Statistik1: TMenuItem;
    Label7: TLabel;
    StatNumSelected: TLabel;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    GroupBox1: TGroupBox;
    rbRight: TRadioButton;
    rbLeft: TRadioButton;
    Label8: TLabel;
    StatNumFPS: TLabel;
    Reset: TMenuItem;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    Extras1: TMenuItem;
    imerwertsetzen1: TMenuItem;
    Selektierealle1: TMenuItem;
    SelektiereAlle2: TMenuItem;
    Selektion1: TMenuItem;
    SelektiereInput1: TMenuItem;
    SelektiereMiddle1: TMenuItem;
    SelektiereOutput1: TMenuItem;
    Selektion2: TMenuItem;
    SelektiereInput2: TMenuItem;
    SelektiereMiddle2: TMenuItem;
    SelektiereOutput2: TMenuItem;
    ZoomIn1: TMenuItem;
    ZoomOut1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    EinfgenErweitert1: TMenuItem;
    ToolButton12: TToolButton;
    HnzufgenErweitert1: TMenuItem;
    ToolButton13: TToolButton;
    Lernrate1: TMenuItem;
    Verbinden1: TMenuItem;
    MittlereSchicht1: TMenuItem;
    AusgabeSchicht1: TMenuItem;
    Verbinde3: TMenuItem;
    MittelSchichte1: TMenuItem;
    AusgabeSchicht2: TMenuItem;
    Farbe1: TMenuItem;
    Statisch1: TMenuItem;
    Dynamisch1: TMenuItem;
    Lernverzgerung1: TMenuItem;
    N8: TMenuItem;
    Einstellungen1: TMenuItem;
    N9: TMenuItem;
    ToolButton14: TToolButton;
    procedure Beenden1Click(Sender: TObject);
    procedure Einfgen1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Entfernen2Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Verbinde1Click(Sender: TObject);
    procedure Neu1Click(Sender: TObject);
    procedure Optionen1Click(Sender: TObject);
    procedure Netzexportieren1Click(Sender: TObject);
    procedure Netzimportieren1Click(Sender: TObject);
    procedure DebugWindow1Click(Sender: TObject);
    procedure RandomisiereVerbindungen1Click(Sender: TObject);
    procedure Netzeditor1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Einfgenn1Click(Sender: TObject);
    procedure NeuronVergern1Click(Sender: TObject);
    procedure Neuronverkleinern1Click(Sender: TObject);
    procedure Vergrern1Click(Sender: TObject);
    procedure Verkleinern1Click(Sender: TObject);
    procedure estphase1Click(Sender: TObject);
    procedure Aktivierung1Click(Sender: TObject);
    procedure Gewicht1Click(Sender: TObject);
    procedure Eingabe1Click(Sender: TObject);
    procedure Schwellwert1Click(Sender: TObject);
    procedure Grid1Click(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Statistik1Click(Sender: TObject);
    procedure rbRightClick(Sender: TObject);
    procedure rbLeftClick(Sender: TObject);
    procedure ResetClick(Sender: TObject);
    procedure imerwertsetzen1Click(Sender: TObject);
    procedure Selektierealle1Click(Sender: TObject);
    procedure SelektiereInput1Click(Sender: TObject);
    procedure SelektiereMiddle1Click(Sender: TObject);
    procedure SelektiereOutput1Click(Sender: TObject);
    procedure EinfgenErweitert1Click(Sender: TObject);
    procedure StatistikMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Lernrate1Click(Sender: TObject);
    procedure MittelSchichte1Click(Sender: TObject);
    procedure AusgabeSchicht2Click(Sender: TObject);
    procedure Statisch1Click(Sender: TObject);
    procedure Dynamisch1Click(Sender: TObject);
    procedure Lernverzgerung1Click(Sender: TObject);
    procedure Einstellungen1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
    m_moveObject:Boolean;  //kann man verschieben?
    m_connectObject:Boolean; //verbinde
    m_selectedNeuron:Integer; //aktuell ausgewählter neuron
    m_oldMX:Integer;
    m_oldMY:Integer;
    
    m_selectRect : TRect;
    m_select : Boolean;
    m_curTime   : Extended;
    m_prevTime  : Extended;
    m_fps       : Integer;
    m_tempFPS   : Integer;

    renderer:CGDIRenderer;        //grafische ausgabe

    procedure moveNeuron(id:Integer;x:Integer;y:Integer;useId:Boolean);
    procedure moveNet(x:Integer; y:Integer;useId:Boolean);
  public
    { Public-Deklarationen }
  end;


var
  MainForm: TMainForm;
  neuralNet: CNeuronManager; //das gesamte netz

implementation

uses OptionsDialog,AddNeuronEx, NetEditUnit, MathUtils;

{$R *.dfm}

procedure TMainForm.moveNeuron(id:Integer;x:Integer;y:Integer;useID:Boolean);
begin
      if useId=false then
      begin
        //verschiebe auf neue position
        neuralNet.getNeuron(id).Position.X:=x;
        neuralNet.getNeuron(id).Position.Y:=y;
      end
      else
      begin
        neuralNet.getNeuronById(id).Position.X:=x;
        neuralNet.getNeuronById(id).Position.Y:=y;
      end;
end;

procedure TMainForm.Beenden1Click(Sender: TObject);
begin
    Close;
end;

//hinzufügen neuer neuronen
procedure TMainForm.Einfgen1Click(Sender: TObject);
var
  neuron:CNeuron; //temporaere klasse
begin
   neuron:=CNeuron.Create;
   neuron.Position.X:=100;
   neuron.Position.Y:=100;
   neuralNet.addNeuron(neuron);

   self.m_select:=false;
   neuralNet.m_selectedNeurons.Clear;
   //neuron.Free;

   ShowCursor(false); //cursor brauchen wir nicht
   m_moveObject:=true;

   //setze aktuellen neuron auf das letzte neuron
   self.m_selectedNeuron:=neuralNet.getNumNeurons-1;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  //neuron:=CNeuron.Create;
   Randomize;

  DoubleBuffered:=true; //aktuviere doublebuffer(irgendwie funzt nicht :))
  neuralNet:=CNeuronManager.Create;
  renderer:=CGDIRenderer.Create;
  self.m_selectedNeuron:=-1;
  self.m_select:=false;
  self.renderer.showGrid(true);
  self.renderer.showDynColor(false);

  self.m_fps:=0;
  self.m_tempFPS:=0;
  self.m_curTime:=0;
  self.m_prevTime:=0;

  self.rbRight.Checked:=true;

  self.renderer.m_settings:=settings;

end;

procedure TMainForm.moveNet(X:Integer; Y:Integer; useId:Boolean);
var
  i:Integer;
  matrix:CMatrix2D;
begin

  matrix:=CMatrix2D.Create;
  //matrix.setIdentity;

  if useId then
  begin

  end
  else
  begin
  for i:=neuralNet.getNumNeurons-1 downto 0 do
  begin
      {posX:=Trunc(neuralNet.getNeuron(i).Position.X);
      posY:=Trunc(neuralNet.getNeuron(i).Position.Y);

      posX:=posX+X;
      posY:=posY+Y;

      neuralNet.getNeuron(i).Position.X:=posX;
      neuralNet.getNeuron(i).Position.Y:=posY;  }
      matrix.setIdentity;
      matrix.translate(X,Y);
      neuralNet.getNeuron(i).Position.transform(matrix);
  end;
  end;
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var
    nPosX:Integer;
    nPosY:Integer;
    scaleFactor:Extended;
    i:Integer;
    matrix:CMatrix2D;
begin

 //verschiebe auf aktuelle mausposition
 if self.m_moveObject then
 begin
  if neuralNet.m_selectedNeurons.Count<=0 then
  begin
    moveNeuron(self.m_selectedNeuron,X,Y,false)
  end
  else
  begin
    matrix:=CMatrix2D.Create;
    for i:=neuralNet.m_selectedNeurons.Count-1 downto 0 do
    begin
        matrix.setIdentity;
        matrix.translate(X-self.m_oldMX,Y-self.m_oldMY);
        neuralNet.getNeuronById(Integer(neuralNet.m_selectedNeurons.Items[i]^)).Position.transform(matrix);
    end;

  end;
 end
 else if (self.m_moveObject=false) and (self.m_connectObject=false) then
 begin
   for i:=neuralNet.getNumNeurons-1 downto 0 do
   begin
      nPosX:=Trunc(neuralNet.getNeuron(i).Position.X);
      nPosY:=Trunc(neuralNet.getNeuron(i).Position.Y);
      scaleFactor:=neuralNet.getNeuron(i).ScaleFactor;

      //gibts kollision?
      //todo: vermeide hardcoded values wie 30 usw.(skallierungsfaktor)
      if (X>nPosX) and (X<nPosX+scaleFactor) and (Y>nPosY) and
         (Y<nPosY+scaleFactor) and (neuralNet.m_selectedNeurons.Count<=0) then
      begin
        self.m_selectedNeuron:=i;
      end;//end if
   end;//end for
 end;//end else

 self.m_oldMX:=X;
 self.m_oldMY:=Y;

end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var
    i:Integer;
    nPosX:Integer;
    nPosY:Integer;
    scaleFactor:Extended;
begin
   StatusBar.Panels.Items[0].Text:='Aktion: - ';

   //reset popwindow
   if Button=mbRight then
   begin
      if MainForm.PopupMenu=PopupMenuNeuron then
          MainForm.PopupMenu:=PopupMenuForm;
   end;


  //wenn neuron schon plaziert ist, dann nicht mehr verschieben
  if (Sender=MainForm) and (m_moveObject=true) then
  begin
     ShowCursor(true);
     m_moveObject:=false;
     neuralNet.m_selectedNeurons.Clear;
  end;
  if Sender=MainForm then
  begin

     //teste neuron auf kollision mit der maus
     //todo: schreib alle kollision algos in extra unit oder funktion
     for i:=neuralNet.getNumNeurons-1 downto 0 do
     begin
      nPosX:=Trunc(neuralNet.getNeuron(i).Position.X);
      nPosY:=Trunc(neuralNet.getNeuron(i).Position.Y);
      scaleFactor:=neuralNet.ScaleFactor;

      //gibts kollision?
      //todo: vermeide hardcoded values wie 30 usw.(skallierungsfaktor)
      if (X>nPosX) and (X<nPosX+scaleFactor) and (Y>nPosY) and (Y<nPosY+scaleFactor) then
      begin
        if (Button=mbLeft) and (self.m_connectObject=true) then
        begin

            self.m_connectObject := false;

            if neuralNet.getNeuron(self.m_selectedNeuron).isConnectedTo(neuralNet.getNeuron(i).Id) then
            begin
                neuralNet.reConnectNeuronsDir(neuralNet.getNeuron(self.m_selectedNeuron).Id,
                                    neuralNet.getNeuron(i).Id);
            end
            else
            begin
              neuralNet.connectNeuronsDir(neuralNet.getNeuron(self.m_selectedNeuron).Id,
                                    neuralNet.getNeuron(i).Id);
            end;
            self.m_selectedNeuron:=i;
        end  //end if
        else if (Button=mbLeft) and (m_moveObject=false) then
        begin
          //neuralNet.getNeuron(i).show(MainForm.Canvas,true);
          //wieder verschieben
          StatusBar.Panels.Items[0].Text:='Aktion: Bewege ';
          self.m_moveObject:=true;
          self.m_selectedNeuron:=i;
          ShowCursor(false);

          if neuralNet.m_selectedNeurons.Count<=0 then
              moveNeuron(self.m_selectedNeuron,X,Y,false);
        end;         //end else

        if Button=mbRight then
        begin
            self.m_moveObject:=false;
            //if self.m_selectedNeuron=i then
            //begin
              self.m_selectedNeuron:=i;
              MainForm.PopupMenu:=PopupMenuNeuron;
            //end
            //else
            //  self.m_selectedNeuron:=i;
        end;//end if
      end; //end if
      //if (Button=mbLeft) and (m_connectObject=true) then
      //  self.m_connectObject:=false;

     end; //end for

     //still connected?
     if self.m_connectObject then
      self.m_connectObject:=false;
  end;

   if (Button=mbLeft) and (Sender=MainForm) and (m_moveObject=false) then
   begin

        neuralNet.m_selectedNeurons.Clear;
        self.m_selectRect.Left:=X;
        self.m_selectRect.Top:=Y;
        self.m_select:=true;
   end;

end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  r:TRect;
begin
  {for i:=0 to neuralNet.getNumNeurons-1 do
  begin
     neuralNet.getNeuron(i).show(MainForm.Canvas,true);
  end;}

  //update clientbereich
  //zeichne alles erneut

  //if self.Focused then
  //begin
   if (ScreenToClient(Mouse.CursorPos).X<=10) and (ScreenToClient(Mouse.CursorPos).X>=0) then
   begin
      self.moveNet(settings.scrollspeed,0,false);
      self.m_selectRect.Left:=self.m_selectRect.Left+settings.scrollspeed;
   end;
   if (ScreenToClient(Mouse.CursorPos).X>=self.ClientWidth-5) and
       (ScreenToClient(Mouse.CursorPos).X<=self.ClientWidth) then
   begin
     self.moveNet(-(settings.scrollspeed),0,false);
     self.m_selectRect.Left:=self.m_selectRect.Left-settings.scrollspeed;
   end;
   if (ScreenToClient(Mouse.CursorPos).Y<=self.Canvas.ClipRect.Top+10) and
      (ScreenToClient(Mouse.CursorPos).Y>=self.Canvas.ClipRect.Top) then
   begin
     self.moveNet(0,settings.scrollspeed,false);
     self.m_selectRect.Top:=self.m_selectRect.Top+settings.scrollspeed;
   end;
   if (ScreenToClient(Mouse.CursorPos).Y>=self.Canvas.ClipRect.Bottom-5) and
       (ScreenToClient(Mouse.CursorPos).Y<=self.Canvas.ClipRect.Bottom)then
   begin
     self.moveNet(0,-settings.scrollspeed,false);
     self.m_selectRect.Top:=self.m_selectRect.Top-settings.scrollspeed;
   end;

  //end;

  r := Self.ClientRect;
  windows.InvalidateRect(Self.Handle, @r, FALSE);

end;

procedure TMainForm.FormPaint(Sender: TObject);
var i,numNeu,numInp,numOut,numMidd,numCon:Integer;
begin
 {for i:=0 to neuralNet.getNumNeurons-1 do
  begin
     neuralNet.getNeuron(i).show(MainForm.Canvas,true);
  end;}

{  if self.m_moveObject then
    StatusBar.Panels.Items[0].Text:='Aktion: Bewege'
  else
    StatusBar.Panels.Items[0].Text:='Aktion: - ';

  if self.m_connectObject then
    StatusBar.Panels.Items[0].Text:='Aktion: Verbinde/Trenne'
  else
    StatusBar.Panels.Items[0].Text:='Aktion: - ';}



  if self.Statistik.Visible then
  begin
    self.StatNumNeuron.Caption:=IntToStr(neuralNet.getNumNeurons);

    numNeu:=neuralNet.getNumNeurons;
    numInp:=0;
    numOut:=0;
    numMidd:=0;
    numCon:=0;

    for i:=neuralNet.getNumNeurons()-1 downto 0 do
    begin
        if neuralNet.getNeuron(i).Typ=NT_INPUT then
          numInp:=numInp+1
        else if neuralNet.getNeuron(i).Typ=NT_MIDDLE then
          numMidd:=numMidd+1
        else
          numOut:=numOut+1;

        numCon:=numCon+neuralNet.getNeuron(i).Neurons.Count;
    end;

    if numNeu>0 then
    begin
      self.StatNumInput.Caption:=IntToStr(numInp)+'  '+IntToStr(Trunc(numInp/numNeu*100))+'%';
      self.StatNumHidden.Caption:=IntToStr(numMidd)+'  '+IntToStr(Trunc(numMidd/numNeu*100))+'%';
      self.StatNumOutput.Caption:=IntToStr(numOut)+'  '+IntToStr(Trunc(numOut/numNeu*100))+'%';
    end
    else
    begin
      self.StatNumInput.Caption:=IntToStr(numInp)+'  0'+'%';
      self.StatNumHidden.Caption:=IntToStr(numMidd)+'  0'+'%';
      self.StatNumOutput.Caption:=IntToStr(numOut)+'  0'+'%';
    end;

    self.StatNumCon.Caption:=IntToStr(numCon);

    if neuralNet.m_selectedNeurons.Count=0 then
    begin
      self.StatNumSelected.Caption:='1';
      if neuralNet.getNumNeurons=0 then
        self.StatNumSelected.Caption:='0';
    end
    else
      self.StatNumSelected.Caption:=IntToStr(neuralNet.m_selectedNeurons.Count);

  end;

  StatusBar.Panels.Items[3].Text:='Num. Neuron: '+IntToStr(neuralNet.getNumNeurons);

  if self.m_selectedNeuron<>-1 then
  begin
    StatusBar.Panels.Items[1].Text:='Neuron ID: '+
                        IntToStr(neuralNet.getNeuron(self.m_selectedNeuron).Id);
    StatusBar.Panels.Items[2].Text:='Neuron Typ: '+
                        IntToStr(Integer(neuralNet.getNeuron(self.m_selectedNeuron).Typ));
  end
  else
  begin
    StatusBar.Panels.Items[1].Text:='Neuron ID: - ';
  end;

  self.m_curTime:=(GetTickCount()*0.001);
  self.m_fps:=self.m_fps+1;

  if (self.m_curTime-self.m_prevTime)>1 then
  begin
      self.m_prevTime:=self.m_curTime;
      self.m_tempFPS:=self.m_fps;
      self.m_fps:=0;
  end;

  self.StatNumFPS.Caption:=IntToStr(self.m_tempFPS);

  //move this drawing stuff to renderer class
  //
  if self.m_connectObject then
  begin
    self.Canvas.Pen.Color := clWhite;
    self.Canvas.Pen.Style := psDot;
    self.Canvas.MoveTo(Trunc(neuralNet.getNeuron(m_selectedNeuron).Position.X)+15,
                        Trunc(neuralNet.getNeuron(m_selectedNeuron).Position.Y)+15);
    self.Canvas.LineTo(MainForm.ScreenToClient(Mouse.CursorPos).X,
                        MainForm.ScreenToClient(Mouse.CursorPos).Y);
    self.Canvas.Pen.Style:=psSolid;
  end;

   if (self.m_select) and (self.m_moveObject=false) then
   begin
     self.Canvas.Pen.Color := clBlack;
     self.Canvas.Pen.Style  := psDot;
     self.Canvas.Brush.Color := settings.sel;
     self.Canvas.Brush.Style:=bsSolid;

     self.m_selectRect.Right:=ScreenToClient(Mouse.CursorPos).X;
     self.m_selectRect.Bottom:=ScreenToClient(Mouse.CursorPos).Y;

     self.Canvas.Rectangle(self.m_selectRect);
  end;

  neuralNet.SelectedNeuron:=self.m_selectedNeuron;
  renderer.render(self,neuralNet);

end;

procedure TMainForm.Entfernen2Click(Sender: TObject);
var i:Integer;
    id:^Integer;
begin
  StatusBar.Panels.Items[0].Text:='Aktion: Entferne' ;

  if neuralNet.m_selectedNeurons.Count<=0 then
  begin
    if (self.m_selectedNeuron>=0) then
    begin
      neuralNet.removeNeuron(self.m_selectedNeuron);
      if self.m_selectedNeuron=0 then
        self.m_selectedNeuron:=-1
      else
        self.m_selectedNeuron:=neuralNet.getNumNeurons-1;
    end
    else
      ShowMessage('Keine Neuronen ausgewählt');
  end
  else
  begin
     New(id);
     for i:=neuralNet.m_selectedNeurons.Count-1 downto 0 do
     begin
        id^:=Integer(neuralNet.m_selectedNeurons.Items[i]^);
        neuralNet.removeNeuronById(id^);

        if neuralNet.getNumNeurons<=0 then
          self.m_selectedNeuron:=-1
        else
          self.m_selectedNeuron:=neuralNet.getNumNeurons-1;
     end;

     neuralNet.m_selectedNeurons.Clear;
  end;
end;

procedure TMainForm.About1Click(Sender: TObject);
begin
  AboutForm.Show;
end;

procedure TMainForm.Verbinde1Click(Sender: TObject);
begin
     StatusBar.Panels.Items[0].Text:='Aktion: Verbinde/Trenne';
    if (self.m_selectedNeuron>0) or (self.m_selectedNeuron=0) then
      self.m_connectObject:=true
    else
      ShowMessage('Keine Neuronen ausgewählt');
end;

procedure TMainForm.Neu1Click(Sender: TObject);
begin
  if neuralNet.getNumNeurons>0 then
  begin
    if (MessageDlg('Netz wirklich löschen?', mtConfirmation, mbYesNoCancel, 0) = mrYes) then
    begin
      neuralNet.clearNet;
      self.m_selectedNeuron:=-1;
      self.m_connectObject:=false;
      self.m_moveObject:=false;
    end
  end
  else
  begin
      neuralNet.clearNet;
      self.m_selectedNeuron:=-1;
      self.m_connectObject:=false;
      self.m_moveObject:=false;
  end;
end;

procedure TMainForm.Optionen1Click(Sender: TObject);
begin

    if (self.m_selectedNeuron>=0) then
    begin
      StatusBar.Panels.Items[0].Text:='Aktion: Optionen';
      OptionsMenu.Neuron:=neuralNet.getNeuron(self.m_selectedNeuron);
      OptionsMenu.neuralNet:=neuralNet;
      OptionsMenu.m_width:=self.ClientWidth;
      OptionsMenu.m_height:=self.ClientHeight;
      OptionsMenu.Show;
    end
    else
      ShowMessage('Keine Neuronen ausgewählt');

end;

procedure TMainForm.Netzexportieren1Click(Sender: TObject);
var  TempList: TStrings;
var  Count: Integer;
var  Links: Integer;
var  NType: String;
var actFunc: String;
var  single: String;
var  command: String;
var  rar: String;
var  archive:String;
begin
    if (sd.Execute) then
    begin
        TempList := TStringList.Create;
        TempList.Text := 'Network:';
        for Count := 0 to (neuralNet.getNumNeurons-1) do
        begin
          if (neuralNet.getNeuron(Count).Typ = NT_INPUT) then
          begin
            NType := 'INPUT';
          end
          else if (neuralNet.getNeuron(Count).Typ = NT_MIDDLE) then
          begin
            NType := 'MIDDLE';
          end
          else
          begin
            NType := 'OUTPUT';
          end;

          if (neuralNet.getNeuron(Count).ActivFunc = IDENTITY) then
          begin
            actFunc := 'IDENTITY';
          end
          else if (neuralNet.getNeuron(Count).ActivFunc = BIN_TH) then
          begin
            actFunc := 'BIN_TH';
          end
          else if (neuralNet.getNeuron(Count).ActivFunc= LIN_TH) then
          begin
            actFunc := 'LIN_TH';
          end
          else if (neuralNet.getNeuron(Count).ActivFunc= SIN_TH) then
          begin
            actFunc := 'SIN_TH';
          end
          else if (neuralNet.getNeuron(Count).ActivFunc= SIGM) then
          begin
            actFunc := 'SIGM';
          end
          else if (neuralNet.getNeuron(Count).ActivFunc= TANH) then
          begin
            actFunc := 'TANH';
          end;

        single := IntToStr(neuralNet.getNeuron(Count).Id);
        TempList.Add('nrid ' + single);
        TempList.Add('neur ' + NType);
        TempList.Add('xpos ' + IntToStr(Trunc(neuralNet.getNeuron(Count).Position.X)));
        TempList.Add('ypos ' + IntToStr(Trunc(neuralNet.getNeuron(Count).Position.Y)));
        single := FloatToStrF(neuralNet.getNeuron(Count).Input, ffGeneral, 7, 15);
        TempList.Add('inpu ' + single);
        single := FloatToStrF(neuralNet.getNeuron(Count).Activation, ffGeneral, 7, 15);
        TempList.Add('acti ' + single);
        single := FloatToStrF(neuralNet.getNeuron(Count).Threshold, ffGeneral, 7, 15);
        TempList.Add('thrd ' + single);
        TempList.Add('actf ' + actFunc);
        for Links:=0 to neuralNet.getNeuron(Count).Neurons.Count-1 do
          begin
          TempList.Add('conn ' + IntToStr(PConnection(neuralNet.getNeuronById(Count).Neurons[Links]).id));
          TempList.Add('wght ' + FloatToStr(PConnection(neuralNet.getNeuronById(Count).Neurons[Links]).weight));
          end;
        end;
        TempList.Add(':Network');
        TempList.SaveToFile(sd.FileName);
        TempList.Free;
        StatusBar.Panels.Items[0].Text:='Aktion: Gespeichert!';
        rar := '"' + ExtractFilePath(ParamStr(0)) + 'plugins\rar.exe"';
        archive := '"' + sd.FileName + '.rar"';
        command := rar + ' a -m5 -t -ep ' + archive + ' "' + sd.FileName + '"';
        WinExec(PAnsiChar(command),
         SW_HIDE);
    end;
end;

procedure TMainForm.Netzimportieren1Click(Sender: TObject);
var  TempList: TStrings;
var  Line: Integer;
var  command: String;
var  neuron:CNeuron;
var lastId:Integer;
var   tempConn:Integer;
begin

   tempConn:=0;
   self.m_selectedNeuron:=-1;
   self.m_connectObject:=false;
   self.m_moveObject:=false;

  neuron := CNeuron.Create;

  if (od.Execute)  then
  begin
  TempList := TStringList.Create;
    if (FileExists(od.FileName)) then
    begin
      //clear everything
      neuralNet.clearNet;
    TempList.LoadFromFile(od.FileName);

      for Line := 0 to TempList.Count-1 do
      begin
      command := Copy(TempList.Strings[Line], 1, 4);
      case AnsiIndexText(command, ['nrid']) of
        0: begin
          neuron:=CNeuron.Create;
          command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
          neuron.Id := StrToInt(command);
          neuralNet.addNeuron(neuron);
        end;
      end;
      end;

      for Line := 0 to TempList.Count-1 do
      begin
      command := Copy(TempList.Strings[Line], 1, 4);
      case AnsiIndexText(command, ['neur', 'xpos', 'ypos', 'inpu', 'conn', 'netw', ':net', 'wght','acti','thrd','actf','nrid']) of
        0: begin
            //neuron:=CNeuron.Create;
            tempConn:=0;
            command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
            if command = 'INPUT' then
            begin
            debug.Memo1.Lines.Add('Created Input Neuron!');
            neuron.Typ := NT_INPUT;
            end
            else if command = 'MIDDLE' then
            begin
            debug.Memo1.Lines.Add('Created Middle Neuron!');
            neuron.Typ := NT_MIDDLE;
            end
            else if command = 'OUTPUT' then
            begin
            debug.Memo1.Lines.Add('Created Output Neuron!');
            neuron.Typ := NT_OUTPUT;
            end;
          end;
        1: begin
            command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
            neuron.Position.X := StrToInt(command);
            debug.Memo1.Lines.Add('Set PosX property!');
          end;
        2: begin
            command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
            neuron.Position.Y := StrToInt(command);
            debug.Memo1.Lines.Add('Set PosY property!');
            end;
        3: begin
            //Input
            command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
            neuron.Input := StrToFloat(command);
            debug.Memo1.Lines.Add('Set Input property!');
            end;
        4: begin
            command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
            neuralNet.connectNeuronsDir({neuralNet.getNumNeurons-1}neuron.Id, StrToInt(command));
            debug.Memo1.Lines.Add('Established connections!');
            end;
        5: begin
             StatusBar.Panels.Items[0].Text:='Aktion: Lade...!';
             debug.Memo1.Lines.Add('Lade Netz...');
            end;
        6: begin
             StatusBar.Panels.Items[0].Text:='Aktion: Netz geladen.';
             debug.Memo1.Lines.Add('Netz wurde geladen.');
            end;
        7: begin
              command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);

              //PConnection(neuralNet.getNeuronById(neuralNet.getNumNeurons-1).Neurons[neuralNet.getNeuronById(neuralNet.getNumNeurons-1).Neurons.Count-1]).weight := StrToFloat(command);
              //for i:=0 to neuralNet.getNeuronById(neuron.Id).Neurons.Count-1 do
              //begin
                  //if neuralNet.getNeuron(i).Id=connectId then
                  //  ShowMessage('found');

                    //PConnection(neuralNet.getNeuronById(neuron.Id).Neurons[i]).weight := StrToFloat(command);
                    PConnection(neuralNet.getNeuronById(neuron.Id).Neurons[tempConn]).weight := StrToFloat(command);
                    tempConn:=tempConn+1;
              //end;
              debug.Memo1.Lines.Add('Weight set');
            end;
        8: begin
              command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
              neuron.Activation := StrToFloat(command);
              //neuralNet.addNeuron(neuron);
              debug.Memo1.Lines.Add('Activation set');
            end;
        9: begin
              command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
              neuron.Threshold := StrToFloat(command);
              debug.Memo1.Lines.Add('Threshold set');
            end;
        10: begin
              command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
            //neuron:=CNeuron.Create;
            if command = 'IDENTITY' then
            begin
            debug.Memo1.Lines.Add('Set IDENTITY Func!');
            neuron.activFunc := IDENTITY;
            end
            else if command = 'BIN_TH' then
            begin
            debug.Memo1.Lines.Add('Set BIN_TH Func!');
            neuron.activFunc := BIN_TH;
            end
            else if command = 'LIN_TH' then
            begin
            debug.Memo1.Lines.Add('Set LIN_TH Func!');
            neuron.activFunc := LIN_TH;
            end
            else if command = 'SIN_TH' then
            begin
            debug.Memo1.Lines.Add('Set SIN_TH Func!');
            neuron.activFunc := SIN_TH;
            end
            else if command = 'SIGM' then
            begin
            debug.Memo1.Lines.Add('Set SIGM Func!');
            neuron.activFunc := SIGM;
            end
            else if command = 'TANH' then
            begin
            debug.Memo1.Lines.Add('Set TANH Func!');
            neuron.activFunc := TANH;
            end;
            end;
          11: begin
             //neuron:=CNeuron.Create;
             command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
             //neuron.Id := StrToInt(command);
             lastId:=StrToInt(command);
             neuron:=neuralNet.getNeuronById(lastId);
             debug.Memo1.Lines.Add('Set Id property!');
            end;
        end;
      end;

      if neuralNet.getNumNeurons-1>=0 then
        self.m_selectedNeuron:=neuralNet.getNumNeurons-1;

      {for Line := 0 to TempList.Count-1 do
      begin
      command := Copy(TempList.Strings[Line], 1, 4);
      case AnsiIndexText(command, ['conn']) of
        0: begin
            command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
            neuralNet.connectNeuronsDir(neuralNet.getNumNeurons-1, StrToInt(command));
            debug.Memo1.Lines.Add('Established connections!');
            end;
        end;
      end; }
    end;
  end;
end;

procedure TMainForm.DebugWindow1Click(Sender: TObject);
begin
debug.Show;
end;

procedure TMainForm.RandomisiereVerbindungen1Click(Sender: TObject);
var connectionExist:Boolean;
    i:Integer;
begin

  connectionExist:=false;

  for i:=0 to neuralNet.getNumNeurons-1 do
  begin
     if neuralNet.getNeuron(i).Neurons.Count>0 then
              connectionExist:=true;
  end;

  if not connectionExist then ShowMessage('Keine Verbindungen vorhanden')
  else neuralNet.randomWeights;
  
end; //end procedure

procedure TMainForm.Netzeditor1Click(Sender: TObject);
begin
  NetForm.m_neuronManager:=neuralNet;
  NetForm.m_form:=self;
  NetForm.m_renderer:=renderer;
  NetForm.Show;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  case key of
  VK_ESCAPE: begin
            if self.m_connectObject=true then
              self.m_connectObject:=false;

            if self.m_moveObject then
            begin
                self.m_moveObject:=false;
                ShowCursor(true);
            end;

      end;
  ord('W'): begin
              self.moveNet(0,settings.scrollspeed,false);
              self.m_selectRect.Top:=self.m_selectRect.Top+settings.scrollspeed;
            end;
  ord('S'): begin
              self.moveNet(0,-settings.scrollspeed,false);
              self.m_selectRect.Top:=self.m_selectRect.Top-settings.scrollspeed;
            end;
  ord('A'): begin
              self.moveNet(settings.scrollspeed,0,false);
              self.m_selectRect.Left:=self.m_selectRect.Left+15;
            end;
  ord('D'): begin
              self.moveNet(-settings.scrollspeed,0,false);
              self.m_selectRect.Left:=self.m_selectRect.Left-settings.scrollspeed;
            end;
  end;

end;

procedure TMainForm.Einfgenn1Click(Sender: TObject);
var number,i,yPos,xPos:Integer;
    neuron:CNeuron;
begin

    number:=StrToInt(InputBox('Neuronen einfügen','Anzahl der Neuronen: ','1'));

    yPos:=50;
    xPos:=50;
    for i:=0 to number-1 do
    begin
      neuron:=CNeuron.Create;

      if (i mod 20)=0 then
      begin
        xPos:=100;
        yPos:=yPos+2*Trunc(neuralNet.ScaleFactor);
      end
      else
        xPos:=xPos+2*Trunc(neuralNet.ScaleFactor);;

        neuron.Position.Y:=yPos;
        neuron.Position.X:=xPos;

      neuralNet.addNeuron(neuron);
   //neuron.Free;
      self.m_selectedNeuron:=neuralNet.getNumNeurons-1;
    end;//end for
end;

procedure TMainForm.NeuronVergern1Click(Sender: TObject);
var
  oldScale:Extended;
  matrix:CMatrix2D;
begin

  matrix:=CMatrix2D.Create;
  matrix.setIdentity;

  if self.m_selectedNeuron>=0 then
  begin
      oldScale:=neuralNet.getNeuron(self.m_selectedNeuron).ScaleFactor;
      if oldScale<=300 then
      begin
        neuralNet.getNeuron(self.m_selectedNeuron).ScaleFactor:=oldScale*1.1;
      end;
  end;
end;

procedure TMainForm.Neuronverkleinern1Click(Sender: TObject);
var
  oldScale:Extended;
begin
  if self.m_selectedNeuron>=0 then
  begin
    oldScale:=neuralNet.getNeuron(self.m_selectedNeuron).ScaleFactor;
    neuralNet.getNeuron(self.m_selectedNeuron).ScaleFactor:=oldScale-5;
  end;
end;

procedure TMainForm.Vergrern1Click(Sender: TObject);
begin
  neuralNet.scale(1.10,1.10);
end;

procedure TMainForm.Verkleinern1Click(Sender: TObject);
begin

  neuralNet.scale(0.90,0.90);

end;

procedure TMainForm.estphase1Click(Sender: TObject);
begin
    neuralNet.processNetwork;
end;

procedure TMainForm.Aktivierung1Click(Sender: TObject);
begin
  if TMenuItem(Sender).Checked then
  begin
    TMenuItem(Sender).Checked:=false;
    OptionsMenu.ShowActivation:=0
  end
  else
  begin
    TMenuItem(Sender).Checked:=true;
    OptionsMenu.ShowActivation:=1;
  end;
end;

procedure TMainForm.Gewicht1Click(Sender: TObject);
begin
   if TMenuItem(Sender).Checked then
   begin
    TMenuItem(Sender).Checked:=false;
    OptionsMenu.ShowWeights:=0
   end
   else
   begin
    TMenuItem(Sender).Checked:=true;
    OptionsMenu.ShowWeights:=1;
   end;
end;

procedure TMainForm.Eingabe1Click(Sender: TObject);
begin
  if TMenuItem(Sender).Checked then
  begin
    TMenuItem(Sender).Checked:=false;
    OptionsMenu.ShowInput:=0
  end
  else
  begin
    TMenuItem(Sender).Checked:=true;
    OptionsMenu.ShowInput:=1;
  end;
end;

procedure TMainForm.Schwellwert1Click(Sender: TObject);
begin
   if TMenuItem(Sender).Checked then
  begin
    TMenuItem(Sender).Checked:=false;
    OptionsMenu.ShowThreshold:=0
  end
  else
  begin
    TMenuItem(Sender).Checked:=true;
    OptionsMenu.ShowThreshold:=1;
  end;
end;

procedure TMainForm.Grid1Click(Sender: TObject);
begin
  if TMenuItem(Sender).Checked then
  begin
    TMenuItem(Sender).Checked:=false;
    self.renderer.showGrid(false);
  end
  else
  begin
    TMenuItem(Sender).Checked:=true;
    self.renderer.showGrid(true);
  end;
end;

procedure TMainForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i,temp,nPosX,nPosY:Integer;
    scaleFactor:Extended;
    id:^Integer;
begin
      //neuralNet.m_selectedNeurons.Clear;

      if self.m_moveObject then
      begin
          self.m_moveObject:=false;
          ShowCursor(true);
      end;

      if self.m_select then
      begin
         self.m_select:=false;

        self.m_selectRect.Right:=ScreenToClient(Mouse.CursorPos).X;
        self.m_selectRect.Bottom:=ScreenToClient(Mouse.CursorPos).Y;

        if self.m_selectRect.Left>self.m_selectRect.Right then
        begin
          temp:=self.m_selectRect.Left;
          self.m_selectRect.Left:=self.m_selectRect.Right;
          self.m_selectRect.Right:=temp;
        end;
        if self.m_selectRect.Top>self.m_selectRect.Bottom then
        begin
          temp:=self.m_selectRect.Top;
          self.m_selectRect.Top:=self.m_selectRect.Bottom;
          self.m_selectRect.Bottom:=temp;
        end;

        for i:=neuralNet.getNumNeurons-1 downto 0 do
          begin
            nPosX:=Trunc(neuralNet.getNeuron(i).Position.X);
            nPosY:=Trunc(neuralNet.getNeuron(i).Position.Y);
            scaleFactor:=neuralNet.ScaleFactor;

            if ((nPosX<=self.m_selectRect.Right) and (self.m_selectRect.Left<nPosX+scaleFactor) and
                (self.m_selectRect.Top<nPosY) and (self.m_selectRect.Bottom>nPosY+scaleFactor))
                then
                begin
                  New(id);
                  id^:=neuralNet.getNeuron(i).Id;
                  neuralNet.m_selectedNeurons.Add(id);

                  self.m_selectedNeuron:=i;
                end;
          end;

          //if neuralNet.m_selectedNeurons.Count<=0 then
          //  self.m_selectedNeuron:=temp;

          self.m_selectRect.Right:=-100;
          self.m_selectRect.Bottom:=-100;
          self.m_selectRect.Top:=-100;
          self.m_selectRect.Bottom:=-100;
     end;
        //dispose(id);

end;

procedure TMainForm.Statistik1Click(Sender: TObject);
begin
   if Statistik1.Checked then
  begin
    Statistik1.Checked:=false;
    self.Statistik.Visible:=false;
  end
  else
  begin
    Statistik1.Checked:=true;
    self.Statistik.Visible:=true;
  end;

  if self.rbRight.Checked then
    self.Statistik.Align:=alRight
  else
    self.Statistik.Align:=alLeft;
end;

procedure TMainForm.rbRightClick(Sender: TObject);
begin
  self.Statistik.Align:=alRight;
end;

procedure TMainForm.rbLeftClick(Sender: TObject);
begin
    self.Statistik.Align:=alLeft;
end;

procedure TMainForm.ResetClick(Sender: TObject);
var i:Integer;
    id:^Integer;
begin
  if neuralNet.m_selectedNeurons.Count<=0 then
  begin
     for i:=neuralNet.getNumNeurons-1 downto 0 do
     begin
         neuralNet.getNeuron(i).Activation:=0;
         neuralNet.getNeuron(i).Input:=0;
         neuralNet.getNeuron(i).Output:=0;
     end;
  end
  else
  begin
     New(id);

     for i:=neuralNet.m_selectedNeurons.Count-1 downto 0 do
     begin
         id^:=Integer(neuralNet.m_selectedNeurons[i]^);
         neuralNet.getNeuronById(id^).Activation:=0;
         neuralNet.getNeuronById(id^).Input:=0;
         neuralNet.getNeuronById(id^).Output:=0;
     end;
  end;
end;

procedure TMainForm.imerwertsetzen1Click(Sender: TObject);
var newInterval:Integer;
begin
    newInterval:=StrToInt(InputBox('Timer','Timer Interval in ms: ',IntToStr(self.Timer1.Interval)));
    self.Timer1.Interval:=newInterval;
end;

procedure TMainForm.Selektierealle1Click(Sender: TObject);
var id:^Integer;
    i:Integer;

begin

    neuralNet.m_selectedNeurons.Clear;
    for i:=neuralNet.getNumNeurons-1 downto 0 do
    begin
         New(id);
        id^:=neuralNet.getNeuron(i).Id;
        neuralNet.m_selectedNeurons.Add(id);

        self.m_selectedNeuron:=i;
    end;

end;

procedure TMainForm.SelektiereInput1Click(Sender: TObject);
var id:^Integer;
    i:Integer;
begin
    neuralNet.m_selectedNeurons.Clear;
    for i:=neuralNet.getNumNeurons-1 downto 0 do
    begin
        if neuralNet.getNeuron(i).Typ=NT_INPUT then
        begin
          New(id);
          id^:=neuralNet.getNeuron(i).Id;
          neuralNet.m_selectedNeurons.Add(id);

          self.m_selectedNeuron:=i;
        end;
    end;
end;

procedure TMainForm.SelektiereMiddle1Click(Sender: TObject);
var id:^Integer;
    i:Integer;
begin
   neuralNet.m_selectedNeurons.Clear;
    for i:=neuralNet.getNumNeurons-1 downto 0 do
    begin
        if neuralNet.getNeuron(i).Typ=NT_MIDDLE then
        begin
          New(id);
          id^:=neuralNet.getNeuron(i).Id;
          neuralNet.m_selectedNeurons.Add(id);

          self.m_selectedNeuron:=i;
        end;
    end;
end;

procedure TMainForm.SelektiereOutput1Click(Sender: TObject);
var id:^Integer;
    i:Integer;
begin
    neuralNet.m_selectedNeurons.Clear;
    for i:=neuralNet.getNumNeurons-1 downto 0 do
    begin
        if neuralNet.getNeuron(i).Typ=NT_OUTPUT then
        begin
          New(id);
          id^:=neuralNet.getNeuron(i).Id;
          neuralNet.m_selectedNeurons.Add(id);

          self.m_selectedNeuron:=i;

        end;
    end;
end;

procedure TMainForm.EinfgenErweitert1Click(Sender: TObject);
begin
     addNeuronExtended.neuronManager:=neuralNet;
     addNeuronExtended.Show;
end;

procedure TMainForm.StatistikMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    if Statistik.Focused then
        MainForm.SetFocus;
end;

procedure TMainForm.Lernrate1Click(Sender: TObject);
var newRate : Single;
begin
   newRate:=StrToFloat(InputBox('Lernrate','Lernrate setzen: ',FloatToStr(neuralNet.TrainingRate)));
   neuralNet.TrainingRate:=newRate;
end;

procedure TMainForm.MittelSchichte1Click(Sender: TObject);
var i,j:Integer;
begin
  if neuralNet.m_selectedNeurons.Count<=0 then
  begin
   for i:=0 to neuralNet.getNumNeurons-1 do
   begin
         if neuralNet.getNeuron(i).Typ=NT_MIDDLE then
         begin
              neuralNet.connectNeuronsDir(neuralNet.getNeuron(self.m_selectedNeuron).Id,
                                         neuralNet.getNeuron(i).Id);
         end;
   end;
  end
  else
  begin
   for j:=0 to neuralNet.m_selectedNeurons.Count-1 do
   begin
    for i:=0 to neuralNet.getNumNeurons-1 do
    begin
          if neuralNet.getNeuron(i).Typ=NT_MIDDLE then
          begin
               neuralNet.connectNeuronsDir(Integer(neuralNet.m_selectedNeurons.Items[j]^),
                                          neuralNet.getNeuron(i).Id);
          end;
    end;
   end;
  end;

end;

procedure TMainForm.AusgabeSchicht2Click(Sender: TObject);
var i,j:Integer;
begin
   if neuralNet.m_selectedNeurons.Count<=0 then
  begin
   for i:=0 to neuralNet.getNumNeurons-1 do
   begin
         if neuralNet.getNeuron(i).Typ=NT_OUTPUT then
         begin
              neuralNet.connectNeuronsDir(neuralNet.getNeuron(self.m_selectedNeuron).Id,
                                         neuralNet.getNeuron(i).Id);
         end;
   end;
  end
  else
  begin
   for j:=0 to neuralNet.m_selectedNeurons.Count-1 do
   begin
    for i:=0 to neuralNet.getNumNeurons-1 do
    begin
          if neuralNet.getNeuron(i).Typ=NT_OUTPUT then
          begin
               neuralNet.connectNeuronsDir(Integer(neuralNet.m_selectedNeurons.Items[j]^),
                                          neuralNet.getNeuron(i).Id);
          end;
    end;
   end;
  end;

end;

procedure TMainForm.Statisch1Click(Sender: TObject);
begin
  if (not Statisch1.Checked) and (Dynamisch1.Checked) then
  begin
    Statisch1.Checked:=true;
    Dynamisch1.Checked:=false;
    self.renderer.showDynColor(false);
  end;
end;

procedure TMainForm.Dynamisch1Click(Sender: TObject);
begin
   if (not Dynamisch1.Checked) and (Statisch1.Checked) then
  begin
    Dynamisch1.Checked:=true;
    Statisch1.Checked:=false;
    self.renderer.showDynColor(true);
  end;
end;

procedure TMainForm.Lernverzgerung1Click(Sender: TObject);
var newDelay : Integer;
begin
  newDelay:=StrToInt(InputBox('Lernverzögerung','Lernverzögerung in ms setzen: ',IntToStr(NetForm.m_delay)));
  NetForm.m_delay:=newDelay;
end;

procedure TMainForm.Einstellungen1Click(Sender: TObject);
var
conf:TStringList;
begin
 conf := TStringList.Create;                                  {speichern}
 settings.ShowModal;
 conf.Values['bgcolor'] := IntToStr(settings.bgcolor);
 conf.Values['gridcolor'] := IntToStr(settings.gridcolor);
 conf.Values['scrollspeed'] := IntToStr(settings.scrollspeed);
 conf.Values['n_sel'] := IntToStr(settings.nsel);
 conf.Values['n_in'] := IntToStr(settings.nin);
 conf.Values['n_out'] := IntToStr(settings.nout);
 conf.Values['n_mid'] := IntToStr(settings.nmid);
 conf.Values['conn'] := IntToStr(settings.conn);
 conf.Values['sel'] := IntToStr(settings.sel);
 conf.Values['font'] := IntToStr(settings.font);
 conf.SaveToFile(ExtractFilePath(Application.ExeName)+'config\\annsi.conf');
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  conf:TStringList;
  path:string;
begin
conf := TStringList.Create;
path := ExtractFilePath(Application.ExeName)+'config\\annsi.conf';
if FileExists(path) then
  begin
    conf.LoadFromFile(path);
    MainForm.Color := StrToInt(conf.Values['bgcolor']);
    settings.bgcolor := MainForm.Color;                              {laden}
    settings.gridcolor := StrToInt(conf.Values['gridcolor']);
    settings.nsel := StrToInt(conf.Values['n_sel']);
    settings.nmid := StrToInt(conf.Values['n_mid']);
    settings.nin := StrToInt(conf.Values['n_in']);
    settings.nout := StrToInt(conf.Values['n_out']);
    settings.conn := StrToInt(conf.Values['conn']);
    settings.sel := StrToInt(conf.Values['sel']);
    settings.font := StrToInt(conf.Values['font']);
    settings.scrollspeed := StrToInt(conf.Values['scrollspeed']);
  end
  else
  ShowMessage('Bitte config Verzeichnis erstellen!');
end;

end.

