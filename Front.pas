unit Front;
{ copyright (c)2002 Eric Fredricksen all rights reserved }

{$mode delphi}{$H+}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls;

type
  TFrontForm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Button4: TButton;
    Label2: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Logo: TImage;
    Label3: TLabel;
    HomeLink: TLabel;
    procedure HomeLinkClick(Sender: TObject);
    procedure LogoClick(Sender: TObject);
  end;

var
  FrontForm: TFrontForm;

implementation

uses LCLIntf;

{$R *.lfm}

procedure TFrontForm.HomeLinkClick(Sender: TObject);
begin
  OpenURL('http://progressquest.com/');
end;

procedure TFrontForm.LogoClick(Sender: TObject);
begin
  OpenURL('http://progressquest.com/');
end;

end.
