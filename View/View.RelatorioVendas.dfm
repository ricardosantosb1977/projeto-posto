object frmRelatorioVendas: TfrmRelatorioVendas
  Left = 0
  Top = 0
  Caption = 'frmRelatorioVendas'
  ClientHeight = 661
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = dsVenda
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    BeforePrint = RelatorioBeforePrint
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 68
      BandType = btHeader
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      object RLLabel1: TRLLabel
        Left = 280
        Top = 0
        Width = 158
        Height = 19
        Align = faCenterTop
        Alignment = taCenter
        Caption = 'Relat'#243'rio de Vendas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel2: TRLLabel
        Left = 64
        Top = 48
        Width = 33
        Height = 16
        Caption = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLGroup1: TRLGroup
      Left = 38
      Top = 106
      Width = 718
      Height = 90
      DataFields = 'DATA'
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 21
        BandType = btHeader
        object RLDBText1: TRLDBText
          Left = 64
          Top = 2
          Width = 97
          Height = 16
          DataField = 'DATA'
          DataSource = dsVenda
          Text = ''
        end
      end
      object RLGroup2: TRLGroup
        Left = 0
        Top = 21
        Width = 718
        Height = 65
        DataFields = 'DATA;TANQUE'
        object RLBand4: TRLBand
          Left = 0
          Top = 40
          Width = 718
          Height = 21
          object RLDBText3: TRLDBText
            Left = 252
            Top = 3
            Width = 52
            Height = 16
            DataField = 'BOMBA'
            DataSource = dsVenda
            Text = ''
          end
          object RLDBText4: TRLDBText
            Left = 432
            Top = 3
            Width = 84
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            DataField = 'VALOR'
            DataSource = dsVenda
            Text = ''
          end
        end
        object RLBand3: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 40
          BandType = btColumnHeader
          object RLLabel4: TRLLabel
            Left = 128
            Top = 3
            Width = 56
            Height = 16
            Caption = 'Tanque:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLDBText5: TRLDBText
            Left = 188
            Top = 3
            Width = 57
            Height = 16
            DataField = 'TANQUE'
            DataSource = dsVenda
            Text = ''
          end
          object RLLabel3: TRLLabel
            Left = 250
            Top = 23
            Width = 49
            Height = 16
            Caption = 'Bomba'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLLabel5: TRLLabel
            Left = 478
            Top = 23
            Width = 38
            Height = 16
            Caption = 'Valor'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RLDraw1: TRLDraw
            Left = 127
            Top = 19
            Width = 395
            Height = 4
            DrawKind = dkLine
          end
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 196
      Width = 718
      Height = 23
      BandType = btSummary
      object RLLabel6: TRLLabel
        Left = 250
        Top = 4
        Width = 74
        Height = 16
        Caption = 'Valor Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object TotalGeral: TRLLabel
        Left = 432
        Top = 4
        Width = 84
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,000'
      end
      object RLDraw2: TRLDraw
        Left = 159
        Top = 0
        Width = 360
        Height = 4
        DrawKind = dkLine
      end
    end
  end
  object dsVenda: TDataSource
    DataSet = qrVenda
    Left = 640
    Top = 32
  end
  object qrVenda: TFDQuery
    Active = True
    Connection = DM.FBConexao
    SQL.Strings = (
      'SELECT V.DATA, T.DESCRICAO TANQUE, B.DESCRICAO BOMBA,'
      '       SUM(V.QTDE * V.VALOR + V.VALOR_IMPOSTO) VALOR'
      '  FROM VENDA V'
      ' INNER JOIN BOMBA B ON B.CODIGO = V.BOMBA'
      ' INNER JOIN TANQUE T ON T.CODIGO = B.TANQUE'
      ' GROUP BY V.DATA, T.DESCRICAO, B.DESCRICAO'
      ' ORDER BY V.DATA, T.DESCRICAO')
    Left = 680
    Top = 32
    object qrVendaDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object qrVendaTANQUE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'TANQUE'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qrVendaBOMBA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'BOMBA'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qrVendaVALOR: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#0.000'
      Precision = 18
      Size = 6
    end
  end
end
