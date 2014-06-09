//This file is a part of ANNSI-Project
//
//(c)2007/2008 by MAD-Crew
//Marcel S.,Alex L. D., Dimitri M.

unit NeuronManager;

interface

uses
  Neuron, Classes;

type
  CNeuronManager = class
  private
    m_NeuronList:TList;
    m_lastId    :Integer;
    m_selectedNeuron :Integer;
    m_scaleFactor : Extended;
    m_trainingRate : Single;

    procedure SetScaleFactor(ScaleFactor:Extended);
    procedure SetTrainingRate(TrainingRate:Single);

    procedure SetSelect(SelectedNeuron:Integer);
    procedure NetMiddleInputWeights();
    procedure NetOutputWeights();
    procedure NetMiddleActivation();
    procedure NetOutputActivation();


  public
     m_selectedNeurons:TList;

    constructor Create();
    procedure addNeuron(neuron:CNeuron);
    procedure addNeuronEx(neuron:CNeuron);
    function connectNeurons(neuronId1:Integer;neuronId2:Integer):Integer;
    function connectNeuronsDir(neuronId1:Integer;neuronId2:Integer):Integer;
    function reConnectNeurons(neuronId1:Integer; neuronId2:Integer):Integer;
    function reConnectNeuronsDir(neuronId1:Integer; neuronId2:Integer):Integer;
    function getNeuron(index:Integer):CNeuron;
    function getNeuronById(id:Integer):CNeuron;
    function removeNeuron(index:Integer):Integer;
    function removeNeuronDir(index:Integer):Integer;
    function randomWeights():Integer;
    function removeNeuronById(id:Integer):Integer;
    function removeNeuronByIdDir(id:Integer):Integer;
    function getNumNeurons():Integer; //anzahl der neuronen im netz
    function clearNet():Integer;
    function processNetwork():Integer;
    function resetNet():Integer;
    function resetNetSimple():Integer;
    function resetInOutSimple():Integer;

    function backpropagation():Integer;

    function translate(x:Extended;y:Extended):Integer;
    function rotate(angle:Extended):Integer;
    function scale(x:Extended;y:Extended):Integer;

    function mse():Single;

    property SelectedNeuron : Integer read m_selectedNeuron write SetSelect;
    property ScaleFactor : Extended read m_scaleFactor write SetScaleFactor;
    property TrainingRate : Single read m_trainingRate write SetTrainingRate;
  end;

