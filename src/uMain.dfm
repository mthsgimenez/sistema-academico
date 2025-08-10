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
      ExplicitLeft = 2
      ExplicitTop = 0
      object tabAluno: TTabSheet
        Caption = 'tabAluno'
        OnHide = tabAlunoHide
        OnShow = tabAlunoShow
        object buttonEstudanteInserir: TButton
          AlignWithMargins = True
          Left = 5
          Top = 382
          Width = 75
          Height = 27
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Inserir'
          TabOrder = 0
          OnClick = buttonEstudanteInserirClick
        end
        object buttonEstudanteDeletar: TButton
          AlignWithMargins = True
          Left = 534
          Top = 382
          Width = 75
          Height = 27
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alRight
          Caption = 'Deletar'
          TabOrder = 1
          OnClick = buttonEstudanteDeletarClick
        end
        object buttonEstudanteEditar: TButton
          AlignWithMargins = True
          Left = 90
          Top = 382
          Width = 75
          Height = 27
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Editar'
          TabOrder = 2
          OnClick = buttonEstudanteEditarClick
        end
        object gridEstudantes: TStringGrid
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 604
          Height = 372
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          ColCount = 2
          FixedColor = clBtnShadow
          RowCount = 2
          ScrollBars = ssVertical
          TabOrder = 3
        end
      end
      object tabProfessor: TTabSheet
        Caption = 'tabProfessor'
        ImageIndex = 1
      end
    end
  end
end
