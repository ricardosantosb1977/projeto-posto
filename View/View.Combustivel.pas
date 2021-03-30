unit View.Combustivel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.ModeloCadastro, Vcl.StdCtrls,
  Vcl.ExtCtrls, Control.Combustivel, Model.Combustivel, Funcoes, Classe.Helper;

type
  TfrmCadastroCombustivel = class(TfrmModeloCadastro)
    Label1: TLabel;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtValor: TEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Limpar;
    function RetornaProxCodigo: Integer;
  public
    { Public declarations }
  end;

var
  frmCadastroCombustivel: TfrmCadastroCombustivel;

implementation

{$R *.dfm}

uses View.Principal;

procedure TfrmCadastroCombustivel.btnExcluirClick(Sender: TObject);
var
  Controle: TControlCombustivel;
begin
  inherited;
  if edtCodigo.IsEmpty then
    Exit
  else
  begin
    if Application.MessageBox(PerguntaExclusao, PChar(frmPrincipal.Caption), MB_YESNO) = IDYES then
    begin
      try
        Controle := TControlCombustivel.Create;
        if Controle.Excluir(edtCodigo.Text) then
        begin
          Limpar;
          edtCodigo.SetFocus;
        end;
      finally
        Controle.Destroy;
      end;
    end;
  end;
end;

procedure TfrmCadastroCombustivel.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadastroCombustivel.btnGravarClick(Sender: TObject);
var
  Controle: TControlCombustivel;
begin
  inherited;
  if TFuncao.CampoVazio(edtCodigo.Text, True) then
  begin
    edtCodigo.SetFocus;
    Exit;
  end;

  if TFuncao.CampoVazio(edtDescricao.Text, True) then
  begin
    edtDescricao.SetFocus;
    Exit;
  end;

  if not TFuncao.CampoValorValido(edtValor.Text, True) then
  begin
    edtValor.SetFocus;
    Exit;
  end;

  try
    Controle := TControlCombustivel.Create;
    with Controle do
    begin
      Combustivel.Codigo := StrToInt(edtCodigo.Text);
      Combustivel.Descricao := edtDescricao.Text;
      Combustivel.Valor := StrToFloat(edtValor.Text);
      if Gravar then
      begin
        Limpar;
        edtCodigo.SetFocus;
      end;
    end;
  finally
    Controle.Destroy;
  end;

end;

procedure TfrmCadastroCombustivel.btnNovoClick(Sender: TObject);
begin
  inherited;
  Limpar;
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroCombustivel.edtCodigoExit(Sender: TObject);
var
  Controle: TControlCombustivel;
  Combustivel: TCombustivel;
begin
  inherited;
  if edtCodigo.IsEmpty then
    Exit;

  try
    Controle := TControlCombustivel.Create;
    Combustivel := TCombustivel.Create;

    Combustivel := Controle.Consulta(edtCodigo.Text);
    if Combustivel.Codigo > 0 then
    begin
      edtCodigo.Text := IntToStr(Combustivel.Codigo);
      edtDescricao.Text := Combustivel.Descricao;
      edtValor.Text := FormatFloat(MascaraMoeda, Combustivel.Valor);
    end
    else
    begin
      edtDescricao.Text := '';
      edtValor.Text := '';
    end;
  finally
    Controle.Destroy;
    FreeAndNil(Combustivel);
  end;
end;

procedure TfrmCadastroCombustivel.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not(Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmCadastroCombustivel.edtValorExit(Sender: TObject);
begin
  inherited;
  if edtValor.IsEmpty then
    edtValor.Text := '0';
  edtValor.Text := TFuncao.FormataValor(edtValor.Text, True);
end;

procedure TfrmCadastroCombustivel.edtValorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = '.' then
    Key := ',';

  if not(Key in ['0'..'9', #8, ',']) then
    Key := #0;
end;

procedure TfrmCadastroCombustivel.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    perform(WM_NEXTDLGCTL,0,0);
    Key := #0;
  end;
end;

procedure TfrmCadastroCombustivel.FormShow(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TfrmCadastroCombustivel.Limpar;
begin
  edtCodigo.Text := '';
  edtDescricao.Text := '';
  edtValor.Text := '';

  RetornaProxCodigo;
end;

function TfrmCadastroCombustivel.RetornaProxCodigo: Integer;
var
  Controle: TControlCombustivel;
begin
  try
    Controle := TControlCombustivel.Create;
    edtCodigo.Text := IntToStr(Controle.RetornaProxCodigo);
  finally
    Controle.Destroy;
  end;
end;

end.
