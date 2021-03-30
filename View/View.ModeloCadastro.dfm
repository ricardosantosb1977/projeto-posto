object frmModeloCadastro: TfrmModeloCadastro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'frmModeloCadastro'
  ClientHeight = 211
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 170
    Width = 457
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      457
      41)
    object btnNovo: TButton
      Left = 134
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Novo'
      TabOrder = 0
    end
    object btnExcluir: TButton
      Left = 214
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Excluir'
      TabOrder = 1
    end
    object btnGravar: TButton
      Left = 294
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Gravar'
      TabOrder = 2
    end
    object btnFechar: TButton
      Left = 374
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      TabOrder = 3
    end
  end
end
