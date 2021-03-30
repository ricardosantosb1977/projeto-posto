program SistemaPosto;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {FrmPrincipal},
  View.ModeloCadastro in 'View\View.ModeloCadastro.pas' {frmModeloCadastro},
  View.Tanque in 'View\View.Tanque.pas' {frmCadastroTanque},
  View.Combustivel in 'View\View.Combustivel.pas' {frmCadastroCombustivel},
  Model.Tanque in 'Model\Model.Tanque.pas',
  Model.Combustivel in 'Model\Model.Combustivel.pas',
  Model.Bomba in 'Model\Model.Bomba.pas',
  View.Bomba in 'View\View.Bomba.pas' {frmCadastroBomba},
  DmConexao in 'Dao\DmConexao.pas' {DM: TDataModule},
  Dao.Tanque in 'Dao\Dao.Tanque.pas',
  Dao.Combustivel in 'Dao\Dao.Combustivel.pas',
  Control.Combustivel in 'Control\Control.Combustivel.pas',
  Funcoes in 'Classe\Funcoes.pas',
  Control.Tanque in 'Control\Control.Tanque.pas',
  Dao.Bomba in 'Dao\Dao.Bomba.pas',
  Control.Bomba in 'Control\Control.Bomba.pas',
  View.Venda in 'View\View.Venda.pas' {frmVendaCombustivel},
  Model.Venda in 'Model\Model.Venda.pas',
  Dao.Venda in 'Dao\Dao.Venda.pas',
  Control.Venda in 'Control\Control.Venda.pas',
  View.RelatorioVendas in 'View\View.RelatorioVendas.pas' {frmRelatorioVendas},
  Classe.Helper in 'Classe\Classe.Helper.pas',
  View.ConfigBanco in 'View\View.ConfigBanco.pas' {frmConfigBanco};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Sistema Posto';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
