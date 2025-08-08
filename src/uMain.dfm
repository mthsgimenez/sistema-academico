object formMain: TformMain
  Left = 0
  Top = 0
  Caption = 'Bem vindo'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  TextHeight = 15
  object panelMain: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 0
    object pageMain: TPageControl
      AlignWithMargins = True
      Left = 1
      Top = 1
      Width = 622
      Height = 439
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = tabAluno
      Align = alClient
      TabOrder = 0
      object tabAluno: TTabSheet
        Caption = 'tabAluno'
        object buttonEstudanteInserir: TButton
          Left = 147
          Top = 295
          Width = 75
          Height = 25
          Caption = 'Inserir'
          TabOrder = 0
          OnClick = buttonEstudanteInserirClick
        end
        object editEstudanteNome: TEdit
          Left = 3
          Top = 296
          Width = 121
          Height = 23
          TabOrder = 1
        end
        object buttonEstudanteDeletar: TButton
          Left = 536
          Top = 295
          Width = 75
          Height = 25
          Caption = 'Deletar'
          TabOrder = 2
          OnClick = buttonEstudanteDeletarClick
        end
        object buttonEstudanteEditar: TButton
          Left = 440
          Top = 295
          Width = 75
          Height = 25
          Caption = 'Editar'
          TabOrder = 3
          OnClick = buttonEstudanteEditarClick
        end
        object buttonEstudanteEditarAcao: TButton
          Left = 147
          Top = 296
          Width = 75
          Height = 25
          Caption = 'Atualizar'
          TabOrder = 4
          Visible = False
          OnClick = buttonEstudanteEditarAcaoClick
        end
        object gridEstudantes: TStringGrid
          Left = 3
          Top = 3
          Width = 608
          Height = 278
          ColCount = 2
          RowCount = 2
          ScrollBars = ssVertical
          TabOrder = 5
        end
      end
      object tabProfessor: TTabSheet
        Caption = 'tabProfessor'
        ImageIndex = 1
      end
    end
  end
end
