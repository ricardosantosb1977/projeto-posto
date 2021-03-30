unit View.Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.ModeloCadastro, Vcl.StdCtrls, Vcl.ExtCtrls, Control.Venda, Control.Bomba,
  Model.Venda, Model.Bomba, Vcl.Mask, Funcoes, Classe.Helper;

type
  TfrmVendaCombustivel = class(TfrmModeloCadastro)
    Label1: TLabel;
    cmbBomba: TComboBox;
    pnCombustivel: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    pnValor: TPanel;
    Label4: TLabel;
    edtQtd: TEdit;
    Label5: TLabel;
    pnTotal: TPanel;
    Código: TLabel;
    edtCodigo: TEdit;
    Label6: TLabel;
    mskData: TMaskEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure mskDataEnter(Sender: TObject);
    procedure mskDataExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure mskDataKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBombaKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdKeyPress(Sender: TObject; var Key: Char);
    procedure cmbBombaExit(Sender: TObject);
    procedure edtQtdExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    procedure Limpar;
    procedure CarregaCombo;
    function BuscaBomba(pBomba: string): Integer;
    function RetornaProxCodigo: Integer;
  public
    { Public declarations }
  end;

var
  frmVendaCombustivel: TfrmVendaCombustivel;

implementation

{$R *.dfm}

uses View.Principal;

procedure TfrmVendaCombustivel.btnExcluirClick(Sender: TObject);
var
  Controle: TControlVenda;
begin
  inherited;
  if edtCodigo.IsEmpty then
    Exit
  else
  begin
    if Application.MessageBox(PerguntaExclusao, PChar(frmPrincipal.Caption), MB_YESNO) = IDYES then
    begin
      try
        Controle := TControlVenda.Create;
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

procedure TfrmVendaCombustivel.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmVendaCombustivel.btnGravarClick(Sender: TObject);
var
  Controle: TControlVenda;
  ControlBomba: TControlBomba;
begin
  inherited;
  if TFuncao.CampoVazio(edtCodigo.Text, True) then
  begin
    edtCodigo.SetFocus;
    Exit;
  end;

  if not TFuncao.ValidaData(mskData.Text, True) then
  begin
    mskData.SetFocus;
    Exit;
  end;

  if TFuncao.CampoVazio(cmbBomba.Text, True) then
  begin
    cmbBomba.SetFocus;
    Exit;
  end;

  if StrToFloatDef(edtQtd.Text, 0) = 0 then
  begin
    ShowMessage('Quantidade não pode ser zero!');
    edtQtd.SetFocus;
    Exit;
  end;

  try
    Controle := TControlVenda.Create;
    ControlBomba := TControlBomba.Create;
    with Controle do
    begin
      Venda.Codigo := StrToInt(edtCodigo.Text);
      Venda.Bomba := ControlBomba.Consulta(cmbBomba.Text, 'D');
      Venda.Qtde := StrToFloat(edtQtd.Text);
      Venda.Data := StrToDate(mskData.Text);
      Venda.Valor := StrToFloat(pnValor.Caption);
      Venda.Valor_Imposto := StrToFloat(pnValor.Caption) * 13 / 100;
      Controle.Gravar;
      Limpar;
      edtCodigo.SetFocus;
      ShowMessage(Funcoes.MensagemSalva);
    end;
  finally
    Controle.Destroy;
    ControlBomba.Destroy;
  end;
end;

procedure TfrmVendaCombustivel.btnNovoClick(Sender: TObject);
begin
  inherited;
  Limpar;
  cmbBomba.SetFocus;
end;

