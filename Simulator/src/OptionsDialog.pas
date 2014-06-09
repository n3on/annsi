//This file is a part of ANNSI-Project
//
//(c)2007/2008 by MAD-Crew
//Marcel S.,Alex L. D., Dimitri M.


unit OptionsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,

  Neuron, NeuronManager,ComCtrls, Grids;

type
  TOptionsMenu = class(TForm)
    Button1: TButton;
    Button2: TButton;
    NeuronTypes: TComboBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    Input: TEdit;
    Threshold: TEdit;
    Label4: TLabel;
    Activation: TEdit;
    Label5: TLabel;
    ActivFunc: TComboBox;
    Label6: TLabel;
    Connections: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InputKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure WeightKeyPress(Sender: TObject; var Key: Char);
    procedure ConnectionsSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
  private
    { Private-Deklarationen }
    m_Neuron: CNeuron;

    procedure setNeuron(Neuron:CNeuron);
  public
    { Public-Deklarationen }
    ShowWeights : Integer;
    ShowInput   : Integer;
    ShowActivation : Integer;
    ShowThreshold : Integer;
    neuralNet : CNeuronManager;
    m_width,m_height:Integer;
    property Neuron:CNeuron read m_Neuron write setNeuron;
  end;

var
  OptionsMenu: TOptionsMenu;

implementation

{$R *.dfm}

procedure TOptionsMenu.setNeuron(Neuron:CNeuron);
begin
   m_Neuron:=Neuron;
end;

procedure TOptionsMenu.Button1Click(Sender: TObject);
var i:Integer;
    id:^Integer;
    neuron:CNeuron;
begin
    self.m_Neuron.Typ := NeuronType(NeuronTypes.ItemIndex);
    self.m_Neuron.ActivFunc := FuncType(ActivFunc.ItemIndex);

    if Input.Text <>'' then
      self.m_Neuron.Input := StrToFloat(Input.Text)
    else
       self.m_Neuron.Input := 0.0;

    if Activation.Text <>'' then
      self.m_Neuron.Activation := StrToFloat(Activation.Text)
    else
       self.m_Neuron.Activation := 0.0;

    if Threshold.Text <>'' then
      self.m_Neuron.Threshold := StrToFloat(Threshold.Text)
    else
       self.m_Neuron.Threshold := 0.0;

    neuron:=CNeuron.Create;
    New(Id);
    for i:=neuralNet.m_selectedNeurons.Count-1 downto 0 do
    begin
        id^:=Integer(self.neuralNet.m_selectedNeurons[i]^);
        neuron:=self.neuralNet.getNeuronById(id^);
        Neuron.Typ := NeuronType(NeuronTypes.ItemIndex);
        Neuron.ActivFunc := FuncType(ActivFunc.ItemIndex);
        if Input.Text <>'' then
          Neuron.Input := StrToFloat(Input.Text)
        else
          Neuron.Input := 0.0;

        if Activation.Text <>'' then
          Neuron.Activation := StrToFloat(Activation.Text)
        else
          Neuron.Activation := 0.0;

        if Threshold.Text <>'' then
          Neuron.Threshold := StrToFloat(Threshold.Text)
        else
          Neuron.Threshold := 0.0;
    end;


    self.Close;
end;

procedure TOptionsMenu.Button2Click(Sender: TObject);
begin
    Self.Close;
end;

procedure TOptionsMenu.FormShow(Sender: TObject);
var
  i:Integer;
begin

    PageControl1.ActivePageIndex:=0;
    if self.m_Neuron <> nil then
    begin
      self.NeuronTypes.ItemIndex := Integer(self.m_Neuron.Typ);
      self.Input.Text := FloatToStr(self.Neuron.Input);
      self.Activation.Text := FloatToStr(self.Neuron.Activation);
      self.Threshold.Text := FloatToStr(self.Neuron.Threshold);

      self.ActivFunc.ItemIndex := Integer(self.m_Neuron.ActivFunc);
    end;


    Connections.Cells[0,0]:='Verbunden mit: ';
    Connections.Cells[1,0]:='Gewicht: ';

    if self.Neuron.Neurons.Count>0 then
    begin
      self.Connections.RowCount:=2;
      self.Connections.ColCount:=2;
      for i:=0 to self.Neuron.Neurons.Count-1 do
      begin
        self.Connections.Cells[0,i+1]:=IntToStr(PConnection(self.Neuron.Neurons[i]).id);
        self.Connections.Cells[1,i+1]:=FloatToStr(PConnection(self.Neuron.Neurons[i]).weight);

        if i<self.Neuron.Neurons.Count-1 then
          self.Connections.RowCount:=self.Connections.RowCount+1;
      end;
    end

   // Style:=GetWindowLong(Input.Handle, GWL_STYLE);
    //SetWindowLong(Input.Handle, GWL_STYLE, style or ES_NUMBER);
end;

procedure TOptionsMenu.InputKeyPress(Sender: TObject; var Key: Char);
begin
  //allow just numbers and floating point separator
  if NOT (Key in [#8, '0'..'9', ',','-']) then
    Key := #0;
end;

procedure TOptionsMenu.FormCreate(Sender: TObject);
begin
    self.Visible:=false;
    self.m_Neuron:=nil;
end;

procedure TOptionsMenu.WeightKeyPress(Sender: TObject; var Key: Char);
begin
    if NOT (Key in [#8, '0'..'9', ',', '-']) then
    Key := #0;
end;

procedure TOptionsMenu.ConnectionsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
    if (length(value)>0) then
    begin
      if self.Neuron.Neurons.Count>0 then
      begin
        if (Value[length(value)] in [#8, '0'..'9', ',']) then
        begin
          PConnection(self.Neuron.Neurons[ARow-1]).weight:=StrToFloat(Value);
        end
        else if Value[length(value)]='-' then
           PConnection(self.Neuron.Neurons[ARow-1]).weight:=0
        else
          self.Connections.Cells[1,ARow]:='0';
        end
      else
        self.Connections.Cells[1,ARow]:=' ';
    end;
    
end;

end.

