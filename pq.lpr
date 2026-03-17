program pq;

{$mode delphi}{$H+}

uses
  Interfaces,
  Forms,
  Config,
  Front,
  Main,
  NewGuy;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.Title := 'Progress Quest';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TK, K);
  Application.CreateForm(TFrontForm, FrontForm);
  Application.CreateForm(TNewGuyForm, NewGuyForm);
  Application.Run;
end.