function TfrmVendaCombustivel.BuscaBomba(pBomba: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for I := 0 to cmbBomba.Items.Count - 1 do
    if cmbBomba.Items.Strings[i] = pBomba then
      Result := i;
end;

procedure TfrmVendaCombustivel.Button1Click(Sender: TObject);
var
  Controle: TControlVenda;
  ControlBomba: TControlBomba;
begin
  inherited;
  if TFuncao.CampoVazio(edtCodigo.Text, True) then
  begin
    edtCodigo.SetFocus;
    Exit;
  end;

  if not TFuncao.ValidaData(mskData.Text, True) then
  begin
    mskData.SetFocus;
    Exit;
  end;

  if TFuncao.CampoVazio(cmbBomba.Text, True) then
  begin
    cmbBomba.SetFocus;
    Exit;
  end;

  if StrToFloatDef(edtQtd.Text, 0) = 0 then
  begin
    ShowMessage('Quantidade não pode ser zero!');
    edtQtd.SetFocus;
    Exit;
  end;

  try
    Controle := TControlVenda.Create;
    ControlBomba := TControlBomba.Create;
    with Controle do
    begin
      Venda.Codigo := StrToInt(edtCodigo.Text);
      Venda.Bomba := ControlBomba.Consulta(cmbBomba.Text, 'D');
      Venda.Qtde := StrToFloat(edtQtd.Text);
      Venda.Data := StrToDate(mskData.Text);
      Venda.Valor := StrToFloat(pnValor.Caption);
      Venda.Valor_Imposto := StrToFloat(pnValor.Caption) * 13 / 100;
      Controle.Gravar;
      Limpar;
      edtCodigo.SetFocus;
      ShowMessage(Funcoes.MensagemSalva);
    end;
  finally
    Controle.Destroy;
    ControlBomba.Destroy;
  end;
end;

procedure TfrmVendaCombustivel.CarregaCombo;
var
  Controle: TControlBomba;
begin
  Controle := TControlBomba.Create;
  cmbBomba.Items.Clear;
  cmbBomba.Items := Controle.RetornaLista;
end;

procedure TfrmVendaCombustivel.cmbBombaExit(Sender: TObject);
var
  Controle: TControlBomba;
  Bomba: TBomba;
begin
  inherited;
  try
    Controle := TControlBomba.Create;
    Bomba := Controle.Consulta(cmbBomba.Text, 'D');
    if Bomba.Codigo > 0 then
    begin
      pnCombustivel.Caption := Bomba.Tanque.Combustivel.Descricao;
      pnValor.Caption := FormatFloat(MascaraMoeda, Bomba.Tanque.Combustivel.Valor);
    end;
  finally
    Controle.Destroy;
    FreeAndNil(Bomba);
  end;
end;

procedure TfrmVendaCombustivel.cmbBombaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    edtQtd.SetFocus;
    Key := #0;
  end;
end;

procedure TfrmVendaCombustivel.edtCodigoExit(Sender: TObject);
var
  Controle: TControlVenda;
  Venda: TVenda;
  vValorComImposto: Double;
begin
  inherited;
  if edtCodigo.IsEmpty then
    Exit
  else
  begin
    try
      Controle := TControlVenda.Create;
      Venda := TVenda.Create;
      Venda := Controle.Consulta(edtCodigo.Text);

      if Venda.Codigo > 0 then
      begin
        edtCodigo.Text := IntToStr(Venda.Codigo);
        cmbBomba.ItemIndex := BuscaBomba(Venda.Bomba.Descricao);
        mskData.Text := FormatDateTime('dd/mm/yyyy', Venda.Data);
        pnCombustivel.Caption := Venda.Bomba.Tanque.Combustivel.Descricao;
        pnValor.Caption := FormatFloat(MascaraMoeda, Venda.Valor);
        vValorComImposto := Venda.Valor_Imposto + Venda.Valor;
        pnTotal.Caption := FormatFloat(MascaraMoeda, Venda.Qtde * vValorComImposto);
        edtQtd.Text := FormatFloat(MascaraMoeda, Venda.Qtde);
      end
      else
      begin
        cmbBomba.ItemIndex := -1;
        mskData.Text := '';
        pnCombustivel.Caption := '';
        pnValor.Caption := '';
        pnTotal.Caption := '';
        edtQtd.Text := '';
      end;
    finally
      Controle.Destroy;
      FreeAndNil(Venda);
    end;
  end;
end;

procedure TfrmVendaCombustivel.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    mskData.SetFocus;
    Key := #0;
  end;

  if not(Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmVendaCombustivel.edtQtdExit(Sender: TObject);
var
  vValorComImposto: Double;
begin
  inherited;
  edtQtd.Text := FormatFloat(MascaraMoeda, StrToFloatDef(edtQtd.Text, 0));
  vValorComImposto := TFuncao.CalculaValorComImposto(StrToFloatDef(pnValor.Caption, 0));
  pnTotal.Caption := FormatFloat(MascaraMoeda, StrToFloatDef(edtQtd.Text, 0) * vValorComImposto);
end;

procedure TfrmVendaCombustivel.edtQtdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    perform(WM_NEXTDLGCTL,0,0);
    Key := #0;
  end;

  if not(Key in ['0'..'9', #8, ',']) then
    Key := #0;
end;

procedure TfrmVendaCombustivel.FormShow(Sender: TObject);
begin
  inherited;
  Limpar;
  CarregaCombo;
end;

procedure TfrmVendaCombustivel.Limpar;
begin
  edtCodigo.Text := '';
  mskData.Text := '';
  cmbBomba.ItemIndex := -1;
  pnCombustivel.Caption := '';
  pnValor.Caption := '';
  edtQtd.Text := '';
  pnTotal.Caption := '';

  RetornaProxCodigo;
end;

procedure TfrmVendaCombustivel.mskDataEnter(Sender: TObject);
begin
  inherited;
  if mskData.Text = '  /  /    ' then
    mskData.Text := FormatDateTime('dd/mm/yyyy', Date);
end;

procedure TfrmVendaCombustivel.mskDataExit(Sender: TObject);
begin
  inherited;
  if not TFuncao.ValidaData(mskData.Text, True) then
    mskData.SetFocus;
end;

procedure TfrmVendaCombustivel.mskDataKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    cmbBomba.SetFocus;
    Key := #0;
  end;
end;

function TfrmVendaCombustivel.RetornaProxCodigo: Integer;
var
  Controle: TControlVenda;
begin
  try
    Controle := TControlVenda.Create;
    edtCodigo.Text := IntToStr(Controle.RetornaProxCodigo);
  finally
    Controle.Destroy;
  end;
end;

end.
