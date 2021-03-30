unit Control.Venda;

interface

uses
  Model.Venda, Dao.Venda, DmConexao, System.SysUtils, System.Classes;

type
  TControlVenda = class
    Venda: TVenda;
    Constructor Create;
    Destructor Destroy; override;
    function Gravar: boolean;
    function Excluir(pCodigo: string): Boolean;
    function Consulta(pPesquisa: string): TVenda;
    function RetornaLista: TStringList;
    function RetornaProxCodigo: Integer;
  end;

var
  DaoVenda: TDaoVenda;

implementation

{ TControlVenda }

constructor TControlVenda.Create;
begin
  if not Assigned(Venda) then
    Venda := TVenda.Create;

  if not Assigned(DaoVenda) then
    DaoVenda := TDaoVenda.Create;
end;

destructor TControlVenda.Destroy;
begin
  inherited;
  if Assigned(Venda) then
    FreeAndNil(Venda);

  if Assigned(DaoVenda) then
    FreeAndNil(DaoVenda);
end;

function TControlVenda.Gravar: boolean;
begin
  Result := DaoVenda.Inserir(Venda);
end;

function TControlVenda.Excluir(pCodigo: string): Boolean;
begin
  Result := DaoVenda.Excluir(pCodigo);
end;

function TControlVenda.RetornaLista: TStringList;
begin

end;

function TControlVenda.RetornaProxCodigo: Integer;
begin
  Result := DaoVenda.RetornaProxCodigo;
end;

function TControlVenda.Consulta(pPesquisa: string): TVenda;
begin
  Result := DaoVenda.Consulta(pPesquisa);
end;

end.
