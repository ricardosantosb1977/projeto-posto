inherited frmVendaCombustivel: TfrmVendaCombustivel
  Caption = 'Venda de Combust'#237'vel'
  ClientHeight = 189
  ClientWidth = 356
  KeyPreview = True
  OnShow = FormShow
  ExplicitWidth = 362
  ExplicitHeight = 218
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 51
    Width = 32
    Height = 13
    Caption = 'Bomba'
  end
  object Label2: TLabel [1]
    Left = 158
    Top = 51
    Width = 58
    Height = 13
    Caption = 'Combust'#237'vel'
  end
  object Label3: TLabel [2]
    Left = 262
    Top = 51
    Width = 24
    Height = 13
    Caption = 'Valor'
  end
  object Label4: TLabel [3]
    Left = 8
    Top = 96
    Width = 52
    Height = 13
    Caption = 'Qtde. Litro'
  end
  object Label5: TLabel [4]
    Left = 83
    Top = 96
    Width = 66
    Height = 13
    Caption = 'Total (+13%)'
  end
  object Código: TLabel [5]
    Left = 8
    Top = 8
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Label6: TLabel [6]
    Left = 59
    Top = 8
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  inherited Panel1: TPanel
    Top = 148
    Width = 356
    TabOrder = 7
    ExplicitTop = 148
    ExplicitWidth = 356
    inherited btnNovo: TButton
      Left = 33
      OnClick = btnNovoClick
      ExplicitLeft = 33
    end
    inherited btnExcluir: TButton
      Left = 113
      OnClick = btnExcluirClick
      ExplicitLeft = 113
    end
    inherited btnGravar: TButton
      Left = 193
      OnClick = btnGravarClick
      ExplicitLeft = 193
    end
    inherited btnFechar: TButton
      Left = 273
      OnClick = btnFecharClick
      ExplicitLeft = 273
    end
  end
  object cmbBomba: TComboBox
    Left = 8
    Top = 67
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    CharCase = ecUpperCase
    TabOrder = 2
    OnExit = cmbBombaExit
    OnKeyPress = cmbBombaKeyPress
  end
  object pnCombustivel: TPanel
    Left = 158
    Top = 67
    Width = 100
    Height = 23
    Alignment = taLeftJustify
    BevelKind = bkSoft
    BevelOuter = bvNone
    BorderWidth = 3
    Caption = 'pnCombustivel'
    Color = clWhite
    ParentBackground = False
    TabOrder = 4
  end
  object pnValor: TPanel
    Left = 262
    Top = 67
    Width = 80
    Height = 23
    Alignment = taRightJustify
    BevelKind = bkSoft
    BevelOuter = bvNone
    BorderWidth = 3
    Caption = '0,00'
    Color = clWhite
    ParentBackground = False
    TabOrder = 5
  end
  object edtQtd: TEdit
    Left = 8
    Top = 112
    Width = 70
    Height = 21
    Alignment = taRightJustify
    TabOrder = 3
    Text = '0,00'
    OnExit = edtQtdExit
    OnKeyPress = edtQtdKeyPress
  end
  object pnTotal: TPanel
    Left = 83
    Top = 112
    Width = 80
    Height = 23
    Alignment = taRightJustify
    BevelKind = bkSoft
    BevelOuter = bvNone
    BorderWidth = 3
    Caption = '0,00'
    Color = clWhite
    ParentBackground = False
    TabOrder = 6
  end
  object edtCodigo: TEdit
    Left = 8
    Top = 24
    Width = 45
    Height = 21
    Alignment = taRightJustify
    TabOrder = 0
    Text = 'edtCodigo'
    OnExit = edtCodigoExit
    OnKeyPress = edtCodigoKeyPress
  end
  object mskData: TMaskEdit
    Left = 58
    Top = 24
    Width = 80
    Height = 21
    EditMask = '##/##/####;1; '
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
    OnEnter = mskDataEnter
    OnExit = mskDataExit
    OnKeyPress = mskDataKeyPress
  end
end
