unit Control.Combustivel;

interface

uses
  Model.Combustivel, Dao.Combustivel, DmConexao, System.SysUtils, System.Classes;

type
  TControlCombustivel = class
  public
    Combustivel: TCombustivel;
    Constructor Create;
    Destructor Destroy; override;
    function Gravar: boolean;
    function Excluir(pCodigo: string): Boolean;
    function Consulta(pPesquisa: string; pTipo: string = 'C'): TCombustivel;
    function RetornaLista: TStringList;
    function RetornaProxCodigo: Integer;
  end;

var
  DaoCombustivel: TDaoCombustivel;

implementation

{ TControlCombustivel }

function TControlCombustivel.Consulta(pPesquisa: string; pTipo: string = 'C'): TCombustivel;
begin
  Result := DaoCombustivel.Consulta(pPesquisa, pTipo);
end;

constructor TControlCombustivel.Create;
begin
  if not Assigned(Combustivel) then
    Combustivel := TCombustivel.Create;

  if not Assigned(DaoCombustivel) then
    DaoCombustivel := TDaoCombustivel.Create;
end;

destructor TControlCombustivel.Destroy;
begin
  inherited;
  if Assigned(Combustivel) then
    FreeAndNil(Combustivel);

  if Assigned(DaoCombustivel) then
    FreeAndNil(DaoCombustivel);
end;

function TControlCombustivel.Excluir(pCodigo: string): Boolean;
begin
  Result := DaoCombustivel.Excluir(pCodigo);
end;

function TControlCombustivel.Gravar: boolean;
begin
  Result := DaoCombustivel.Inserir(Combustivel);
end;

function TControlCombustivel.RetornaLista: TStringList;
begin
  Result := DaoCombustivel.RetornaLista;
end;

function TControlCombustivel.RetornaProxCodigo: Integer;
begin
  Result := DaoCombustivel.RetornaProxCodigo;
end;

end.