implementation

  uses Dialogs, SysUtils, MathUtils;

  constructor CNeuronManager.Create();
  begin
    self.m_NeuronList:=TList.Create;
    self.m_selectedNeurons:=TList.Create;
    self.m_lastId    := 0;
    self.m_selectedNeuron:=-1;
    self.m_scaleFactor:=30;
    self.m_trainingRate:=0.3;
  end;

  procedure CNeuronManager.SetScaleFactor(ScaleFactor:Extended);
  begin
      self.m_scaleFactor:=ScaleFactor;
  end;

  procedure CNeuronManager.SetTrainingRate(TrainingRate:Single);
  begin
      self.m_trainingRate:=TrainingRate;
  end;

  procedure CNeuronManager.SetSelect(SelectedNeuron:Integer);
  begin
    if (SelectedNeuron>0) or (SelectedNeuron=0) then
      self.m_selectedNeuron:=SelectedNeuron;
  end;

  procedure CNeuronManager.addNeuron(neuron:CNeuron);
  begin
    neuron.Id:=self.m_lastId;
    self.m_lastId:= m_lastId+1;
    neuron.ScaleFactor:=self.m_scaleFactor;
    self.m_NeuronList.Add(neuron);
  end;

  procedure CNeuronManager.addNeuronEx(neuron:CNeuron);
  begin
     self.m_lastId:=neuron.Id+1;
     self.m_NeuronList.Add(neuron);
  end;

  function CNeuronManager.connectNeurons(neuronId1:Integer;neuronId2:Integer):Integer;
  begin
        self.getNeuronById(neuronId1).connectTo(neuronId2,0);
        self.getNeuronById(neuronId2).connectTo(neuronId1,0);
    result:=1;
  end;

  function CNeuronManager.resetNet():Integer;
  var i:Integer;
  begin
      for i:=self.getNumNeurons-1 downto 0 do
      begin
         self.getNeuron(i).Activation:=0;
         self.getNeuron(i).Input:=0;
         self.getNeuron(i).Output:=0;
      end;

      result:=1;
  end;

  function CNeuronManager.resetNetSimple():Integer;
  var i:Integer;
  begin
      for i:=self.getNumNeurons-1 downto 0 do
      begin
         self.getNeuron(i).Activation:=0;
         self.getNeuron(i).Output:=0;
      end;

      result:=1;
  end;

  function CNeuronManager.resetInOutSimple():Integer;
  var i:Integer;
  begin
      for i:=self.getNumNeurons-1 downto 0 do
      begin
         self.getNeuron(i).Activation:=0;
         self.getNeuron(i).Output:=0;
         if (self.getNeuron(i).Typ=NT_MIDDLE) or (self.getNeuron(i).Typ=NT_OUTPUT) then
          self.getNeuron(i).Input:=0;
      end;

      result:=1;
  end;

  function CNeuronManager.connectNeuronsDir(neuronId1:Integer;neuronId2:Integer):Integer;
  begin
      self.getNeuronById(neuronId1).connectTo(neuronId2,0);

      //if self.getNeuronById(neuronId2)<>nil then
          self.getNeuronById(neuronId2).SetPrevConnection(neuronId1,0);
      //else
      {begin
          neuron:=CNeuron.Create;
          neuron.Id:=neuronId2;
          self.addNeuronEx(neuron);
          self.getNeuronById(neuronId2).SetPrevConnection(neuronId1,0);
      end;}
      result:=1;
  end;

  function CNeuronManager.reConnectNeurons(neuronId1:Integer;neuronId2:Integer):Integer;
  begin
      self.getNeuronById(neuronId1).reConnectTo(neuronId2);
      if self.getNeuronById(neuronId2)<>nil then
        self.getNeuronById(neuronId2).reConnectTo(neuronId1);


      result := 1;
  end;

  function CNeuronManager.reConnectNeuronsDir(neuronId1:Integer;neuronId2:Integer):Integer;
  var i:Integer;
  begin
      self.getNeuronById(neuronId1).reConnectTo(neuronId2);

      for i:=(self.getNeuronById(neuronId2).PrevNeurons.Count-1) downto 0 do
      begin
          if PConnection(self.getNeuronById(neuronId2).PrevNeurons.Items[i]).Id=neuronId1 then
          begin
              self.getNeuronById(neuronId2).PrevNeurons.Delete(i);
              //self.getNeuronById(neuronId2).reConnectTo(neuronId1);
          end;
      end;

      result := 1;
  end;

  function CNeuronManager.removeNeuron(index:Integer):Integer;
  var
    i:Integer;
  begin

    for i:=self.getNeuron(index).PrevNeurons.Count-1 downto 0 do
    begin
      self.reConnectNeuronsDir(PConnection(self.getNeuron(index).PrevNeurons.Last).Id,
                              self.getNeuron(index).Id);
    end;

    for i:=self.getNeuron(index).Neurons.Count-1 downto 0 do
     begin
      self.reConnectNeuronsDir(self.getNeuron(index).Id,
                          PConnection(self.getNeuron(index).Neurons.last).Id);
    end;

    self.getNeuron(index).PrevNeurons.Clear;
    //TObject(self.m_NeuronList.Items[index]).Free;
    self.m_NeuronList.Delete(index);

    result:=1;

  end;

  function CNeuronManager.removeNeuronDir(index:Integer):Integer;
  begin

    result:=1;
  end;

  function CNeuronManager.randomWeights():Integer;
  var i,j,z:Integer;
      randValue:Single;
  begin
    for i:=self.getNumNeurons-1 downto 0 do
    begin
      for j:=self.getNeuron(i).Neurons.Count-1 downto 0 do
      begin
            randValue:=(Random(200)/100)-1;

            PConnection(self.GetNeuron(i).Neurons[j]).weight:=randValue;

            for z:=self.getNeuronById(PConnection(
                  self.GetNeuron(i).Neurons[j]).id).Neurons.Count-1 downto 0 do
            begin
              if PConnection(self.getNeuronById(PConnection(
                            self.GetNeuron(i).Neurons[j]).id).Neurons[z]).id =
                            self.GetNeuron(i).Id then
              begin
                  PConnection(self.getNeuronById(PConnection(
                        self.GetNeuron(i).Neurons[j]).Id).Neurons[z]).weight:=randValue;
              end;   //end if
            end; //end for
      end;//end for
  end;//end for

  result:=1;
  end;

  function CNeuronManager.removeNeuronById(id:Integer):Integer;
  var
    i:Integer;
  begin
    for i:=self.getNumNeurons-1 downto 0 do
    begin
       if (CNeuron(m_NeuronList.Items[i]).Id = id) then
        self.removeNeuron(i);
    end;

    result:=1;
  end;

  function CNeuronManager.removeNeuronByIdDir(id:integer):Integer;
  begin

    result:=1;
  end;

  function CNeuronManager.getNeuron(index:Integer):CNeuron;
  begin
   result := self.m_NeuronList[index];
  end;

  function CNeuronManager.getNeuronById(id:Integer):CNeuron;
  var
    i:Integer;
  begin
    result:=nil;

    for i:=0 to self.getNumNeurons-1 do
    begin
       if (CNeuron(m_NeuronList[i]).Id = id) then
        result:=self.m_NeuronList[i];
    end;

  end;

  function CNeuronManager.getNumNeurons():Integer;
  begin
    result := self.m_NeuronList.Count;
  end;

  function CNeuronManager.clearNet():Integer;
  begin
    self.m_NeuronList.Clear;
    self.m_selectedNeurons.Clear;
    self.m_lastId:=0;

    result:=1;
  end;

  procedure CNeuronManager.NetMiddleInputWeights();
  var i:Integer;
      j,k:Integer;
      id:Integer;
      weight:Single;
  begin
      weight:=1;

      for i:=0 to self.getNumNeurons-1 do
    begin
       if self.getNeuron(i).Typ=NT_INPUT then
          self.getNeuron(i).Output:=self.getNeuron(i).Input
       else if self.getNeuron(i).Typ=NT_MIDDLE then
       begin
          //ShowMessage(IntToStr(self.getNeuron(i).id));
          for j:=0 to self.getNeuron(i).PrevNeurons.Count-1 do
          begin
            id:=PConnection(self.getNeuron(i).PrevNeurons[j]).id;
            //ShowMessage(IntToStr(id));
            for k:=0 to self.getNeuronById(id).Neurons.Count-1 do
            begin
                if PConnection(self.getNeuronById(id).Neurons[k]).id=self.getNeuron(i).Id then
                begin
                  weight:=PConnection(self.getNeuronById(id).Neurons[k]).weight;
                end;
            end;

            self.getNeuron(i).Input:=self.getNeuron(i).Input+
            self.getNeuronById(id).Input*weight;

          end;
       end;
    end;
  end;

  procedure CNeuronManager.NetOutputWeights();
  var i:Integer;
      j,k:Integer;
      id:Integer;
      weight:Single;
  begin
    weight:=1;
    
     //set middle layer+input weights
    for i:=0 to self.getNumNeurons-1 do
    begin
       if self.getNeuron(i).Typ=NT_OUTPUT then
       begin
          //ShowMessage(IntToStr(self.getNeuron(i).id));
          for j:=0 to self.getNeuron(i).PrevNeurons.Count-1 do
          begin
            id:=PConnection(self.getNeuron(i).PrevNeurons[j]).id;
            //ShowMessage(IntToStr(id));
            for k:=0 to self.getNeuronById(id).Neurons.Count-1 do
            begin
                if PConnection(self.getNeuronById(id).Neurons[k]).id=self.getNeuron(i).Id then
                begin
                  weight:=PConnection(self.getNeuronById(id).Neurons[k]).weight;
                end;
            end;

            self.getNeuron(i).Input:=self.getNeuron(i).Input+
            self.getNeuronById(id).Input*weight;

          end;
       end;
    end;
  end;

  procedure CNeuronManager.NetMiddleActivation();
  var i:Integer;
  begin
     for i:=0 to self.getNumNeurons-1 do
    begin
       if (self.getNeuron(i).Typ=NT_MIDDLE) then
       begin
            self.getNeuron(i).activationFunction();
            self.getNeuron(i).Input:=self.getNeuron(i).Activation;
       end;
    end;
  end;

  procedure CNeuronManager.NetOutputActivation();
  var i:Integer;
  begin
     for i:=0 to self.getNumNeurons-1 do
    begin
       if (self.getNeuron(i).Typ=NT_OUTPUT) then
       begin
            self.getNeuron(i).activationFunction();
            self.getNeuron(i).Input:=self.getNeuron(i).Activation;
            //self.getNeuron(i).activationFunction();
            //self.getNeuron(i).Output:=self.getNeuron(i).Activation;
            //self.getNeuron(i).Input:=self.getNeuron(i).Output;
       end;
    end;
  end;


  function CNeuronManager.processNetwork():Integer;
  begin
    self.NetMiddleInputWeights;
    self.NetMiddleActivation;
    self.NetOutputWeights;
    self.NetOutputActivation;

    result:=1;
  end;

  function CNeuronManager.mse():Single;
  var mse : Single;
      i   : Integer;
  begin
      result:=0;

      mse:=0.0;

      for i:=0 to self.getNumNeurons-1 do
      begin
          if self.getNeuron(i).Typ=NT_OUTPUT then
          begin
            mse:=mse+((self.getNeuron(i).ShouldOutput-self.getNeuron(i).Input)*
                          (self.getNeuron(i).ShouldOutput-self.getNeuron(i).Input));
          end;
      end;

      result:=mse/2;
  end;

  function CNeuronManager.backpropagation():Integer;
  var i,j:Integer;
      sum:Single;
      deltaW:Single;
  begin
    //self.processNetwork;

    for i:=0 to self.getNumNeurons-1 do
    begin
        if self.getNeuron(i).Typ=NT_OUTPUT then
        begin
           self.getNeuron(i).DeltaError:=self.getNeuron(i).Input*(1-self.getNeuron(i).Input)*(self.getNeuron(i).ShouldOutput-self.getNeuron(i).Input);
           //ShowMessage(FloatToStr(self.getNeuron(i).ShouldOutput)+' '+FloatToStr(self.getNeuron(i).Input)+' '+FloatToStr(self.getNeuron(i).DeltaError));
        end;
    end;

    for i:=0 to self.getNumNeurons-1 do
    begin
        
        if self.getNeuron(i).Typ=NT_MIDDLE then
        begin
           sum:=0;
           for j:=self.getNeuron(i).Neurons.Count-1 downto 0 do
           begin
                  sum:=sum+self.getNeuronById(PConnection(self.getNeuron(i).Neurons.Items[j]).id).DeltaError*
                           PConnection(self.getNeuron(i).Neurons.Items[j]).weight;
                 //ShowMessage(FloattoStr(self.getNeuronById(PConnection(self.getNeuron(i).Neurons.Items[j]).id).DeltaError));
                 //ShowMessage(FloatToStr(PConnection(self.getNeuron(i).Neurons.Items[j]).weight));
           end;

           self.getNeuron(i).DeltaError:=self.getNeuron(i).Input*(1-self.getNeuron(i).Input)*sum;
           //ShowMessage(FloatToStr(sum)+' '+FloatToStr(self.getNeuron(i).DeltaError));
        end;
    end;

    for i:=0 to self.getNumNeurons-1 do
    begin
        //if self.getNeuron(i).Typ=NT_INPUT then
        //begin
            deltaW:=0;
            for j:=self.getNeuron(i).Neurons.Count-1  downto 0 do
            begin
               deltaW:=self.TrainingRate*self.getNeuronById(Integer(PConnection(self.getNeuron(i).Neurons.Items[j]).id)).DeltaError*self.getNeuron(i).Input;

               PConnection(self.getNeuron(i).Neurons.Items[j]).weight:=
               PConnection(self.getNeuron(i).Neurons.Items[j]).weight+deltaW;

               //ShowMessage(FloatToStr(PConnection(self.getNeuron(i).Neurons.Items[j]).weight));
               //if self.getNeuron(i).Typ=NT_INPUT then
               //  ShowMessage(IntToStr(Integer(self.getNeuronById(Integer(PConnection(self.getNeuron(i).Neurons.Items[j]).id)).Typ)));
               //ShowMessage(FloatToStr(PConnection(self.getNeuron(i).Neurons.Items[j]).weight));
            end;
        //end;
    end;

    result:=1;
  end;



  function CNeuronManager.translate(x:Extended;y:Extended):Integer;
  begin

    result:=1;
  end;

  function CNeuronManager.rotate(angle:Extended):Integer;
  begin

    result:=1;
  end;

  function CNeuronManager.scale(x:Extended;y:Extended):Integer;
  var
      i:Integer;
      oldScale:Extended;
      matrix:CMatrix2D;
  begin

      matrix:=CMatrix2D.Create;
      matrix.setIdentity;

      if ((self.m_scaleFactor>=5) and (x<1)) or ((self.m_scaleFactor<=300) and (x>1)) then
      begin
        self.m_scaleFactor:=self.m_scaleFactor*x;
      end;

      for i:=self.getNumNeurons-1 downto 0 do
      begin
          oldScale:=self.getNeuron(i).ScaleFactor;

          if ((oldScale>=5) and (x<1)) or ((oldScale<=300) and (x>1)) then
          begin
              self.getNeuron(i).ScaleFactor:=oldScale*x;
              matrix.setIdentity;
              matrix.scale(x,y);
              self.getNeuron(i).Position.transform(matrix);
          end;

      end;

    result:=1;
  end;

end.
