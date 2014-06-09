//This file is a part of ANNSI-Project
//
//(c)2007/2008 by MAD-Crew
//Marcel S.,Alex L. D., Dimitri M.

unit NetEditUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, StrUtils,

  NeuronManager,Neuron,Renderer, ExtCtrls, ComCtrls;

type
  TNetForm = class(TForm)
    InputGrid: TStringGrid;
    Label1: TLabel;
    OutputGrid: TStringGrid;
    Label2: TLabel;
    btnProcess: TButton;
    btnReset: TButton;
    InpSet0: TButton;
    ShouldGrid: TStringGrid;
    Label3: TLabel;
    ListPatterns: TListBox;
    patternAdd: TButton;
    patternDelete: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    patternName: TLabeledEdit;
    patternChange: TButton;
    patternSave: TButton;
    Button1: TButton;
    btnTrain: TButton;
    btnSetSetZero: TButton;
    numIterations: TLabeledEdit;
    errorRate: TLabeledEdit;
    panel: TPanel;
    epoch: TLabel;
    deltaTime: TLabel;
    TrainingSet: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    painter: TPanel;
    clear: TButton;
    clearGrid: TButton;
    gridder: TPanel;
    GroupBox3: TGroupBox;
    gridWidth: TEdit;
    Label4: TLabel;
    gridHeigth: TEdit;
    Label5: TLabel;
    ShouldSet0: TButton;
    btnRaster: TButton;
    GroupBox4: TGroupBox;
    mapInput: TButton;
    SetValue: TButton;
    sd: TSaveDialog;
    od: TOpenDialog;
    GroupBox5: TGroupBox;
    valueMin: TEdit;
    valueMax: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    btnStop: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);

    procedure updateGrids();
    procedure updateNeurons();
    procedure rasterize();

    procedure InputGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure btnResetClick(Sender: TObject);
    procedure InpSet0Click(Sender: TObject);
    procedure OutSet0Click(Sender: TObject);
    procedure patternAddClick(Sender: TObject);
    procedure ShouldGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure ListPatternsClick(Sender: TObject);
    procedure patternDeleteClick(Sender: TObject);
    procedure patternChangeClick(Sender: TObject);
    procedure btnTrainClick(Sender: TObject);
    procedure painterMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure painterMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure painterMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure clearClick(Sender: TObject);
    procedure drawGrids();
    procedure TabSheet2Show(Sender: TObject);
    procedure gridderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure clearGridClick(Sender: TObject);
    procedure TrainingSetChange(Sender: TObject);
    procedure TabSheet2ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure gridderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnRasterClick(Sender: TObject);
    procedure mapInputClick(Sender: TObject);
    procedure ShouldSet0Click(Sender: TObject);
    procedure patternSaveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure SetValueClick(Sender: TObject);

  private
    { Private-Deklarationen }

    m_numInput:Integer;
    m_numOutput:Integer;
    m_draw:Boolean;
    m_canvas:TControlCanvas;
    m_gridCanvas:TControlCanvas;
    m_train:Boolean;
  public
    { Public-Deklarationen }
    m_neuronManager    : CNeuronManager;
    m_inputPattern     : TList;
    m_setOutputPattern : TList;
    m_delay            : Integer;
    m_form             : TForm;
    m_renderer         : IRenderer;

  end;

var
  NetForm: TNetForm;

implementation

{$R *.dfm}

procedure TNetForm.updateNeurons();
var i:Integer;
begin
    for i:=0 to self.InputGrid.RowCount-2 do
    begin
        self.m_neuronManager.getNeuronById(StrToInt(self.InputGrid.Cells[0,i+1])).Input:=
                              StrToFloat(self.InputGrid.Cells[1,i+1]);
    end;

    for i:=0 to self.ShouldGrid.RowCount-2 do
    begin
         self.m_neuronManager.getNeuronById(StrToInt(self.ShouldGrid.Cells[0,i+1])).ShouldOutput:=
         StrToFloat(self.ShouldGrid.Cells[1,i+1]);
    end;

end;

