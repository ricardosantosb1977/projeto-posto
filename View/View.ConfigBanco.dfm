object frmConfigBanco: TfrmConfigBanco
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configura Caminho do Banco'
  ClientHeight = 124
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 18
    Width = 88
    Height = 13
    Caption = 'Caminho do Banco'
  end
  object SpeedButton1: TSpeedButton
    Left = 249
    Top = 33
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object edtCaminho: TEdit
    Left = 16
    Top = 34
    Width = 232
    Height = 21
    TabOrder = 0
  end
  object btnGravar: TButton
    Left = 48
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 1
    OnClick = btnGravarClick
  end
  object btnFechar: TButton
    Left = 144
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 2
    OnClick = btnFecharClick
  end
  object odAbrir: TOpenDialog
    Left = 240
    Top = 72
  end
end
