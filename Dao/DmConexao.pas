unit DmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, IniFiles, View.ConfigBanco, Vcl.Dialogs;

type
  TDM = class(TDataModule)
    FBConexao: TFDConnection;
    FBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Caminho: String;
    procedure CarregaArquivo;
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.CarregaArquivo;
var
  arquivoIni: TIniFile;
begin
  if FileExists('C:\PROJETO\CONFIG.INI') then
  begin
  arquivoIni := TIniFile.Create('C:\PROJETO\CONFIG.INI');
    try
      Caminho := arquivoIni.ReadString('CONFIG', 'Caminho', Caminho);
    finally
      arquivoIni.Free;
    end;
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var
  frmConfig: TfrmConfigBanco;
begin
  CarregaArquivo;
  try
    with FBConexao do
    begin
      Params.Strings[0] := 'Database='+Caminho+'\POSTO.FDB';
      Connected := True;
    end;
  except
    ShowMessage('É necessário configurar o caminho do banco de dados.');
    frmConfig := TfrmConfigBanco.Create(Self);
    frmConfig.ShowModal;
  end;
end;

end.
