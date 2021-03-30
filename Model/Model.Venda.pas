unit Model.Venda;

interface

uses
  Model.Bomba;

type
  TVenda = class
  private
    FCodigo: Integer;
    FBomba: TBomba;
    FQtde: Double;
    FValor: Double;
    FValor_Imposto: Double;
    FData: TDate;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Bomba: TBomba read FBomba write FBomba;
    property Qtde: Double read FQtde write FQtde;
    property Valor: Double read FValor write FValor;
    property Valor_Imposto: Double read FValor_Imposto write FValor_Imposto;
    property Data: TDate read FData write FData;
  end;

implementation

end.
