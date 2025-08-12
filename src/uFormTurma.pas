unit uFormTurma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TformTurma = class(TForm)
    panelTurma: TPanel;
    comboTurmaProfessor: TComboBox;
    labelTurmaProfessor: TLabel;
    labelTurmaDisciplina: TLabel;
    comboTurmaDisciplina: TComboBox;
    buttonConfirmar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formTurma: TformTurma;

implementation

{$R *.dfm}

end.
