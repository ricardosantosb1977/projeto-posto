unit View.Bomba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.ModeloCadastro, Vcl.StdCtrls,
  Vcl.ExtCtrls, Control.Bomba, Control.Tanque, Funcoes, Model.Bomba, Model.Tanque,
  Classe.Helper;

type
  TfrmCadastroBomba = class(TfrmModeloCadastro)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    cmbTanque: TComboBox;
    procedure btnNovoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoExit(Sender: TObject);
  private
    { Private declarations }
    procedure Limpar;
    procedure CarregaCombo;
    function BuscaTanque(pCodigo: Integer): Integer;
    function RetornaProxCodigo: Integer;
  public
    { Public declarations }
  end;

var
  frmCadastroBomba: TfrmCadastroBomba;

implementation

{$R *.dfm}

uses View.Principal;

procedure TfrmCadastroBomba.btnExcluirClick(Sender: TObject);
var
  Controle: TControlBomba;
begin
  inherited;
  if edtCodigo.IsEmpty then
    Exit
  else
  begin
    if Application.MessageBox(PerguntaExclusao, PChar(frmPrincipal.Caption), MB_YESNO) = IDYES then
    begin
      try
        Controle := TControlBomba.Create;
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

procedure TfrmCadastroBomba.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadastroBomba.btnGravarClick(Sender: TObject);
var
  Controle: TControlBomba;
  ControlTanque: TControlTanque;
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

  if TFuncao.CampoVazio(cmbTanque.Text, True) then
  begin
    cmbTanque.SetFocus;
    Exit;
  end;

  try
    Controle := TControlBomba.Create;
    ControlTanque := TControlTanque.Create;

    with Controle do
    begin
      Bomba.Codigo := StrToInt(edtCodigo.Text);
      Bomba.Descricao := edtDescricao.Text;
      Bomba.Tanque := ControlTanque.Consulta(cmbTanque.Text, 'D');
      ExcluirBombaTanque(edtCodigo.Text);

      if not ControlTanque.TanquePermiteBomba(IntToStr(Bomba.Tanque.Codigo)) then
      begin
        ShowMessage('Operação cancelada. A capacidade máxima desse tanque é de duas bombas!');
        Exit;
      end;

      if Gravar then
      begin
        Limpar;
        edtCodigo.SetFocus;
        CarregaCombo;
      end;
    end;
  finally
    Controle.Destroy;
    ControlTanque.Destroy;
  end;
end;

procedure TfrmCadastroBomba.btnNovoClick(Sender: TObject);
begin
  inherited;
  Limpar;
  edtCodigo.SetFocus;
end;

function TfrmCadastroBomba.BuscaTanque(pCodigo: Integer): Integer;
var
  Controle: TControlTanque;
  Tanque: TTanque;
  i: integer;
begin
  Result := -1;
  try
    Controle := TControlTanque.Create;
    Tanque := TTanque.Create;

    Tanque := Controle.Consulta(IntToStr(pCodigo));
    if Tanque.Codigo > 0 then
    begin
      for I := 0 to cmbTanque.Items.Count - 1 do
      begin
        if cmbTanque.Items.Strings[I] = Tanque.Tanque then
          Result := I;
      end;
    end;
  finally
    Controle.Destroy;
    FreeAndNil(Tanque);
  end;
end;

procedure TfrmCadastroBomba.CarregaCombo;
var
  Controle: TControlTanque;
begin
  try
    Controle := TControlTanque.Create;
    try
      cmbTanque.Items := Controle.RetornaLista;
    except
      cmbTanque.Items.Clear;
    end;
  finally
    Controle.Destroy;
  end;
end;

procedure TfrmCadastroBomba.edtCodigoExit(Sender: TObject);
var
  Controle: TControlBomba;
  Bomba: TBomba;
begin
  inherited;
  if edtCodigo.IsEmpty then
    Exit
  else
  begin
    try
      Controle := TControlBomba.Create;
      Bomba := TBomba.Create;
      Bomba := Controle.Consulta(edtCodigo.Text);

      if Bomba.Codigo > 0 then
      begin
        edtCodigo.Text := IntToStr(Bomba.Codigo);
        edtDescricao.Text := Bomba.Descricao;
        cmbTanque.ItemIndex := BuscaTanque(Bomba.Tanque.Codigo);
      end
      else
      begin
        edtDescricao.Text := '';
        cmbTanque.ItemIndex := -1;
      end;
    finally

    end;
  end;
end;

procedure TfrmCadastroBomba.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmCadastroBomba.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfrmCadastroBomba.FormShow(Sender: TObject);
begin
  inherited;
  Limpar;
  CarregaCombo;
end;

procedure TfrmCadastroBomba.Limpar;
begin
  edtCodigo.Text := '';
  edtDescricao.Text := '';
  cmbTanque.ItemIndex := -1;

  RetornaProxCodigo;
end;

function TfrmCadastroBomba.RetornaProxCodigo: Integer;
var
  Controle: TControlBomba;
begin
  try
    Controle := TControlBomba.Create;
    edtCodigo.Text := IntToStr(Controle.RetornaProxCodigo);
  finally
    Controle.Destroy;
  end;
end;

end.
