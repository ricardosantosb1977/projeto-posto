inherited frmCadastroTanque: TfrmCadastroTanque
  Caption = 'Cadastro de Tanque'
  ClientHeight = 137
  ClientWidth = 353
  KeyPreview = True
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 359
  ExplicitHeight = 166
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 8
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel [1]
    Left = 56
    Top = 8
    Width = 36
    Height = 13
    Caption = 'Tanque'
  end
  object Label3: TLabel [2]
    Left = 8
    Top = 48
    Width = 58
    Height = 13
    Caption = 'Combust'#237'vel'
  end
  inherited Panel1: TPanel
    Top = 96
    Width = 353
    TabOrder = 3
    ExplicitTop = 96
    ExplicitWidth = 353
    inherited btnNovo: TButton
      Left = 30
      OnClick = btnNovoClick
      ExplicitLeft = 30
    end
    inherited btnExcluir: TButton
      Left = 110
      OnClick = btnExcluirClick
      ExplicitLeft = 110
    end
    inherited btnGravar: TButton
      Left = 190
      OnClick = btnGravarClick
      ExplicitLeft = 190
    end
    inherited btnFechar: TButton
      Left = 270
      OnClick = btnFecharClick
      ExplicitLeft = 270
    end
  end
  object edtCodigo: TEdit
    Left = 8
    Top = 24
    Width = 45
    Height = 21
    Alignment = taRightJustify
    CharCase = ecUpperCase
    MaxLength = 6
    TabOrder = 0
    Text = '000001'
    OnExit = edtCodigoExit
    OnKeyPress = edtCodigoKeyPress
  end
  object edtTanque: TEdit
    Left = 56
    Top = 24
    Width = 233
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 50
    TabOrder = 1
    Text = 'EDTTANQUE'
  end
  object cmbCombutivel: TComboBox
    Left = 8
    Top = 64
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    CharCase = ecUpperCase
    TabOrder = 2
  end
end
