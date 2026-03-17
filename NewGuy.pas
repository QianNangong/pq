unit NewGuy;
{ copyright (c)2002 Eric Fredricksen all rights reserved }

{$mode delphi}{$H+}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls;

type
  TNewGuyForm = class(TForm)
    Race: TRadioGroup;
    Klass: TRadioGroup;
    Label2: TLabel;
    STR: TPanel;
    Label3: TLabel;
    CON: TPanel;
    Label4: TLabel;
    DEX: TPanel;
    Label5: TLabel;
    INT: TPanel;
    Label6: TLabel;
    WIS: TPanel;
    Label7: TLabel;
    CHA: TPanel;
    Reroll: TButton;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Total: TPanel;
    Sold: TButton;
    Unroll: TButton;
    Name: TLabeledEdit;
    Button2: TButton;
    Account: TLabeledEdit;
    Password: TLabeledEdit;
    Gen: TButton;
    procedure RerollClick(Sender: TObject);
    procedure UnrollClick(Sender: TObject);
    procedure SoldClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FRollHistory: TStringList;
    procedure RollEm;
    procedure UpdateTotal;
    function CurrentRollState: String;
    procedure RestoreRollState(const RollState: String);
  public
    function Go: Boolean;
  end;

var
  NewGuyForm: TNewGuyForm;

function UrlEncode(s: string): string;
function GenerateName: string;

implementation

uses Main, Config;

{$R *.lfm}

function UrlEncode(s: string): string;
const
  SafeChars = ['A'..'Z', 'a'..'z', '0'..'9', '-', '_', '.', '~'];
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(s) do
    if s[i] in SafeChars then
      Result := Result + s[i]
    else if s[i] = ' ' then
      Result := Result + '+'
    else
      Result := Result + '%' + IntToHex(Ord(s[i]), 2);
end;

procedure SetStatValue(Stat: TPanel; Value: Integer);
begin
  Stat.Tag := Value;
  Stat.Caption := IntToStr(Value);
end;

procedure Roll(stat: TPanel);
begin
  SetStatValue(stat, 3 + Random(6) + Random(6) + Random(6));
end;

function Choose(n, k: Integer): Real;
var
  d, i: Longint;
begin
  Result := n;
  d := 1;
  for i := 2 to k do begin
    Result := Result * (1+n-i);
    d := d * i;
  end;
  Result := Result / d;
end;

procedure TNewGuyForm.RollEm;
begin
  Roll(STR);
  Roll(CON);
  Roll(DEX);
  Roll(INT);
  Roll(WIS);
  Roll(CHA);
  UpdateTotal;
end;

procedure TNewGuyForm.UpdateTotal;
begin
  Total.Tag := STR.Tag + CON.Tag + DEX.Tag + INT.Tag + WIS.Tag + CHA.Tag;
  Total.Caption := IntToStr(Total.Tag);
  if Total.Tag >= (63+18) then Total.Color := clRed
  else if Total.Tag > (4 * 18) then Total.Color := clYellow
  else if Total.Tag <= (63-18) then Total.Color := clGray
  else if Total.Tag < (3 * 18) then Total.Color := clSilver
  else Total.Color := clWhite;
end;

function TNewGuyForm.CurrentRollState: String;
begin
  Result := Format('%d,%d,%d,%d,%d,%d',
    [STR.Tag, CON.Tag, DEX.Tag, INT.Tag, WIS.Tag, CHA.Tag]);
end;

procedure TNewGuyForm.RestoreRollState(const RollState: String);
var
  Parts: TStringList;
begin
  Parts := TStringList.Create;
  try
    Parts.StrictDelimiter := True;
    Parts.Delimiter := ',';
    Parts.DelimitedText := RollState;
    if Parts.Count <> 6 then Exit;
    SetStatValue(STR, StrToIntDef(Parts[0], STR.Tag));
    SetStatValue(CON, StrToIntDef(Parts[1], CON.Tag));
    SetStatValue(DEX, StrToIntDef(Parts[2], DEX.Tag));
    SetStatValue(INT, StrToIntDef(Parts[3], INT.Tag));
    SetStatValue(WIS, StrToIntDef(Parts[4], WIS.Tag));
    SetStatValue(CHA, StrToIntDef(Parts[5], CHA.Tag));
    UpdateTotal;
  finally
    Parts.Free;
  end;
end;

procedure TNewGuyForm.RerollClick(Sender: TObject);
begin
  FRollHistory.Add(CurrentRollState);
  Unroll.Enabled := FRollHistory.Count > 0;
  RollEm;
end;

function TNewGuyForm.Go: Boolean;
begin
  Tag := 1;
  Result := mrOk = ShowModal;
end;

procedure TNewGuyForm.FormShow(Sender: TObject);
begin
  if Tag > 0 then begin
    Tag := 0;
    Caption := 'Progress Quest - New Character';
    Randomize;
    FRollHistory.Clear;
    Unroll.Enabled := False;
    RollEm;
    with Race do
      ItemIndex := Random(Items.Count);
    with Klass do
      ItemIndex := Random(Items.Count);
  end;
end;

procedure TNewGuyForm.UnrollClick(Sender: TObject);
var
  LastIndex: Integer;
begin
  if FRollHistory.Count = 0 then Exit;
  LastIndex := FRollHistory.Count - 1;
  RestoreRollState(FRollHistory[LastIndex]);
  FRollHistory.Delete(LastIndex);
  Unroll.Enabled := FRollHistory.Count > 0;
end;

procedure TNewGuyForm.SoldClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

{
procedure TNewGuyForm.ServerAboutToSend(Sender: TObject);
begin
  Server.SendHeader.Values['Content-Type'] := 'text/plain';
  Server.SendHeader.Values['Motto'] := MainForm.GetMotto;
  Server.SendHeader.Values['Guild'] := MainForm.GetGuild;
end;
 }

function GenerateName: string;
const
  KParts: array [0..2] of string = (
    'br|cr|dr|fr|gr|j|kr|l|m|n|pr||||r|sh|tr|v|wh|x|y|z',
    'a|a|e|e|i|i|o|o|u|u|ae|ie|oo|ou',
    'b|ck|d|g|k|m|n|p|t|v|x|z');
var
  i: Integer;

  function Pick(s: string): string;
  var
    count, i: Integer;
  begin
    count := 1;
    for i := 0 to Length(s)-1 do
      if s[i] = '|' then Inc(count);
    Result := Split(s, Random(count));
  end;
begin
  Result := '';
  for i := 0 to 5 do
    Result := Result + Pick(KParts[i mod 3]);
  Result := UpperCase(Copy(Result,1,1)) + Copy(Result,2,Length(Result));
end;

procedure TNewGuyForm.GenClick(Sender: TObject);
begin
  Name.Text := GenerateName;
end;

procedure TNewGuyForm.FormActivate(Sender: TObject);
begin
  if Name.Text = '' then begin
    GenClick(Sender);
    Name.SetFocus;
  end;
end;

procedure TNewGuyForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  FRollHistory := TStringList.Create;
  Race.Items.Clear;
  for i := 0 to K.Races.Lines.Count-1 do
    Race.Items.Add(Split(K.Races.Lines[i],0));
  Klass.Items.Clear;
  for i := 0 to K.Klasses.Lines.Count-1 do
    Klass.Items.Add(Split(K.Klasses.Lines[i],0));
end;

procedure TNewGuyForm.FormDestroy(Sender: TObject);
begin
  FRollHistory.Free;
end;

end.
