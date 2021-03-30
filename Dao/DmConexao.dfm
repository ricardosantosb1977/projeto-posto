object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 271
  Width = 313
  object FBConexao: TFDConnection
    Params.Strings = (
      'Database=C:\PROJETO\POSTO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 24
    Top = 8
  end
  object FBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'fbclient.dll'
    Left = 232
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 136
    Top = 8
  end
end
