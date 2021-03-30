unit View.Tanque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.ModeloCadastro, Vcl.StdCtrls,
  Vcl.ExtCtrls, Control.Tanque, Control.Combustivel, Model.Combustivel, Funcoes,
  Model.Tanque, Classe.Helper;

type
  TfrmCadastroTanque = class(TfrmModeloCadastro)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodigo: TEdit;
    edtTanque: TEdit;
    cmbCombutivel: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Limpar;
    procedure CarregaCombo;
    function BuscaCombustivel(pCodigo: Integer): Integer;
    function RetornaProxCodigo: Integer;
  public
    { Public declarations }
  end;

var
  frmCadastroTanque: TfrmCadastroTanque;

implementation

{$R *.dfm}

uses View.Principal;

procedure TfrmCadastroTanque.btnExcluirClick(Sender: TObject);
var
  Controle: TControlTanque;
begin
  inherited;
  if edtCodigo.IsEmpty then
    Exit
  else
  begin
    if Application.MessageBox(PerguntaExclusao, PChar(frmPrincipal.Caption), MB_YESNO) = IDYES then
    begin
      try
        Controle := TControlTanque.Create;
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

procedure TfrmCadastroTanque.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadastroTanque.btnGravarClick(Sender: TObject);
var
  Controle: TControlTanque;
  ControlCombustivel: TControlCombustivel;
begin
  inherited;
  if TFuncao.CampoVazio(edtCodigo.Text, True) then
  begin
    edtCodigo.SetFocus;
    Exit;
  end;

  if TFuncao.CampoVazio(edtTanque.Text, True) then
  begin
    edtTanque.SetFocus;
    Exit;
  end;

  if TFuncao.CampoVazio(cmbCombutivel.Text, True) then
  begin
    cmbCombutivel.SetFocus;
    Exit;
  end;

  try
    Controle := TControlTanque.Create;
    ControlCombustivel := TControlCombustivel.Create;
    with Controle do
    begin
      Tanque.Codigo := StrToInt(edtCodigo.Text);
      Tanque.Tanque := edtTanque.Text;
      Tanque.Combustivel := ControlCombustivel.Consulta(cmbCombutivel.Text, 'D');
      if Gravar then
      begin
        Limpar;
        edtCodigo.SetFocus;
      end;
    end;
  finally
    Controle.Destroy;
    ControlCombustivel.Destroy;
  end;
end;

procedure TfrmCadastroTanque.btnNovoClick(Sender: TObject);
begin
  inherited;
  Limpar;
  edtCodigo.SetFocus;
end;

function TfrmCadastroTanque.BuscaCombustivel(pCodigo: Integer): Integer;
var
  Controle: TControlCombustivel;
  Combustivel: TCombustivel;
  i: integer;
begin
  Result := -1;
  try
    Controle := TControlCombustivel.Create;
    Combustivel := TCombustivel.Create;

    Combustivel := Controle.Consulta(IntToStr(pCodigo));
    if Combustivel.Codigo > 0 then
    begin
      for I := 0 to cmbCombutivel.Items.Count - 1 do
      begin
        if cmbCombutivel.Items.Strings[I] = Combustivel.Descricao then
          Result := I;
      end;
    end;
  finally
    Controle.Destroy;
    FreeAndNil(Combustivel);
  end;
end;

procedure TfrmCadastroTanque.CarregaCombo;
var
  Controle: TControlCombustivel;
begin
  try
    Controle := TControlCombustivel.Create;
    try
      cmbCombutivel.Items := Controle.RetornaLista;
    except
      cmbCombutivel.Items.Clear;
    end;
  finally
    Controle.Destroy;
  end;
end;

procedure TfrmCadastroTanque.edtCodigoExit(Sender: TObject);
var
  Controle: TControlTanque;
  Tanque: TTanque;
begin
  inherited;
  if edtCodigo.IsEmpty then
    Exit;

  try
    Controle := TControlTanque.Create;
    Tanque := TTanque.Create;

    Tanque := Controle.Consulta(edtCodigo.Text);
    if Tanque.Codigo > 0 then
    begin
      edtCodigo.Text := IntToStr(Tanque.Codigo);
      edtTanque.Text := Tanque.Tanque;
      cmbCombutivel.ItemIndex := BuscaCombustivel(Tanque.Combustivel.Codigo);
    end
    else
    begin
      edtTanque.Text := '';
      cmbCombutivel.ItemIndex := -1;
    end;
  finally
    Controle.Destroy;
    FreeAndNil(Tanque);
  end;
end;

procedure TfrmCadastroTanque.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmCadastroTanque.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    perform(WM_NEXTDLGCTL,0,0);
    Key := #0;
  end;
end;

procedure TfrmCadastroTanque.FormShow(Sender: TObject);
begin
  inherited;
  Limpar;
  CarregaCombo;
end;

procedure TfrmCadastroTanque.Limpar;
begin
  edtCodigo.Text := '';
  edtTanque.Text := '';
  cmbCombutivel.ItemIndex := -1;

  RetornaProxCodigo;
end;

function TfrmCadastroTanque.RetornaProxCodigo: Integer;
var
  Controle: TControlTanque;
begin
  try
    Controle := TControlTanque.Create;
    edtCodigo.Text := IntToStr(Controle.RetornaProxCodigo);
  finally
    Controle.Destroy;
  end;
end;

end.
