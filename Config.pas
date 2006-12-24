unit Config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TK = class(TForm)
    Spells: TMemo;
    Label1: TLabel;
    OffenseAttrib: TMemo;
    Label2: TLabel;
    DefenseAttrib: TMemo;
    Label3: TLabel;
    Shields: TMemo;
    Label4: TLabel;
    Armors: TMemo;
    Label5: TLabel;
    Weapons: TMemo;
    Label6: TLabel;
    Specials: TMemo;
    Label7: TLabel;
    ItemAttrib: TMemo;
    Label8: TLabel;
    ItemOfs: TMemo;
    Label9: TLabel;
    BoringItems: TMemo;
    Label10: TLabel;
    Monsters: TMemo;
    MonMods: TMemo;
    Label11: TLabel;
    Label12: TLabel;
    OffenseBad: TMemo;
    Label13: TLabel;
    DefenseBad: TMemo;
    Label14: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  K: TK;

implementation

{$R *.dfm}

end.