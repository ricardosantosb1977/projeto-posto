unit View.ModeloCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmModeloCadastro = class(TForm)
    Panel1: TPanel;
    btnNovo: TButton;
    btnExcluir: TButton;
    btnGravar: TButton;
    btnFechar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModeloCadastro: TfrmModeloCadastro;

implementation

{$R *.dfm}

end.
