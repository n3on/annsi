//This file is a part of ANNSI-Project
//
//(c)2007/2008 by MAD-Crew
//Marcel S.,Alex L. D., Dimitri M.

unit AddNeuronEx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,NeuronManager,Neuron;

type
  TaddNeuronExtended = class(TForm)
    Num: TEdit;
    Label1: TLabel;
    neType: TComboBox;
    Label2: TLabel;
    neActFunc: TComboBox;
    Label3: TLabel;
    neActivation: TEdit;
    Label4: TLabel;
    neInput: TEdit;
    Label5: TLabel;
    neThreshold: TEdit;
    Label6: TLabel;
    btCreate: TButton;
    btCancel: TButton;
    GroupBox1: TGroupBox;
    width: TEdit;
    Label7: TLabel;
    procedure NumKeyPress(Sender: TObject; var Key: Char);
    procedure neInputKeyPress(Sender: TObject; var Key: Char);
    procedure btCreateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }

    n_num:Integer;
    n_activation:Single;
    n_input:Single;
    n_th:Single;
    n_typ:Integer;
    n_func:Integer;

    neuronManager:CNeuronManager;

  end;

var
  addNeuronExtended: TaddNeuronExtended;

implementation

{$R *.dfm}

procedure TaddNeuronExtended.NumKeyPress(Sender: TObject; var Key: Char);
begin
  if NOT (Key in [#8, '0'..'9']) then
    Key := #0;
end;

procedure TaddNeuronExtended.neInputKeyPress(Sender: TObject;
  var Key: Char);
begin
  if NOT (Key in [#8, '0'..'9', ',','-']) then
    Key := #0;
end;

procedure TaddNeuronExtended.btCreateClick(Sender: TObject);
var  neuron:CNeuron;
     xPos,yPos,i:Integer;
begin
    self.n_num:=StrToInt(self.Num.Text);
    self.n_activation:=StrToFloat(self.neActivation.Text);
    self.n_input:=StrToFloat(self.neInput.Text);
    self.n_th:=StrToFloat(self.neThreshold.Text);
    self.n_typ:=self.neType.ItemIndex;
    self.n_func:=self.neActFunc.ItemIndex;

     yPos:=50;
     xPos:=50;
     for i:=0 to self.n_num-1 do
     begin
       neuron:=CNeuron.Create;
       neuron.Typ:=NeuronType(self.n_typ);
       neuron.ActivFunc:=FuncType(self.n_func);
       neuron.Activation:=self.n_activation;
       neuron.Input:=self.n_input;
       neuron.Threshold:=self.n_th;

       if (i mod StrToInt(self.width.Text))=0 then
       begin
         xPos:=100;
         yPos:=yPos+2*Trunc(self.neuronManager.ScaleFactor);
       end
       else
         xPos:=xPos+2*Trunc(self.neuronManager.ScaleFactor);

       neuron.Position.Y:=yPos;
       neuron.Position.X:=xPos;

       self.neuronManager.addNeuron(neuron);
       //neuron.Free;
     end;//end for

    self.Close;
end;

procedure TaddNeuronExtended.FormShow(Sender: TObject);
begin
    self.n_num:=1;
    self.n_activation:=0;
    self.n_input:=0;
    self.n_th:=0;
    self.n_typ:=0;
    self.n_func:=0;

    self.Num.Text:=IntToStr(self.n_num);
    self.neActivation.Text:=FloatToStr(self.n_activation);
    self.neInput.Text:=FloatToStr(self.n_input);
    self.neThreshold.Text:=FloatToStr(self.n_th);
    self.neType.ItemIndex:=self.n_typ;
    self.neActFunc.ItemIndex:=self.n_func;

end;

procedure TaddNeuronExtended.btCancelClick(Sender: TObject);
begin
  self.Close;
end;

end.