procedure TNetForm.updateGrids();
var i,numInp,numOut:Integer;
begin
  InputGrid.Cells[0,0]:='Id';
  InputGrid.Cells[1,0]:='Eingabe';

  OutputGrid.Cells[0,0]:='Id';
  OutputGrid.Cells[1,0]:='Ausgabe';

  ShouldGrid.Cells[0,0]:='Id';
  ShouldGrid.Cells[1,0]:='Ausgabe';

  numInp:=0;
  numOut:=0;


  if self.ListPatterns.Count>0 then
  begin

    for i:=0 to self.m_numInput-1 do
    begin
       InputGrid.Cells[1,i+1]:=FloatToStr(Single(TList(self.m_inputPattern.items[self.ListPatterns.ItemIndex]).Items[i]^));
    end;

    for i:=0 to self.m_numOutput-1 do
    begin
       ShouldGrid.Cells[1,i+1]:=FloatToStr(Single(TList(self.m_setOutputPattern.items[self.ListPatterns.ItemIndex]).Items[i]^));
    end;

    for i:=0 to self.m_numOutput-1 do
    begin
       OutputGrid.Cells[1,i+1]:=Format('%4.4f',[self.m_neuronManager.getNeuronById(StrToInt(OutputGrid.Cells[0,i+1])).Input]);//FloatToStr(self.m_neuronManager.getNeuronById(StrToInt(OutputGrid.Cells[0,i+1])).Input);
    end;

  end
  else
  begin
     InputGrid.RowCount:=2;
     OutputGrid.RowCount:=2;
     ShouldGrid.RowCount:=2;

     InputGrid.Cells[0,1]:='x';
     InputGrid.Cells[1,1]:='x';
     OutputGrid.Cells[0,1]:='x';
     OutputGrid.Cells[1,1]:='x';
     ShouldGrid.Cells[0,1]:='x';
     ShouldGrid.Cells[1,1]:='x';

     for i:=0 to self.m_neuronManager.getNumNeurons-1 do
     begin
       if self.m_neuronManager.getNeuron(i).Typ=NT_INPUT then
       begin
          numInp:=numInp+1;
          InputGrid.Cells[0,numInp]:=IntToStr(self.m_neuronManager.getNeuron(i).Id);
          InputGrid.Cells[1,numInp]:=FloatToStr(0.0);
          if InputGrid.RowCount<=numInp then
             InputGrid.RowCount:=InputGrid.RowCount+1;
       end
       else if self.m_neuronManager.getNeuron(i).Typ=NT_OUTPUT then
       begin
          numOut:=numOut+1;
          OutputGrid.Cells[0,numOut]:=IntToStr(self.m_neuronManager.getNeuron(i).Id);
          OutputGrid.Cells[1,numOut]:='0';
          ShouldGrid.Cells[0,numOut]:=IntToStr(self.m_neuronManager.getNeuron(i).Id);
          ShouldGrid.Cells[1,numOut]:=self.valueMin.Text;
          if OutputGrid.RowCount<=numOut then
          begin
             OutputGrid.RowCount:=OutputGrid.RowCount+1;
             ShouldGrid.RowCount:=ShouldGrid.RowCount+1;
          end;
       end;
    end;
  end;

end;

procedure TNetForm.FormShow(Sender: TObject);
var i,tempNumInput,tempNumOutput:Integer;
begin
    //self.m_numInput:=0;
    //self.m_numOutput:=0;
    tempNumInput:=0;
    tempNumOutput:=0;

    for i:=0 to self.m_neuronManager.getNumNeurons-1 do
    begin
        if self.m_neuronManager.getNeuron(i).Typ=NT_INPUT then
          //self.m_numInput:=self.m_numInput+1
          tempNumInput:=tempNumInput+1
        else if self.m_neuronManager.getNeuron(i).Typ=NT_OUTPUT then
          //self.m_numOutput:=self.m_numOutput+1;
          tempNumOutput:=tempNumOutput+1;
    end;

    if (self.ListPatterns.Count<=0) or (self.m_numInput<=0) or (self.m_numOutput<=0) or
       ((tempNumInput<>self.m_numInput) and (tempNumOutput<>self.m_numOutput)) then
    begin
      self.m_inputPattern.Clear;
      self.m_setOutputPattern.Clear;
      self.ListPatterns.Clear;
    end;

    self.m_numInput:=tempNumInput;
    self.m_numOutput:=tempNumOutput;

   self.updateGrids;

   self.m_gridCanvas.Brush.Color:=clBlack;


