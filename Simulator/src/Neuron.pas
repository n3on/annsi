//This file is a part of ANNSI-Project
//
//(c)2007/2008 by MAD-Crew
//Marcel S.,Alex L. D., Dimitri M.


//implementiert Neuronenstruktur
//
unit Neuron;

interface
uses
  Graphics,Classes,Dialogs,SysUtils,MathUtils;


type
  PConnection = ^NConnection;
  NConnection = record
    id: Integer;
    weight: Single;
  end;

type
  NeuronType = (NT_INPUT, NT_MIDDLE, NT_OUTPUT);
  FuncType   = (IDENTITY, BIN_TH, LIN_TH, SIN_TH, SIGM, TANH, OWN);

  CNeuron = class
  private
    {m_PosX:Integer; //position auf dem bildschirm
    m_PosY:Integer; //}
    m_Position:CVector2D;
    m_scaleFactor:Extended;
    m_id:Integer;//identifier
    m_connections:TList; //verbundene neuronen
    m_prevConnections:TList;
    m_type: NeuronType;
    m_threshold: Single;
    m_input: Single;
    m_activation: Single;
    m_output    : Single;
    m_activFunc : FuncType;
    m_deltaError: Single;
    m_setOutput : Single;

    {procedure SetPosX(PositionX:Integer);
    procedure SetPosY(PositionY:Integer);}
    procedure SetPosition(Position:CVector2D);
    procedure SetScaleFactor(ScaleFactor:Extended);
    procedure SetId(Id:Integer);
    procedure SetType(Typ:NeuronType);
    procedure SetInput(Input:Single);
    procedure SetActivation(Activation:Single);
    procedure SetThreshold(Threshold:Single);
    procedure SetOutput(Output:Single);
    procedure SetActivFunc(Func:FuncType);
    procedure SetDeltaError(DeltaError:Single);
    procedure SetSetOutput(setOutput:Single);

  public
    constructor Create();

    function connectTo(id:Integer; weight:Single):Integer;
    procedure SetPrevConnection(id:Integer;weight:Single);
    function reConnectTo(id:Integer):Integer;
    function isConnectedTo(id:Integer):Boolean;

    function activationFunction():Single;

    property Neurons  : TList   read m_connections;
    property PrevNeurons : TList read m_prevConnections;
    {property PositionX: Integer read m_PosX write SetPosX;
    property PositionY: Integer read m_PosY write SetPosY;}
    property Position: CVector2D read m_Position write SetPosition;
    property ScaleFactor: Extended read m_scaleFactor write SetScaleFactor;
    property Id       : Integer read m_id write SetId;
    property Typ     : NeuronType read m_type write SetType;
    property Input    : Single read m_input write SetInput;
    property Activation : Single read m_activation write SetActivation;
    property Threshold  : Single read m_threshold write SetThreshold;
    property Output     : Single read m_output    write SetOutput;
    property ActivFunc  : FuncType read m_activFunc write SetActivFunc;
    property DeltaError : Single read m_deltaError write SetDeltaError;
    property ShouldOutput  : Single read m_setOutput write SetSetOutput;

  end;

implementation

constructor CNeuron.Create();
begin
   self.m_connections:=TList.Create;
   self.m_prevConnections:=TList.Create;
   //self.m_PosX:=0;
   //self.m_PosY:=0;
   self.m_Position:=CVector2D.Create(0.0,0.0);
   //self.m_scaleFactor:=30;
   self.m_id:=-1;
   self.m_type:=NT_MIDDLE;
   self.m_activFunc:=SIGM;
end;

function CNeuron.connectTo(id:Integer; weight:Single):Integer;
var temp: PConnection;
    //tempObj: NConnection;
begin
  //temp:=@tempObj;
  New(temp);
  temp^.id := id;
  temp^.weight := weight;
  self.m_connections.Add(temp);
  result:=1;
end;

function CNeuron.reConnectTo(id:Integer):Integer;
var i:Integer;
begin
  //self.m_connections.Remove(Pointer(id));
  for i:= self.m_connections.Count-1 downto 0 do
  begin
    if PConnection(self.m_connections.Items[i]).Id=id then
    begin
        self.m_connections.Delete(i);
    end;
  end;

  //self.m_connections.Delete(id);
  result:=1;
end;

function CNeuron.isConnectedTo(id:Integer):Boolean;
var
  i:Integer;
begin

  Result:=false;

  for i:=0 to self.m_connections.Count-1 do
  begin
    if PConnection(self.m_connections[i]).Id = id then
        Result:=true;
  end;

end;

function CNeuron.activationFunction():Single;
begin

    case self.ActivFunc of
    IDENTITY:
            begin
              self.Activation:=self.input;
            end;
    BIN_TH: begin
              if self.Input>=self.Threshold then
              begin
                self.Activation:=1.0
              end
              else
                self.Activation:=0.0;
            end;
    LIN_TH: begin
            end;
    SIN_TH: begin
              
            end;
    SIGM:   begin
              self.Activation:= 1/(1+exp(-self.Input));
            end  ;
    TANH:   begin
            end;
    OWN:    begin
            end;
    end;

    result:=1;
end;

{procedure CNeuron.SetPosX(PositionX:Integer);
begin
    self.m_PosX:=PositionX;
end;

procedure CNeuron.SetPosY(PositionY:Integer);
begin
    self.m_PosY:=PositionY;
end;   }

procedure CNeuron.SetPosition(Position:CVector2D);
begin
  self.m_Position:=Position;
end;

procedure CNeuron.SetSetOutput(setOutput:Single);
begin
  self.m_setOutput:=SetOutput;
end;

procedure CNeuron.SetPrevConnection(id:Integer;weight:Single);
var temp: PConnection;
begin
  New(temp);
  temp^.id := id;
  temp^.weight := weight;
  self.m_prevConnections.Add(temp);
end;

procedure CNeuron.SetScaleFactor(ScaleFactor:Extended);
begin
   self.m_scaleFactor:=ScaleFactor;
end;

procedure CNeuron.SetId(Id:Integer);
begin
  if (Id>0) or (Id=0) then
  begin
    self.m_id:=Id;
  end
  else
    self.m_id:=-1;
end;

procedure CNeuron.SetDeltaError(DeltaError:Single);
begin
  self.m_deltaError:=DeltaError;
end;

procedure CNeuron.SetType(Typ:NeuronType);
begin
  self.m_type:=Typ;
end;

procedure CNeuron.SetInput(Input:Single);
begin
  self.m_input:=Input;
end;

procedure CNeuron.SetActivation(Activation:Single);
begin
  self.m_activation:=Activation;
end;

procedure CNeuron.SetThreshold(Threshold:Single);
begin
  self.m_threshold:=Threshold;
end;

procedure CNeuron.SetOutput(Output:Single);
begin
  self.m_output:=Output;
end;

procedure CNeuron.SetActivFunc(Func:FuncType);
begin
  self.m_activFunc:=Func;
end;

end.

