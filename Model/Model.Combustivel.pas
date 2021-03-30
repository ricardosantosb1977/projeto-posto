unit Model.Combustivel;

interface

type
  TCombustivel = class
  private
    FCodigo: Integer;
    FDescricao: String;
    FValor: Double;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property Valor: Double read FValor write FValor;
  end;

implementation

end.
