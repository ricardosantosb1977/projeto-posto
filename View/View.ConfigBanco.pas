unit View.ConfigBanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, IniFiles, Classe.Helper;

type
  TfrmConfigBanco = class(TForm)
    Label1: TLabel;
    edtCaminho: TEdit;
    btnGravar: TButton;
    btnFechar: TButton;
    SpeedButton1: TSpeedButton;
    odAbrir: TOpenDialog;
    procedure btnFecharClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaArquivo;
  public
    { Public declarations }
  end;

var
  frmConfigBanco: TfrmConfigBanco;

implementation

{$R *.dfm}

uses DmConexao, View.Principal;

procedure TfrmConfigBanco.btnFecharClick(Sender: TObject);
begin
  if DM.FBConexao.Connected = False then
    frmPrincipal.Close;
  Close;
end;

procedure TfrmConfigBanco.btnGravarClick(Sender: TObject);
var
  arquivoIni: TIniFile;
begin
  if not DirectoryExists('C:\PROJETO') then
    CreateDir('C:\PROJETO');

  arquivoIni := TIniFile.Create('C:\PROJETO\CONFIG.INI');
  try
    arquivoIni.WriteString('CONFIG', 'Caminho', edtCaminho.Text);
  finally
    arquivoIni.Free;
  end;

  try
    with DM.FBConexao do
    begin
      Connected := False;
      Params.Strings[0] := 'Database='+edtCaminho.Text+'\POSTO.FDB';
      Connected := True;
    end;
  except
    ShowMessage('Erro de conexão! Verifique o caminho.');
    Exit;
  end;
end;

procedure TfrmConfigBanco.CarregaArquivo;
var
  arquivoIni: TIniFile;
begin
  if FileExists('C:\PROJETO\CONFIG.INI') then
  begin
  arquivoIni := TIniFile.Create('C:\PROJETO\CONFIG.INI');
    try
      edtCaminho.Text := arquivoIni.ReadString('CONFIG', 'Caminho', edtCaminho.Text);
    finally
      arquivoIni.Free;
    end;
  end;
end;

procedure TfrmConfigBanco.FormShow(Sender: TObject);
begin
  CarregaArquivo;
end;

procedure TfrmConfigBanco.SpeedButton1Click(Sender: TObject);
begin
  if odAbrir.Execute then
  begin
    edtCaminho.Text := Copy(ExtractFilePath(odAbrir.FileName), 1, Length(ExtractFilePath(odAbrir.FileName)) - 1);
  end;
end;

end.
