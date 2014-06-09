//This file is a part of ANNSI-Project
//
//(c)2007/2008 by MAD-Crew
//Marcel S.,Alex L. D., Dimitri M.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Tdebug = class(TForm)
    Memo1: TMemo;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  debug: Tdebug;

implementation

{$R *.dfm}

end.