end;

procedure TNetForm.FormCreate(Sender: TObject);
begin
    self.m_neuronManager:=CNeuronManager.Create;
    self.m_inputPattern:=TList.Create;
    self.m_setOutputPattern:=TList.Create;
    self.m_delay:=0;
    self.m_form:=nil;
    self.m_draw:=false;
    self.m_canvas:=TControlCanvas.Create;
    self.m_gridCanvas:=TControlCanvas.Create;

    self.m_canvas.Control:=painter;
    self.m_gridCanvas.Control:=gridder;
    self.m_canvas.Pen.Width:=5;

end;

procedure TNetForm.btnProcessClick(Sender: TObject);
begin
    self.m_neuronManager.processNetwork();
    self.updateGrids;
end;

procedure TNetForm.InputGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if (length(value)>0) then
    begin
      if self.m_neuronManager.getNumNeurons>0 then
      begin
        if (Value[length(value)] in [#8, '0'..'9', ',']) then
        begin
          //PConnection(self.Neuron.Neurons[ARow-1]).weight:=StrToFloat(Value);
          self.m_neuronManager.getNeuronById(StrToInt(InputGrid.Cells[0,ARow])).Input:=
                                StrToFloat(InputGrid.Cells[1,ARow]);
        end
        else if Value[length(value)]='-' then
          self.m_neuronManager.getNeuronById(StrToInt(InputGrid.Cells[0,ARow])).Input:=0
        else
          self.InputGrid.Cells[1,ARow]:='0';
        end
      else
        self.InputGrid.Cells[1,ARow]:=' ';
    end;
end;

procedure TNetForm.btnResetClick(Sender: TObject);
begin
    self.m_neuronManager.resetInOutSimple();
    self.updateGrids;
end;

procedure TNetForm.InpSet0Click(Sender: TObject);
var i:Integer;
begin

     if self.m_numInput>0 then
     begin
      for i:=0 to self.InputGrid.RowCount-2 do
      begin
          self.InputGrid.Cells[1,i+1]:=valueMin.Text;
          self.m_neuronManager.getNeuronById(StrToInt(InputGrid.Cells[0,i+1])).Input:=StrToInt(self.valueMin.Text);
      end;
     end;
     
    //self.updateGrids;
    //self.updateNeurons;
end;

procedure TNetForm.OutSet0Click(Sender: TObject);
var i:Integer;
begin
    for i:=0 to self.m_neuronManager.getNumNeurons-1 do
    begin
        if self.m_neuronManager.getNeuron(i).Typ=NT_OUTPUT then
        begin
            self.m_neuronManager.getNeuron(i).Input:=0;
        end;
    end;

    self.updateGrids;
end;

procedure TNetForm.patternAddClick(Sender: TObject);
var tempInputList  : TList;
    tempSetOutputList : TList;
    i:Integer;
    tempInp:^Single;
    tempSetOut:^Single;

begin
  if (self.m_neuronManager.getNumNeurons>0) then
  begin
   if patternName.Text='' then
     ListPatterns.Items.Add('Muster '+IntToStr(ListPatterns.Items.Count))
   else
     ListPatterns.Items.Add(patternName.Text);

   patternName.Text:='';

   tempInputList:=TList.Create;
   tempSetOutputList:=TList.Create;

   for i:=0 to self.InputGrid.RowCount-2 do
   begin
       New(tempInp);
       tempInp^:=StrToFloat(self.InputGrid.Cells[1,i+1]);
       tempInputList.Add(tempInp);
   end;

   for i:=0 to self.ShouldGrid.RowCount-2 do
   begin
       New(tempSetOut);
       tempSetOut^:=StrToFloat(self.ShouldGrid.Cells[1,i+1]);
       tempSetOutputList.Add(tempSetOut);
   end;

   self.m_inputPattern.Add(tempInputList);
   self.m_setOutputPattern.Add(tempSetOutputList);

   self.ListPatterns.ItemIndex:=self.ListPatterns.Items.Count-1;

  end;

end;

procedure TNetForm.ShouldGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
    if (length(value)>0) then
    begin
      if self.m_neuronManager.getNumNeurons>0 then
      begin
        if (Value[length(value)] in [#8, '0'..'9', ',']) then
        begin
          //PConnection(self.Neuron.Neurons[ARow-1]).weight:=StrToFloat(Value);
         // self.m_neuronManager.getNeuronById(StrToInt(InputGrid.Cells[0,ARow])).Input:=
         //                       StrToInt(InputGrid.Cells[1,ARow]);
        end
        else if Value[length(value)]='-' then
          //self.m_neuronManager.getNeuronById(StrToInt(InputGrid.Cells[0,ARow])).Input:=0
        else
          self.ShouldGrid.Cells[1,ARow]:='0';
        end
      else
        self.ShouldGrid.Cells[1,ARow]:=' ';
    end;
end;

procedure TNetForm.ListPatternsClick(Sender: TObject);
begin
  self.updateGrids;
  self.updateNeurons;
end;

procedure TNetForm.patternDeleteClick(Sender: TObject);
begin
    if self.ListPatterns.ItemIndex>-1 then
    begin
      self.m_inputPattern.Delete(self.ListPatterns.ItemIndex);
      self.m_setOutputPattern.Delete(self.ListPatterns.ItemIndex);
      ListPatterns.DeleteSelected;
      ListPatterns.ItemIndex:=ListPatterns.Items.Count-1;
    end;
end;

procedure TNetForm.patternChangeClick(Sender: TObject);
var i:Integer;
begin
    if (self.ListPatterns.Count>0) then
    begin
     if patternName.Text<>'' then
     begin
       self.ListPatterns.Items[self.ListPatterns.ItemIndex]:=patternName.Text;
       patternName.Text:='';
     end;

     for i:=0 to self.InputGrid.RowCount-2 do
     begin
       Single(TList(self.m_inputPattern.items[self.ListPatterns.ItemIndex]).Items[i]^):=
             StrToFloat(self.InputGrid.Cells[1,i+1]);
     end;

     for i:=0 to self.ShouldGrid.RowCount-2 do
     begin
       Single(TList(self.m_setOutputPattern.items[self.ListPatterns.ItemIndex]).Items[i]^):=
             StrToFloat(self.ShouldGrid.Cells[1,i+1]);
     end;

    end;

end;

procedure TNetForm.btnTrainClick(Sender: TObject);
var i,j:Integer;
    currTime,prevTime:Extended;
    sPos:Integer;
    tempStr:String;
begin
    if self.ListPatterns.Count>0 then
    begin
      //for j:=0 to self.ListPatterns.Count-1 do
      //begin
        //self.ListPatterns.ItemIndex:=j;
        //self.ListPatternsClick(Sender);

       { for i:=0 to self.ShouldGrid.RowCount-2 do
        begin
         self.m_neuronManager.getNeuronById(StrToInt(self.ShouldGrid.Cells[0,i+1])).ShouldOutput:=
         StrToFloat(self.ShouldGrid.Cells[1,i+1]);
        end;
        }

        if self.m_train then
        begin
          sPos:=Pos(' ',self.epoch.Caption);
          i:=StrToInt(copy(self.epoch.Caption,sPos+1,length(self.epoch.Caption)));
        end
        else
        begin
          m_train:=true;
          self.m_neuronManager.randomWeights;
          self.btnStop.Caption:='stop';
          i:=0;
        end;
         prevTime:=GetTickCount;

        repeat

          if (StrToInt(self.numIterations.Text)>0) and
              (i>=StrToInt(self.numIterations.Text)) then
                break;

          self.ListPatterns.ItemIndex:=(i mod self.ListPatterns.Count);
          self.ListPatternsClick(Sender);

          //ShowMessage(IntToStr(self.ListPatterns.ItemIndex));
          self.btnResetClick(Sender);
          self.m_neuronManager.processNetwork;
          self.updateGrids;
          self.m_neuronManager.backpropagation;
          self.updateGrids;
          i:=i+1;

          if self.m_delay>0 then
          begin
            self.m_renderer.render(self.m_form,self.m_neuronManager);
            sleep(self.m_delay);
          end;
          self.epoch.Caption:='Epochen: '+IntToStr(i);

          currTime:=GetTickCount;

           Application.ProcessMessages;
          // ShowMessage(FloatToStr(self.m_neuronManager.getNeuron(self.m_neuronManager.getNumNeurons-1).deltaError)+' ');
        until (self.m_neuronManager.mse()<=StrToFloat(self.errorRate.Text)) or (m_train=false);
        //until i>=StrToInt(self.numIterations.Text);

         self.deltaTime.Caption:='Zeit: '+FloatToStr(currTime-prevTime)+' ms = '+
                                          FloatToStr((currTime-prevTime)*0.001)+' s = '+
                                          Format('%10.2f min',[(((currTime-prevTime)*0.001)/60)]);

        // ShowMessage(FloatToStr(self.m_neuronManager.mse()));
        //self.epoch.Caption:='Epochen: '+IntToStr(i);

      //end;
   end;


end;

procedure TNetForm.painterMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  self.m_draw:=true;
  self.m_canvas.MoveTo(X,Y);
end;

procedure TNetForm.painterMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  self.m_draw:=false;
  //self.m_canvas.LineTo(X,X);
end;

procedure TNetForm.rasterize();
var i,j,tempI,tempJ,k,l,m,n:Integer;
    minWidth,maxWidth:Integer;
    minHeight,maxHeight:Integer;
    width,height:Integer;
    isFilled:Boolean;
begin
    minWidth:=1000;
    minHeight:=1000;
    maxWidth:=1000;
    maxHeight:=1000;

    self.m_gridCanvas.Brush.Color:=clBlack;

    for i:=0 to self.painter.Height do
    begin
       for j:=0 to self.painter.Width do
       begin
           if self.m_canvas.Pixels[j,i]=clBlack then
           begin
               if (j<=minWidth) or (minWidth=1000) then
                minWidth:=j;
               if (j>=maxWidth) or (maxWidth=1000) then
                maxWidth:=j;
               if (i<=minHeight) or (minHeight=1000) then
                minHeight:=i;
               if (i>=maxHeight) or (maxHeight=1000) then
                maxHeight:=i;
           end;
       end;
    end;

    width:=maxWidth-minWidth;
    height:=maxHeight-minHeight;

    //ShowMessage('wmax: '+IntToStr(maxWidth)+' wmin: '+IntToStr(minWidth)+' hmax: '+IntToStr(maxHeight)+' hmin: '+IntToStr(minHeight)+' width: '+IntToStr(width)+' height: '+IntToStr(height));

    tempI:=minHeight;
    tempJ:=minWidth;

    isFilled:=false;

    for i:=minHeight to maxHeight do
    begin
       for j:=minWidth to maxWidth do
       begin
           if self.m_canvas.Pixels[j,i]=clBlack then
           begin
              for k:=0 to (StrToInt(self.gridHeigth.Text)) do
              begin
                for l:=0 to (StrToInt(self.gridWidth.Text)) do
                begin
                   if ((j)>l*(self.gridder.Width div StrToInt(self.gridWidth.Text))) and
                      ((j)<(l+1)*(self.gridder.Width div StrToInt(self.gridWidth.Text))) and
                      ((i)>k*(self.gridder.height div StrToInt(self.gridHeigth.Text))) and
                      ((i)<(k+1)*(self.gridder.height div StrToInt(self.gridHeigth.Text))) then
                   begin
                      if self.m_gridCanvas.Pixels[l*(self.gridder.Width div StrToInt(self.gridWidth.Text))+1,
                                                  k*(self.gridder.height div StrToInt(self.gridHeigth.Text))+1]=clWhite then
                      begin
                        self.m_gridCanvas.Rectangle(l*(self.gridder.Width div StrToInt(self.gridWidth.Text)),
                                            k*(self.gridder.height div StrToInt(self.gridHeigth.Text)),
                                            (l+1)*(self.gridder.Width div StrToInt(self.gridWidth.Text)),
                                            (k+1)*(self.gridder.height div StrToInt(self.gridHeigth.Text)));

                     // tempJ:=tempJ+l*(width div StrToInt(self.gridWidth.Text));
                     // tempI:=tempI+k*(height div StrToInt(self.gridHeigth.Text));

                      end;
                   end;
                end;
              end;
           end;
           //if tempJ>maxWidth then
           //   break;
           //tempJ:=tempJ+l*(width div StrToInt(self.gridWidth.Text));
       end;
       //if tempI>maxHeight then
       // break;
       //tempI:=tempI+k*(height div StrToInt(self.gridHeigth.Text));
    end;
end;

procedure TNetForm.painterMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if self.m_draw then
  begin
    if ssRight in Shift then
    begin
      self.m_canvas.Pixels[X,Y]:=clWhite;
      self.m_canvas.Pen.Color:=clWhite
    end
    else
    begin
      self.m_canvas.Pixels[X,Y]:=clBlack;
      self.m_canvas.Pen.Color:=clBlack;
    end;

    self.m_canvas.LineTo(X,Y);
    self.m_canvas.MoveTo(X,Y);

    //self.rasterize;
  end;

  self.drawGrids;
end;

procedure TNetForm.clearClick(Sender: TObject);
var i,j:Integer;
begin
  for i:=0 to self.painter.Width do
  begin
      for j:=0 to self.painter.Height do
      begin
          self.m_canvas.Pixels[i,j]:=clWhite;
      end;
  end;

end;

procedure TNetForm.drawGrids();
var j:Integer;
begin
    for j:=0 to StrToInt(self.gridHeigth.Text) do
    begin
        self.m_gridCanvas.MoveTo(0,j*(self.gridder.Height div StrToInt(self.gridHeigth.Text)));
        self.m_gridCanvas.LineTo(self.gridder.Width,j*(self.gridder.Height div StrToInt(self.gridHeigth.Text)));
    end;

    for j:=0 to StrToInt(self.gridWidth.Text) do
    begin
       self.m_gridCanvas.MoveTo(j*(self.gridder.Width div StrToInt(self.gridWidth.Text)),0);
       self.m_gridCanvas.LineTo(j*(self.gridder.Width div StrToInt(self.gridWidth.Text)),self.gridder.Height);
    end;

end;

procedure TNetForm.TabSheet2Show(Sender: TObject);
begin
    self.drawGrids;
end;

procedure TNetForm.gridderMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  self.drawGrids;
end;

procedure TNetForm.clearGridClick(Sender: TObject);
var i,j:Integer;
begin
  for i:=0 to self.painter.Width do
  begin
      for j:=0 to self.painter.Height do
      begin
          self.m_gridCanvas.Pixels[i,j]:=clWhite;
      end;
  end;

  self.drawGrids;
end;

procedure TNetForm.TrainingSetChange(Sender: TObject);
begin
   self.drawGrids;
end;

procedure TNetForm.TabSheet2ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
 self.drawGrids;
end;

procedure TNetForm.gridderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i,j,element:Integer;
begin

    for j:=0 to (StrToInt(self.gridHeigth.Text)) do
    begin
     for i:=0 to (StrToInt(self.gridWidth.Text)) do
     begin
        if (X>i*(self.gridder.Width div StrToInt(self.gridWidth.Text))) and
            (X<(i+1)*(self.gridder.Width div StrToInt(self.gridWidth.Text))) and
            (Y>j*(self.gridder.Height div StrToInt(self.gridHeigth.Text))) and
            (Y<(j+1)*(self.gridder.Height div StrToInt(self.gridHeigth.Text))) then
            begin
              if self.m_gridCanvas.Pixels[i*(self.gridder.Width div StrToInt(self.gridWidth.Text))+1,
                                          j*(self.gridder.Height div StrToInt(self.gridHeigth.Text))+1]=clBlack then
              begin
                                          self.m_gridCanvas.Brush.Color:=clWhite;
                                          self.m_gridCanvas.Pen.Color:=clWhite;
              end
              else
              begin
                self.m_gridCanvas.Brush.Color:=clBlack;
                self.m_gridCanvas.Pen.Color:=clBlack;
              end;

              self.m_gridCanvas.Rectangle(i*(self.gridder.Width div StrToInt(self.gridWidth.Text)),
                                          j*(self.gridder.Height div StrToInt(self.gridHeigth.Text)),
                                          (i+1)*(self.gridder.Width div StrToInt(self.gridWidth.Text)),
                                          (j+1)*(self.gridder.Height div StrToInt(self.gridHeigth.Text)));
            end;
     end;
    end;

    self.m_gridCanvas.Pen.Color:=clBlack;
end;

procedure TNetForm.btnRasterClick(Sender: TObject);
begin
  self.rasterize;
end;

procedure TNetForm.mapInputClick(Sender: TObject);
var i,j,k:Integer;
begin

  //for i:=0 to self.InputGrid.RowCount-1 do
  //begin
     //ShowMessage(self.InputGrid.Cells[1,i+1]);
     if self.m_numInput>0 then
     begin
      for j:=0 to StrToInt(self.gridHeigth.Text)-1 do
      begin
          for k:=0 to StrToInt(self.gridWidth.Text)-1 do
          begin
               if self.m_gridCanvas.Pixels[k*(self.gridder.Width div StrToInt(self.gridWidth.Text))+1,
                                           j*(self.gridder.Height div StrToInt(self.gridHeigth.Text))+1]=clBlack
                                           then
               begin
                  if self.m_numInput<(k+(j*StrToInt(self.gridHeigth.Text)+1)) then
                    break;

                  self.InputGrid.Cells[1,k+(j*StrToInt(self.gridHeigth.Text)+1)]:=ValueMax.Text;
    //             ShowMessage(IntToStr(k+(j*StrToInt(self.gridHeigth.Text)+1)));
               end
               else
                  self.InputGrid.Cells[1,k+(j*StrToInt(self.gridHeigth.Text)+1)]:=ValueMin.Text;
          end;
      end;

       self.updateNeurons;
      end;
end;

procedure TNetForm.ShouldSet0Click(Sender: TObject);
var i:Integer;
begin
   if self.m_numOutput>0 then
   begin
    for i:=0 to self.ShouldGrid.RowCount-2 do
    begin
       self.ShouldGrid.Cells[1,i+1]:=self.valueMin.Text;
    end;
   end;
   
end;

procedure TNetForm.patternSaveClick(Sender: TObject);
var  TempList: TStrings;
     temp:String;
     i,j:Integer;
begin
  if (sd.Execute) then
  begin
     TempList := TStringList.Create;
     TempList.Text := 'Lessons:';

     temp:=IntToStr(self.ListPatterns.Count);
     TempList.Add('nptr '+temp);

     for i:=0 to self.ListPatterns.Count-1 do
     begin
         temp:=self.ListPatterns.Items[i];
         TempList.Add('nptn '+temp);
     end;
     temp:=IntToStr(self.InputGrid.RowCount);
     TempList.Add('numi '+temp);
     temp:=IntToStr(self.ShouldGrid.RowCount);
     TempList.Add('nset '+temp);

     for j:=0 to self.ListPatterns.Count-1 do
     begin
       self.ListPatterns.ItemIndex:=j;
       self.ListPatternsClick(Sender);

       for i:=0 to self.InputGrid.RowCount-2 do
       begin
         temp := self.InputGrid.Cells[0,i+1];
         TempList.Add('niid '+temp);
         temp := self.InputGrid.Cells[1,i+1];
         TempList.Add('ninp '+temp);
       end;

       for i:=0 to self.ShouldGrid.RowCount-2 do
       begin
         temp := self.ShouldGrid.Cells[0,i+1];
         TempList.Add('nsid '+temp);
         temp := self.ShouldGrid.Cells[1,i+1];
         TempList.Add('nout '+temp);
       end;
     end;

     TempList.Add(':Lessons');
     TempList.SaveToFile(sd.FileName);

  end;

end;

procedure TNetForm.Button1Click(Sender: TObject);
var TempList:TStrings;
    Line:Integer;
    command:String;
    i:Integer;
    counterInp,counterSet,numPtr:Integer;
    tempInputList  : TList;
    tempSetOutputList : TList;
    tempInp:^Single;
    tempSetOut:^Single;
begin
  if(od.Execute) then
  begin
      self.m_inputPattern.Clear;
      self.m_setOutputPattern.Clear;
      self.ListPatterns.Clear;
      self.updateGrids;

      TempList:=TStringList.Create;
      tempInputList:=TList.Create;
      tempSetOutputList:=TList.Create;

      numPtr:=0;
      counterInp:=0;
      counterSet:=0;

      if FileExists(od.FileName) then
      begin

         TempList.LoadFromFile(od.FileName);

         for Line:=0 to TempList.Count-1 do
         begin
             command:= Copy(TempList.Strings[Line], 1, 4);

             case AnsiIndexText(command, ['nptr','nptn','numi','nset','niid','ninp','nsid','nout']) of
              0:begin
                   {command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
                   for i:=0 to nptr-1 do
                   begin
                      self.ListPatterns.Items.Add(IntToStr(i));
                   end;}
               end;
              1:begin
                  command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
                  self.ListPatterns.Items.Add(command);
               end;
               2:begin
                   command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
                   self.InputGrid.RowCount:=StrToInt(command);
                   self.m_numInput:=StrToInt(command)-1;
               end;
               3:begin
                  command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
                  self.ShouldGrid.RowCount:=StrToInt(command);
                  self.m_numOutput:=StrToInt(command)-1;
               end;
               4:begin
                  command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
                  self.InputGrid.Cells[0,counterInp+1]:=command;
                  counterInp:=counterInp+1;
               end;
               5:begin
                  command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
                  self.InputGrid.Cells[1,counterInp+1]:=command;
                  New(tempInp);
                  tempInp^:=StrToFloat(command);
                  tempInputList.Add(tempInp);

                  if counterInp>(self.InputGrid.RowCount-2) then
                  begin
                     self.m_inputPattern.Add(tempInputList);
                     counterInp:=0;
                     tempInputList:=TList.Create;
                  end;
               end;
               6:begin
                  command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
                  self.ShouldGrid.Cells[0,counterSet+1]:=command;
                  counterSet:=counterSet+1;
               end;
               7:begin
                  command := Copy(TempList.Strings[Line], 6, length(TempList.Strings[Line])-5);
                  self.ShouldGrid.Cells[1,counterSet+1]:=command;
                  New(tempSetOut);
                  tempsetOut^:=StrToFloat(command);
                  tempSetOutputList.Add(tempSetOut);

                  if counterSet>(self.ShouldGrid.RowCount-2) then
                  begin
                    self.m_setOutputPattern.Add(tempSetOutputList);
                    counterSet:=0;
                    tempSetOutputList:=TList.Create;
                  end;
               end;

             end;

         end;
      end;
  end;

  self.ListPatterns.ItemIndex:=0;
end;

procedure TNetForm.btnStopClick(Sender: TObject);
begin
  if self.m_train then
  begin
    self.m_train:=false;
    self.btnStop.Caption:='Fortsetzen';
  end
  else
  begin
    self.m_train:=true;
    self.btnStop.Caption:='Pause';
    self.btnTrainClick(Sender);
  end;
end;

procedure TNetForm.SetValueClick(Sender: TObject);
var k,j : Integer;
begin
      if self.m_numOutput>0 then
      begin
      for j:=0 to StrToInt(self.gridHeigth.Text)-1 do
      begin
          for k:=0 to StrToInt(self.gridWidth.Text)-1 do
          begin
               if self.m_gridCanvas.Pixels[k*(self.gridder.Width div StrToInt(self.gridWidth.Text))+1,
                                           j*(self.gridder.Height div StrToInt(self.gridHeigth.Text))+1]=clBlack
                                           then
               begin
                  if self.m_numOutput<(k+(j*StrToInt(self.gridHeigth.Text)+1)) then
                    break;

                  self.ShouldGrid.Cells[1,k+(j*StrToInt(self.gridHeigth.Text)+1)]:=ValueMax.Text;
    //             ShowMessage(IntToStr(k+(j*StrToInt(self.gridHeigth.Text)+1)));
               end
               else
                  self.ShouldGrid.Cells[1,k+(j*StrToInt(self.gridHeigth.Text)+1)]:=ValueMin.Text;
          end;
      end;


       self.updateNeurons;
      end;
end;

end.

