unit Model.Tanque;

interface

uses
  Model.Combustivel;

type
  TTanque = class
  private
    FCodigo: Integer;
    FTanque: string;
    FCombustivel: TCombustivel;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Tanque: string read FTanque write FTanque;
    property Combustivel: TCombustivel read FCombustivel write FCombustivel;
  end;

implementation

end.
