object formEstudante: TformEstudante
  Left = 0
  Top = 0
  Caption = 'Estudante'
  ClientHeight = 141
  ClientWidth = 197
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object panelEstudante: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 197
    Height = 141
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Caption = 'panelEstudante'
    ShowCaption = False
    TabOrder = 0
    object buttonConfirmar: TButton
      AlignWithMargins = True
      Left = 31
      Top = 84
      Width = 135
      Height = 25
      Margins.Left = 30
      Margins.Top = 30
      Margins.Right = 30
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = buttonConfirmarClick
    end
    object editEstudanteNome: TEdit
      AlignWithMargins = True
      Left = 31
      Top = 31
      Width = 135
      Height = 23
      Margins.Left = 30
      Margins.Top = 30
      Margins.Right = 30
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 1
    end
  end
end
