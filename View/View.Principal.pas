unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB, Vcl.ExtCtrls,
  FireDAC.Comp.Client;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Sair1: TMenuItem;
    anque1: TMenuItem;
    Combustvel1: TMenuItem;
    Bomba1: TMenuItem;
    Venda1: TMenuItem;
    VendadeCombustvel1: TMenuItem;
    Panel2: TPanel;
    Relatrio1: TMenuItem;
    RelatriodeVendas1: TMenuItem;
    Configurar1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure anque1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Combustvel1Click(Sender: TObject);
    procedure Bomba1Click(Sender: TObject);
    procedure VendadeCombustvel1Click(Sender: TObject);
    procedure RelatriodeVendas1Click(Sender: TObject);
    procedure Configurar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses View.Tanque, View.Combustivel, View.Bomba, View.Venda, View.RelatorioVendas,
     View.ConfigBanco;

{$R *.dfm}

procedure TFrmPrincipal.anque1Click(Sender: TObject);
var
  frmTanque: TfrmCadastroTanque;
begin
  frmTanque := TfrmCadastroTanque.Create(Self);
  frmTanque.ShowModal;
end;

procedure TFrmPrincipal.Bomba1Click(Sender: TObject);
var
  frmBomba: TfrmCadastroBomba;
begin
  frmBomba := TfrmCadastroBomba.Create(self);
  frmBomba.ShowModal;
end;

procedure TFrmPrincipal.Combustvel1Click(Sender: TObject);
var
  frmCombustivel: TfrmCadastroCombustivel;
begin
  frmCombustivel := TfrmCadastroCombustivel.Create(Self);
  frmCombustivel.ShowModal;
end;

procedure TFrmPrincipal.Configurar1Click(Sender: TObject);
var
  frmConfig: TfrmConfigBanco;
begin
  frmConfig := TfrmConfigBanco.Create(Self);
  frmConfig.ShowModal;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  FrmPrincipal.WindowState := wsMaximized;
end;

procedure TFrmPrincipal.RelatriodeVendas1Click(Sender: TObject);
var
  frmRelVendas: TfrmRelatorioVendas;
begin
  frmRelVendas := TfrmRelatorioVendas.Create(Self);
  if frmRelVendas.qrVenda.Active = False then
    frmRelVendas.qrVenda.Open;
  frmRelVendas.Relatorio.Preview;
  frmRelVendas.qrVenda.Close;
end;

procedure TFrmPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrincipal.VendadeCombustvel1Click(Sender: TObject);
var
  frmVenda: TfrmVendaCombustivel;
begin
  frmVenda := TfrmVendaCombustivel.Create(Self);
  frmVenda.ShowModal;
end;

end.
