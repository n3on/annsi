//This file is a part of ANNSI-Project
//
//(c)2007/2008 by MAD-Crew
//Marcel S.,Alex L. D., Dimitri M.


//implementiert grafische ausgabe
//
unit Renderer;

interface
uses
  Forms,Graphics,Dialogs,SysUtils,
  Neuron,NeuronManager,OptionsDialog,Options;

type
  //verwende interfaces für mögliche api-portabilität
  //
  IRenderer = interface(IInterface)
    function init():Integer; //initialisiere die grafikapi
    function render(form:TForm;neuralNet:CNeuronManager):Integer;
    function shutdown():Integer;

    procedure showGrid(show:Boolean);
    procedure showDynColor(show:Boolean);
  end;

  //2D GDI-Grafik
  //
  CGDIRenderer = class(TInterfacedObject,IRenderer)
  private
    grid:Boolean;
    dynamicColor:Boolean;

    function rgb(red,green,blue:Byte):Tcolor;

  public
    m_settings : Tsettings;

    function init():Integer;
    function render(form:TForm;neuralNet:CNeuronManager):Integer;
    function shutdown():Integer;

    procedure showGrid(show:Boolean);
    procedure showDynColor(dyn:Boolean);
  end;

implementation

function CGDIRenderer.init():Integer;
begin

  result:=1;
end;

function CGDIRenderer.rgb(red,green,blue:Byte):TColor;
begin
  result:=StrToInt('$00'+IntToHex(blue,2)+IntToHex(green,2)+IntToHex(red,2));
end;

procedure CGDIRenderer.showGrid(show:Boolean);
begin
  self.grid:=show;
end;

procedure CGDIRenderer.showDynColor(dyn:Boolean);
begin
  self.dynamicColor:=dyn;
end;

function CGDIRenderer.render(form:TForm;neuralNet:CNeuronManager):Integer;
var
  i:Integer;    //laufindex für schleife
  j:Integer;
  k:Integer;
  tempCount:Integer;
  posX,posX2:Integer; //neuron position
  posY, posY2:Integer; //==
  scaleFactor:Extended;
  output:String;

