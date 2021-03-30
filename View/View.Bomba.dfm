inherited frmCadastroBomba: TfrmCadastroBomba
  Caption = 'Cadastro de Bomba'
  ClientHeight = 163
  ClientWidth = 391
  KeyPreview = True
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 397
  ExplicitHeight = 192
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
    Width = 46
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object Label3: TLabel [2]
    Left = 8
    Top = 48
    Width = 36
    Height = 13
    Caption = 'Tanque'
  end
  inherited Panel1: TPanel
    Top = 122
    Width = 391
    TabOrder = 3
    ExplicitTop = 96
    ExplicitWidth = 349
    inherited btnNovo: TButton
      Left = 20
      OnClick = btnNovoClick
      ExplicitLeft = 20
    end
    inherited btnExcluir: TButton
      Left = 116
      OnClick = btnExcluirClick
      ExplicitLeft = 116
    end
    inherited btnGravar: TButton
      Left = 212
      OnClick = btnGravarClick
      ExplicitLeft = 212
    end
    inherited btnFechar: TButton
      Left = 308
      OnClick = btnFecharClick
      ExplicitLeft = 266
    end
  end
  object edtCodigo: TEdit
    Left = 8
    Top = 24
    Width = 45
    Height = 21
    Alignment = taRightJustify
    CharCase = ecUpperCase
    TabOrder = 0
    Text = '000001'
    OnExit = edtCodigoExit
    OnKeyPress = edtCodigoKeyPress
  end
  object edtDescricao: TEdit
    Left = 56
    Top = 24
    Width = 233
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object cmbTanque: TComboBox
    Left = 8
    Top = 64
    Width = 201
    Height = 22
    Style = csOwnerDrawFixed
    CharCase = ecUpperCase
    TabOrder = 2
    OnExit = btnExcluirClick
  end
end
