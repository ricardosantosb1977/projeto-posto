unit Model.Bomba;

interface

uses
  Model.Tanque;

type
  TBomba = class
  private
    FCodigo: integer;
    FDescricao: string;
    FTanque: TTanque;
  public
    property Codigo: integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property Tanque: TTanque read FTanque write FTanque;
  end;

implementation

end.