begin

    form.Canvas.Pen.Style:=psSolid;
    form.Canvas.Brush.Style:=bsSolid;

  if self.grid then
  begin
      form.Canvas.Pen.Color:=settings.gridcolor;   {Grid color}
      form.Canvas.Brush.Color:=settings.gridcolor;
      scaleFactor:=neuralNet.ScaleFactor;

      for i:=0 to (form.ClientWidth div 2) do
      begin
          form.Canvas.MoveTo(i*Trunc(2*scaleFactor),0);
          form.Canvas.LineTo(i*Trunc(2*scaleFactor),form.ClientHeight);

          form.Canvas.MoveTo(0,i*Trunc(2*scaleFactor));
          form.Canvas.LineTo(form.ClientWidth,i*Trunc(2*scaleFactor));
      end;
  end;

  //neuronfarbe
  //form.Canvas.Pen.Color:=clBlue;
  //form.Canvas.Brush.Color:=clBlue;
  //zeichne alle neuronen
  for i:=neuralNet.getNumNeurons-1 downto 0 do
  begin
     tempCount:=0;
      //posX:=neuralNet.getNeuron(i).PositionX;
      //posY:=neuralNet.getNeuron(i).PositionY;
      posX:=Trunc(neuralNet.getNeuron(i).Position.X);
      posY:=Trunc(neuralNet.getNeuron(i).Position.Y);

      scaleFactor:=neuralNet.getNeuron(i).ScaleFactor;

      form.Canvas.Pen.Color := settings.conn; { Connection color }
      form.Canvas.Pen.Style := psSolid;
      form.Canvas.Font.Color:=settings.font;
      for j:=neuralNet.getNeuron(i).Neurons.Count-1 downto 0 do
      begin
          form.Canvas.MoveTo(posX+Trunc(scaleFactor/2),Trunc(posY+scaleFactor/2));
          //posX:=neuralNet.getNeuronById(Integer(NConnection(neuralNet.getNeuron(i).Neurons[j])[0])).Position;
          //posX:=PConnection(neuralNet.GetNeuron(i).Neurons[0]).id;

          if self.dynamicColor then
            form.Canvas.Pen.Color := RGB(Trunc(255/(0.1+PConnection(neuralNet.GetNeuron(i).Neurons[j]).weight)) mod 255,0,0);

          posX2:= Trunc(neuralNet.getNeuronById(PConnection(neuralNet.GetNeuron(i).Neurons[j]).id).Position.X);
          posY2:= Trunc(neuralNet.getNeuronById(PConnection(neuralNet.GetNeuron(i).Neurons[j]).id).Position.Y);
          form.Canvas.LineTo(posX2+Trunc(scaleFactor/2),
                              posY2+Trunc(scaleFactor/2));

          if (posX<=form.ClientWidth) and (posX+scaleFactor>=0) and (posY<=form.ClientHeight) and (posY+scaleFactor>=0) then
          begin
          case OptionsMenu.ShowWeights of
          1:begin
              output:=Format('%4.4f',[PConnection(neuralNet.GetNeuron(i).Neurons[j]).weight]);
              form.Canvas.Brush.Color:=clBlack;
              form.Canvas.TextOut(posX+((posX2-posX) div 2),posY-((posY-posY2) div 2),output{FloatToStr(PConnection(neuralNet.GetNeuron(i).Neurons[j]).weight)});
              form.Canvas.Brush.Color:=settings.font;
            end;
          2:begin
              form.Canvas.Brush.Color:=clBlack;
              form.Canvas.TextOut(posX,posY+30,'test');
              form.Canvas.Brush.Color:=settings.font;

            end;
          3:  ;
          end;//end case
          end;
      end; //end for

      if (posX<=form.ClientWidth) and (posX>=-scaleFactor) and (posY<=form.ClientHeight) and (posY>=-scaleFactor) then
      begin
      if tempCount>3 then
          tempCount:=3;

       case OptionsMenu.ShowInput of
          1:begin
              tempCount:=tempCount+1;
              output:=Format('I  : %4.4f',[neuralNet.GetNeuron(i).Input]);
              form.Canvas.Brush.Color:=clBlack;
              form.Canvas.TextOut(posX+Trunc(scaleFactor/2),posY+Trunc(scaleFactor)+(16*tempCount),output);
              form.Canvas.Brush.Color:=settings.font;
            end;
          2:begin
              form.Canvas.Brush.Color:=clBlack;
              form.Canvas.TextOut(posX+Trunc(scaleFactor),posY+Trunc(scaleFactor),'test');
              form.Canvas.Brush.Color:=settings.font;

            end;
          3:  ;
          end;

       case OptionsMenu.ShowActivation of
          1:begin
              tempCount:=tempCount+1;
              output:=Format('A : %4.4f',[neuralNet.GetNeuron(i).Activation]);
              form.Canvas.Brush.Color:=clBlack;
              form.Canvas.TextOut(posX+Trunc(scaleFactor/2),posY+Trunc(scaleFactor)+(tempCount*16),output);
              form.Canvas.Brush.Color:=settings.font;
            end;
          2:begin
              form.Canvas.Brush.Color:=clBlack;
              form.Canvas.TextOut(posX+Trunc(scaleFactor),posY+Trunc(scaleFactor),'test');
              form.Canvas.Brush.Color:=settings.font;

            end;
          3:  ;
          end;

       case OptionsMenu.ShowThreshold of
          1:begin
              tempCount:=tempCount+1;
              output:=Format('T : %4.4f',[neuralNet.GetNeuron(i).Threshold]);
              form.Canvas.Brush.Color:=clBlack;
              form.Canvas.TextOut(posX+Trunc(scaleFactor/2),posY+Trunc(scaleFactor)+(tempCount*16),output);
              form.Canvas.Brush.Color:=settings.font;
            end;
          2:begin
              form.Canvas.Brush.Color:=clBlack;
              form.Canvas.TextOut(posX+Trunc(scaleFactor),posY+Trunc(scaleFactor),'test');
              form.Canvas.Brush.Color:=settings.font;
            end;
          3:  ;
          end;
       end;
  end;//end for

  for i:=neuralNet.getNumNeurons-1 downto 0 do
  begin

       scaleFactor:=neuralNet.getNeuron(i).ScaleFactor;

      posX:=Trunc(neuralNet.getNeuron(i).Position.X);
      posY:=Trunc(neuralNet.getNeuron(i).Position.Y);

      if (posX<=form.ClientWidth) and (posX>=-scaleFactor) and (posY<=form.ClientHeight) and (posY>=-scaleFactor) then
      begin
      case neuralNet.getNeuron(i).Typ of
        NT_INPUT:
          begin
              form.Canvas.Pen.Color:=clLime;
              form.Canvas.Brush.Color:=settings.nin;
              if self.dynamicColor then
                form.Canvas.Brush.Color:=self.rgb(Trunc(255*(neuralNet.getNeuron(i).Input)) mod 256,
                                                    (Trunc(255*(neuralNet.getNeuron(i).Input)) mod 256),
                                                    (Trunc(255*(neuralNet.getNeuron(i).Input)) mod 256));
              form.Canvas.Brush.Style:=bsSolid;
          end;
        NT_MIDDLE:
          begin
              form.Canvas.Pen.Color:=clLime;
              form.Canvas.Brush.Color:=settings.nmid;
              if self.dynamicColor then
                 form.Canvas.Brush.Color:=self.rgb(Trunc(255*(neuralNet.getNeuron(i).Input)) mod 256,
                                                    (Trunc(255*(neuralNet.getNeuron(i).Input)) mod 256),
                                                    (Trunc(255*(neuralNet.getNeuron(i).Input)) mod 256));
              form.Canvas.Brush.Style:=bsSolid;
          end;
        NT_OUTPUT:
          begin
              form.Canvas.Pen.Color:=clLime;
              form.Canvas.Brush.Color:=settings.nout;
              if self.dynamicColor then
                 form.Canvas.Brush.Color:=self.rgb(Trunc(255*(neuralNet.getNeuron(i).Input)) mod 256,
                                                    (Trunc(255*(neuralNet.getNeuron(i).Input)) mod 256),
                                                    (Trunc(255*(neuralNet.getNeuron(i).Input)) mod 256));
              form.Canvas.Brush.Style:=bsSolid;
          end;
      end;

      if i=neuralNet.SelectedNeuron then
      begin
          form.Canvas.Pen.Color:=settings.nsel;
          form.Canvas.Brush.Style:=bsCross;
      end;

      for k:=0 to neuralNet.m_selectedNeurons.Count-1 do
      begin
          if Integer(neuralNet.m_selectedNeurons.Items[k]^)=neuralNet.getNeuron(i).Id then
          begin
            form.Canvas.Pen.Color:=settings.nsel;
            form.Canvas.Brush.Style:=bsCross;
          end;
      end;

     //neuralNet.getNeuron(i).show(form.Canvas,true);

      form.Canvas.Ellipse(posX,posY,Trunc(posX+scaleFactor),Trunc(posY+scaleFactor));
      end;
  end;

  result:=1;
end;//end render

function CGDIRenderer.shutdown():Integer;
begin

  result:=1;
end;//end shutdown

end.
