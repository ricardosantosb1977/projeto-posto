inherited frmCadastroCombustivel: TfrmCadastroCombustivel
  ActiveControl = edtCodigo
  Caption = 'Cadastro de Combust'#237'vel'
  ClientHeight = 100
  ClientWidth = 400
  KeyPreview = True
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 406
  ExplicitHeight = 129
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
    Left = 58
    Top = 8
    Width = 46
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object Label3: TLabel [2]
    Left = 295
    Top = 8
    Width = 63
    Height = 13
    Caption = 'Valor do Litro'
  end
  inherited Panel1: TPanel
    Top = 59
    Width = 400
    TabOrder = 3
    ExplicitTop = 59
    ExplicitWidth = 400
    inherited btnNovo: TButton
      Left = 77
      OnClick = btnNovoClick
      ExplicitLeft = 77
    end
    inherited btnExcluir: TButton
      Left = 157
      OnClick = btnExcluirClick
      ExplicitLeft = 157
    end
    inherited btnGravar: TButton
      Left = 237
      OnClick = btnGravarClick
      ExplicitLeft = 237
    end
    inherited btnFechar: TButton
      Left = 317
      OnClick = btnFecharClick
      ExplicitLeft = 317
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
    OnExit = edtCodigoExit
    OnKeyPress = edtCodigoKeyPress
  end
  object edtDescricao: TEdit
    Left = 58
    Top = 24
    Width = 233
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 50
    TabOrder = 1
  end
  object edtValor: TEdit
    Left = 295
    Top = 24
    Width = 90
    Height = 21
    Alignment = taRightJustify
    CharCase = ecUpperCase
    MaxLength = 10
    TabOrder = 2
    OnExit = edtValorExit
    OnKeyPress = edtValorKeyPress
  end
end
