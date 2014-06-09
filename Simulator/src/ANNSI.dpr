program ANNSI;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Neuron in 'Neuron.pas',
  Renderer in 'Renderer.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  NeuronManager in 'NeuronManager.pas',
  OptionsDialog in 'OptionsDialog.pas' {OptionsMenu},
  Unit1 in 'Unit1.pas' {debug},
  MathUtils in 'MathUtils.pas',
  AddNeuronEx in 'AddNeuronEx.pas' {addNeuronExtended},
  NetEditUnit in 'NetEditUnit.pas' {NetForm},
  Options in 'Options.pas' {settings};

{$E exe}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ANNSI';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TOptionsMenu, OptionsMenu);
  Application.CreateForm(Tdebug, debug);
  Application.CreateForm(TaddNeuronExtended, addNeuronExtended);
  Application.CreateForm(TNetForm, NetForm);
  Application.CreateForm(Tsettings, settings);
  Application.Run;
end.
