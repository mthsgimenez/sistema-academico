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
          Left = 26
          Top = 64
          Width = 75
          Height = 25
          Caption = 'Inserir'
          TabOrder = 0
          OnClick = buttonEstudanteInserirClick
        end
        object editEstudanteNome: TEdit
          Left = 26
          Top = 24
          Width = 121
          Height = 23
          TabOrder = 1
        end
        object listEstudantes: TListBox
          Left = 184
          Top = 24
          Width = 121
          Height = 97
          ItemHeight = 15
          TabOrder = 2
        end
        object buttonEstudanteAtualizar: TButton
          Left = 184
          Top = 136
          Width = 121
          Height = 25
          Caption = 'Atualizar'
          TabOrder = 3
          OnClick = buttonEstudanteAtualizarClick
        end
        object buttonEstudanteDeletar: TButton
          Left = 328
          Top = 23
          Width = 75
          Height = 25
          Caption = 'Deletar'
          TabOrder = 4
          OnClick = buttonEstudanteDeletarClick
        end
        object buttonEstudanteEditar: TButton
          Left = 328
          Top = 64
          Width = 75
          Height = 25
          Caption = 'Editar'
          TabOrder = 5
          OnClick = buttonEstudanteEditarClick
        end
        object buttonEstudanteEditarAcao: TButton
          Left = 26
          Top = 64
          Width = 75
          Height = 25
          Caption = 'Atualizar'
          TabOrder = 6
          Visible = False
          OnClick = buttonEstudanteEditarAcaoClick
        end
      end
      object tabProfessor: TTabSheet
        Caption = 'tabProfessor'
        ImageIndex = 1
      end
    end
  end
end
