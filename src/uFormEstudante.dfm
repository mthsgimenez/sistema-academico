object FormEstudante: TFormEstudante
  Left = 0
  Top = 0
  Caption = 'FormEstudante'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object editNomeEstudante: TEdit
    Left = 24
    Top = 32
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object listEstudantes: TListBox
    Left = 472
    Top = 32
    Width = 121
    Height = 97
    ItemHeight = 15
    TabOrder = 1
  end
  object buttonInsertEstudante: TButton
    Left = 24
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Inserir'
    TabOrder = 2
    OnClick = buttonInsertEstudanteClick
  end
  object buttonAtualizarEstudantes: TButton
    Left = 472
    Top = 152
    Width = 121
    Height = 25
    Caption = 'Atualizar'
    TabOrder = 3
    OnClick = buttonAtualizarEstudantesClick
  end
end
