object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema Posto'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 201
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 360
    Top = 80
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Combustvel1: TMenuItem
        Caption = 'Combust'#237'vel'
        OnClick = Combustvel1Click
      end
      object anque1: TMenuItem
        Caption = 'Tanque'
        OnClick = anque1Click
      end
      object Bomba1: TMenuItem
        Caption = 'Bomba'
        OnClick = Bomba1Click
      end
    end
    object Venda1: TMenuItem
      Caption = 'Venda'
      object VendadeCombustvel1: TMenuItem
        Caption = 'Venda de Combust'#237'vel'
        OnClick = VendadeCombustvel1Click
      end
    end
    object Relatrio1: TMenuItem
      Caption = 'Relat'#243'rio'
      object RelatriodeVendas1: TMenuItem
        Caption = 'Relat'#243'rio de Vendas'
        OnClick = RelatriodeVendas1Click
      end
    end
    object Configurar1: TMenuItem
      Caption = 'Configurar'
      OnClick = Configurar1Click
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      OnClick = Sair1Click
    end
  end
end
